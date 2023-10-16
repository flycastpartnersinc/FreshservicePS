<#
.SYNOPSIS
    Creates new Freshservice Release.

.DESCRIPTION
    Creates new Freshservice Release via REST API.

    https://api.freshservice.com/#view_a_release

.PARAMETER workspace_id
    Workspace ID of the ticket. The attribute is applicable only for accounts with the 'Workspaces' feature enabled. The default value is the ID of the primary workspace of the account.

.PARAMETER agent_id
    Unique identifier of the agent to whom the Release is assigned

.PARAMETER group_id
    Unique identifier of the agent group to which the Release is assigned

.PARAMETER priority
    Priority of the Release:

    1-Low
    2-Medium
    3-High
    4-Urgent

.PARAMETER status
    Status identifier of the Release:

    1-Open
    2-On hold
    3-In Progress
    4-Incomplete
    5-Completed

.PARAMETER release_type
    Type of the Release:

    1-minor
    2-standard
    3-major
    4-emergency

.PARAMETER subject
    Subject of the Release.

.PARAMETER description
    HTML description of the release. Description and description_html should not be passed together.

.PARAMETER planned_start_date
    Timestamp at which release is starting.

.PARAMETER planned_end_date
    Timestamp at which release is ending.

.PARAMETER work_start_date
    Timestamp at which release work started.

.PARAMETER work_end_date
    Timestamp at which release work ended.

.PARAMETER department_id
    Unique ID of the department initiating the Release.

.PARAMETER category
    Category of the Release.

.PARAMETER sub_category
    Sub-category of the Release.

.PARAMETER item_category
    Item of the Release.

.PARAMETER custom_fields
    Key value pairs containing the names and values of custom fields.

.PARAMETER planning_fields
    Key value pairs containing the names and values of Rollout Plan and Backout Plan.

.PARAMETER assets
    List of assets associated with the release.

.PARAMETER attachments
    Path to attachment(s).

.PARAMETER build_plan
    Planning field containing the build plan.

.PARAMETER test_plan
    Planning field containing the test plan.

.EXAMPLE
    $newFreshServiceReleaseSplat = @{
        subject            = "Release for Software X"
        description        = "Release for Software X for version 1.2.4"
        priority           = 1
        status             = 1
        planned_start_date = Get-Date -hour 20 -Minute 0 -Second 0
        planned_end_date   = Get-Date -hour 22 -Minute 0 -Second 0
        release_type       = 2
    }

    New-FreshServiceRelease @newFreshServiceReleaseSplat

    Creates a new Freshservice Release.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceRelease {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Workspace ID of the Release. The attribute is applicable only for accounts with the Workspaces feature enabled. The default value is the ID of the primary workspace of the account.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$workspace_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent to whom the Release is assigned',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent group to which the Release is assigned',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Priority of the Release 1-Low, 2-Medium, 3-High, 4-Urgent',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,4)]
        [int]$priority,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Status identifier of the Release. 1-Open, 2-On hold, 3-In Progress, 4-Incomplete, 5-Completed',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,5)]
        [int]$status,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Type of the Release 1-minor, 2-standard, 3-major, 4-emergency',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,4)]
        [int]$release_type,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Subject of the Release',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$subject,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'HTML description of the release. Description and description_html should not be passed together',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Timestamp at which release is starting',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$planned_start_date,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Timestamp at which release is ending',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$planned_end_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp at which release work started',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$work_start_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp at which release work ended',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$work_end_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the department initiating the Release',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Category of the Release',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Sub-category of the Release',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$sub_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Item of the Release',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$item_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of assets associated with the release',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$assets,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Release attachments. The total size of these attachments cannot exceed 15MB.',
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
            HelpMessage = 'Planning field containing the build plan.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 19
        )]
        [string]$build_plan,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Planning field containing the test plan.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 20
        )]
        [string]$test_plan

    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/releases' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $pf = @{}

        if ($PSBoundParameters.ContainsKey('build_plan')) {
            $pf.Add('build_plan',@{'description_html'=$build_plan})
            [void]$PSBoundParameters.Remove('build_plan')
        }

        if ($PSBoundParameters.ContainsKey('test_plan')) {
            $pf.Add('test_plan',@{'description_html'=$test_plan})
            [void]$PSBoundParameters.Remove('test_plan')
        }

        if ($pf.Count -gt 0){$PSBoundParameters['planning_fields'] = $pf}

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ($PSBoundParameters[$PSItem] -is [datetime]) {
                $jsonBody[$PSItem.ToLower()] = (Get-Date -Date $PSBoundParameters[$PSItem]).ToUniversalTime()
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

                if ($result.Content) {
                    $content = $result.Content |
                                    ConvertFrom-Json

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
