<#
.SYNOPSIS
    Returns a Freshservice change.

.DESCRIPTION
    Returns a Freshservice change via REST API.

    https://api.freshservice.com/#create_change

.PARAMETER workspace_id
    Workspace ID of the ticket. The attribute is applicable only for accounts with the 'Workspaces' feature enabled. The default value is the ID of the primary workspace of the account.

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
    closed          = 6

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

.EXAMPLE
    Creates a new change for requester rob.smith@company.com with a Priority of 2 and Status of 2 with tags VPN and Version.

New-FreshServiceChange -email "rob.smith@company.com" -subject "VPN no worky" -description "Getting an error that VPN version not supported." -priority 2 -status 2 -tags 'VPN',"Version"

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceChange {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Workspace ID of the Changes. The attribute is applicable only for accounts with the Workspaces feature enabled. The default value is the ID of the primary workspace of the account.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$workspace_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent to whom the change is assigned.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'HTML content of the change. Description and description_html should not be passed together',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique identifier of the initiator of the change.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$requester_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent group to which the change is assigned.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Priority of the change.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,4)]
        [long]$priority,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Impact of the change.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,3)]
        [long]$impact,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the change.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,6)]
        [long]$status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Risk of the change.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,4)]
        [long]$risk,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Type of the change.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,4)]
        [long]$change_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Approval status of the change.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$approval_status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp at which change is starting.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$planned_start_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp at which change is ending.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$planned_end_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'change subject.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$subject,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the department initiating the change.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Category of the change',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Sub-category of the change',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$sub_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Item of the change',
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
            HelpMessage = 'Details about the associated Maintenance Window.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$maintenance_window,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of assets associated with the change',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$assets,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of Impacted Services associated with the change',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$impacted_services,
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
        [System.IO.FileInfo[]]$attachments

    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/changes' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ($PSBoundParameters[$PSItem] -is [datetime]) {
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
