<#
.SYNOPSIS
    Updates a Freshservice Problem.

.DESCRIPTION
    Updates a Freshservice Problem via REST API.

    https://api.freshservice.com/#update_problem_priority

.PARAMETER Id
    Unique identifier of the Problem.

.PARAMETER agent_id
    Unique identifier of the agent to whom the Problem is assigned

.PARAMETER requester_id
    Unique identifier of the initiator of the problem.

.PARAMETER group_id
    Unique identifier of the agent group to which the Problem is assigned

.PARAMETER description
    HTML content of the problem. Description and description_html should not be passed together

.PARAMETER priority
    Priority of the Problem

    1-Low
    2-Medium
    3-High
    4-Urgent

.PARAMETER status
    Status identifier of the Problem.

    1-Open
    2-Change Requested
    3-Closed

.PARAMETER impact
    Impact of the Problem.

    1-Low
    2-Medium
    3-High

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
    Array of assets (display_id) associated with the problem.

.PARAMETER attachments
    Path to attachment(s).

.PARAMETER problem_cause
    Problem cause description.

.PARAMETER problem_symptom
    Problem symptom description

.PARAMETER problem_impact
    Problem impact description

.EXAMPLE
    Set-FreshServiceProblem -id 3 -description "Updated description for the problem" -attachments 'C:\Scripts\automation_icon.jpg'

    id                : 3
    agent_id          :
    description       : Updated description for the problem
    description_text  : Updated description for the problem
    assets            : {}
    requester_id      : 21000418005
    subject           : A new problem
    group_id          :
    priority          : 1
    impact            : 1
    status            : 1
    due_by            : 1/14/2023 7:23:41 PM
    known_error       : False
    department_id     :
    category          :
    sub_category      :
    item_category     :
    created_at        : 1/9/2023 7:23:47 PM
    updated_at        : 1/9/2023 7:23:47 PM
    associated_change :
    custom_fields     :
    analysis_fields   :

    Update the description on a problem and add an attachment.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceProblem {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique identifier of the Problem',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique identifier of the Problem',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Restore',
            Position = 0
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent to whom the Problem is assigned',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the initiator of the problem.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 2
        )]
        [long]$requester_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent group to which the Problem is assigned',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'HTML content of the problem. Description and description_html should not be passed together',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Priority of the Problem 1-Low, 2-Medium, 3-High, 4-Urgent',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [ValidateRange(1,4)]
        [int]$priority,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status identifier of the Problem. 1-Open, 2-Change Requested, 3-Closed ',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [ValidateRange(1,3)]
        [int]$status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Impact of the Problem. 1-Low, 2-Medium, 3-High ',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7
        )]
        [ValidateRange(1,3)]
        [int]$impact,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'States that the problem is known issue or not. true or false',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [boolean]$known_error,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Subject of the Problem ',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 9
        )]
        [string]$subject,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp at which Problem due ends ',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 10
        )]
        [datetime]$due_by,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the department initiating the Problem',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 11
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Category of the Problem',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 12
        )]
        [string]$category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Sub-category of the Problem',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 13
        )]
        [string]$sub_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Item of the Problem',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 14
        )]
        [string]$item_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 15
        )]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Array of assets (display_id) associated with the problem',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 16
        )]
        [object]$assets,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket attachments. The total size of these attachments cannot exceed 15MB.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 17
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
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 18
        )]
        [string]$problem_cause,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Problem symptom description',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 19
        )]
        [string]$problem_symptom,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Problem impact description',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 20
        )]
        [string]$problem_impact
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/problems' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

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
            if ($PSCmdlet.ShouldProcess($id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
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
