<#
.SYNOPSIS
    Creates a new Freshservice Problem.

.DESCRIPTION
    Creates a new Freshservice Problem via REST API.

    https://api.freshservice.com/#create_problem

.PARAMETER workspace_id
    Workspace ID of the Problem. The attribute is applicable only for accounts with the 'Workspaces' feature enabled. The default value is the ID of the primary workspace of the account.

.PARAMETER agent_id
    Unique identifier of the agent to whom the Problem is assigned

.PARAMETER requester_id
    Unique identifier of the initiator of the problem.

.PARAMETER group_id
    Unique identifier of the agent group to which the Problem is assigned

.PARAMETER description
    HTML content of the problem. Description and description_html should not be passed together

.PARAMETER priority
    Priority of the Problem 1-Low, 2-Medium, 3-High, 4-Urgent

.PARAMETER status
    Status identifier of the Problem. 1-Open, 2-Change Requested, 3-Closed

.PARAMETER impact
    Impact of the Problem. 1-Low, 2-Medium, 3-High

.PARAMETER known_error
    States that the problem is known issue or not. true or false

.PARAMETER subject
    Subject of the Problem

.PARAMETER due_by
    Timestamp at which Problem due ends

.PARAMETER department_id
    Unique ID of the department initiating the Problem

.PARAMETER category
    Category of the Problem

.PARAMETER sub_category
    Sub-category of the Problem

.PARAMETER item_category
    Item of the Problem

.PARAMETER custom_fields
    Key value pairs containing the names and values of custom fields.

.PARAMETER assets
    List of assets associated with the problem.

.PARAMETER attachments
    Path to attachment(s).

.PARAMETER problem_cause
    Problem cause description.

.PARAMETER problem_symptom
    Problem symptom description

.PARAMETER problem_impact
    Problem impact description

.EXAMPLE
    New-FreshServiceProblem -requester_id 21000418005 -description "A new problem" -status 1 -impact 1 -priority 1 -subject "A new problem" -due_by (Get-Date).AddDays(5) -problem_impact "This is the impact of this problem" -known_error $true -category "Hardware" -sub_category 'Peripherals' -item_category 'Router' -problem_cause "The cause of the problem" -problem_symptom "The symptom of the problem"

    id                : 14
    agent_id          :
    description       : <div>A new problem</div>
    description_text  : A new problem
    assets            : {}
    requester_id      : 21000418005
    subject           : A new problem
    group_id          :
    priority          : 1
    impact            : 1
    status            : 1
    due_by            : 4/17/2023 3:05:29 AM
    known_error       : True
    department_id     :
    category          : Hardware
    sub_category      : Peripherals
    item_category     : Router
    created_at        : 4/12/2023 3:05:29 AM
    updated_at        : 4/12/2023 3:05:29 AM
    associated_change :
    custom_fields     :
    analysis_fields   : @{problem_cause=; problem_impact=; problem_symptom=}

    Creates a Freshservice Problem.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceProblem {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Workspace ID of the ticket. The attribute is applicable only for accounts with the Workspaces feature enabled. The default value is the ID of the primary workspace of the account.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$workspace_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent to whom the Problem is assigned',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique identifier of the initiator of the problem.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$requester_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent group to which the Problem is assigned',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'HTML content of the problem. Description and description_html should not be passed together',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Priority of the Problem 1-Low, 2-Medium, 3-High, 4-Urgent',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,4)]
        [int]$priority,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Status identifier of the Problem. 1-Open, 2-Change Requested, 3-Closed ',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,3)]
        [int]$status,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Impact of the Problem. 1-Low, 2-Medium, 3-High ',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,3)]
        [int]$impact,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'States that the problem is known issue or not. true or false',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$known_error,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Subject of the Problem ',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$subject,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Timestamp at which Problem due ends ',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$due_by,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the department initiating the Problem',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Category of the Problem',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Sub-category of the Problem',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$sub_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Item of the Problem',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$item_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$custom_fields,
        # [Parameter(
        #     Mandatory = $false,
        #     HelpMessage = 'Key value pairs containing the names and values of Problem Cause, Problem Symptom and Problem Impact',
        #     ValueFromPipelineByPropertyName = $true
        # )]
        # [hashtable]$analysis_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of assets associated with the problem',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$assets,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket attachments. The total size of these attachments cannot exceed 15MB.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw ("Cannot find path {0} because it does not exist." -f $_.FullName)
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw ("{0} is not a valid file. Folder paths are not allowed." -f $_.FullName)
            }
            if($_.Length/1MB -gt 15 ) {
                throw ("{0} exceeds the file size limit. Files must be under 15MB." -f $_.FullName)
            }
            return $true
        })]
        [System.IO.FileInfo[]]$attachments,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Problem cause description',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$problem_cause,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Problem symptom description',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$problem_symptom,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Problem impact description',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$problem_impact
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/problems' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $af = @{}

        if ($PSBoundParameters.ContainsKey('problem_cause')) {
            $af.Add('problem_cause',@{'description'=$problem_cause})
            [void]$PSBoundParameters.Remove('problem_cause')
        }

        if ($PSBoundParameters.ContainsKey('problem_symptom')) {
            $af.Add('problem_symptom',@{'description'=$problem_symptom})
            [void]$PSBoundParameters.Remove('problem_symptom')
        }

        if ($PSBoundParameters.ContainsKey('problem_impact')) {
            $af.Add('problem_impact',@{'description'=$problem_impact})
            [void]$PSBoundParameters.Remove('problem_impact')
        }

        if ($af.Count -gt 0){$PSBoundParameters['analysis_fields'] = $af}

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ($PSBoundParameters[$PSItem] -is [datetime]) {
                $jsonBody[$PSItem.ToLower()] = (Get-Date -Date $PSBoundParameters[$PSItem]).ToUniversalTime().ToString("yyyy-MM-ddThh:mm:ssZ")
            }
            else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
                    ErrorAction = 'Stop'
                }

                if ( $attachments ) {
                    if ( $PSVersionTable.PSVersion.Major -lt 7 ) {
                        Write-Warning "Sorry! Attachments are not currently supported in versions earlier than Powershell 7.x due to multipart/form-data requirements. Attachment parameter will be ignored."
                        $jsonBody.Remove('attachments')
                        $params.Body = $jsonBody | ConvertTo-Json
                    }
                    else {
                        #Invoke-WebRequest -Form is supported in 7+
                        $jsonBody.Add('attachments[]',$attachments)
                        $jsonBody.Remove('attachments')
                        $params.Form = $jsonBody
                    }
                }
                else {
                    $params.Body = $jsonBody | ConvertTo-Json
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json

                if ($content) {
                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
