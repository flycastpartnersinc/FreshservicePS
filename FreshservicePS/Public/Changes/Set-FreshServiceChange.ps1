<#
.SYNOPSIS
    Updates a Freshservice Change.

.DESCRIPTION
    Updates a Freshservice Change via REST API.

    https://api.freshservice.com/#update_change_priority

.PARAMETER id
    Unique identifier of the Change.

.PARAMETER agent_id
    Unique identifier of the agent to whom the change is assigned.

.PARAMETER description
    HTML content of the change. Description and description_html should not be passed together

.PARAMETER requester_id
    Unique identifier of the initiator of the change.

.PARAMETER group_id
    Unique identifier of the agent group to which the change is assigned.

.PARAMETER priority
    Priority of the change.

    Low    = 1
    Medium = 2
    High   = 3
    Urgent = 4

.PARAMETER impact
    Impact of the change.

    Low    = 1
    Medium = 2
    High   = 3

.PARAMETER status
    Status of the change.

    Open            = 1
    Planning        = 2
    Approval        = 3
    Pending Release    = 4
    Pending Review  = 5
    Closed          = 6

.PARAMETER risk
    Risk of the change.

    Minor     = 1
    Standard  = 2
    Major     = 3
    Emergency = 4

.PARAMETER change_type
    Type of the change.

    Minor     = 1
    Standard  = 2
    Major     = 3
    Emergency = 4

.PARAMETER approval_status
    Approval status of the change.

.PARAMETER planned_start_date
    Timestamp at which change is starting.

.PARAMETER planned_end_date
    Timestamp at which change is ending.

.PARAMETER subject
    change subject.

.PARAMETER department_id
    Unique ID of the department initiating the change.

.PARAMETER category
    Category of the change

.PARAMETER sub_category
    Sub-category of the change

.PARAMETER item_category
    Item of the change

.PARAMETER custom_fields
    Key value pairs containing the names and values of custom fields.

.PARAMETER maintenance_window
    Details about the associated Maintenance Window.

.PARAMETER assets
    List of assets associated with the change

.PARAMETER impacted_services
    List of Impacted Services associated with the change

.PARAMETER attachments
    Path to attachment(s).

.PARAMETER workspace_id
    Workspace ID to move ticket. The attribute is applicable only for accounts with the Workspaces feature enabled. The default value is the ID of the primary workspace of the account.

.EXAMPLE
    Set-FreshServiceChange -id 10 -planned_end_date (Get-Date).AddDays(+5)

    agent_id           : 21000418005
    group_id           : 21000188395
    priority           : 1
    impact             : 1
    status             : 2
    risk               : 1
    change_type        : 1
    planned_start_date : 2/28/2023 5:42:29 AM
    planned_end_date   : 4/4/2023 3:31:00 AM
    subject            : Test change from Pester
    department_id      :
    category           : Hardware
    sub_category       : Computer
    item_category      :
    description        : <div>Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31</div>
    description_text   : Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31
    id                 : 10
    requester_id       : 21000418005
    approval_status    : 4
    change_window_id   :
    created_at         : 2/28/2023 5:42:30 PM
    updated_at         : 3/30/2023 3:31:01 AM
    maintenance_window :
    blackout_window    :
    assets             : {}
    impacted_services  : {}
    custom_fields      :
    planning_fields    : @{custom_fields=}

    Update a Freshservice Change.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
    #>

function Set-FreshServiceChange {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique identifier of the Change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique identifier of the Change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'workspace',
            Position = 0
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent to whom the change is assigned.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'HTML content of the change. Description and description_html should not be passed together',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 2
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the initiator of the change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [long]$requester_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent group to which the change is assigned.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Priority of the change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [ValidateRange(1,4)]
        [long]$priority,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Impact of the change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [ValidateRange(1,3)]
        [long]$impact,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7
        )]
        [ValidateRange(1,6)]
        [long]$status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Risk of the change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [ValidateRange(1,4)]
        [long]$risk,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Type of the change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 9
        )]
        [ValidateRange(1,4)]
        [long]$change_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Approval status of the change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 10
        )]
        [long]$approval_status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp at which change is starting.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 11
        )]
        [datetime]$planned_start_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp at which change is ending.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 12
        )]
        [datetime]$planned_end_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'change subject.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 13
        )]
        [string]$subject,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the department initiating the change.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 14
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Category of the change',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 15
        )]
        [string]$category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Sub-category of the change',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 16
        )]
        [string]$sub_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Item of the change',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 17
        )]
        [string]$item_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 18
        )]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Details about the associated Maintenance Window.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 19
        )]
        [hashtable]$maintenance_window,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of assets associated with the change',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 20
        )]
        [object[]]$assets,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of Impacted Services associated with the change',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 21
        )]
        [hashtable]$impacted_services,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket attachments. The total size of these attachments cannot exceed 15MB.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 22
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
            HelpMessage = 'Workspace ID to move Change. The attribute is applicable only for accounts with the Workspaces feature enabled. The default value is the ID of the primary workspace of the account.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [int]$workspace_id
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/changes' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        if ($workspace_id) {
            $uri.Path = "{0}/move_workspace" -f $uri.Path
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ($PSBoundParameters[$PSItem] -is [boolean]) {
                $jsonBody[$PSItem.ToLower()] = (Get-Date -Date $PSBoundParameters[$PSItem]).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
            }
            else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

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
