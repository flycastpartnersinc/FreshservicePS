<#
.SYNOPSIS
    Updates a Freshservice Asset.

.DESCRIPTION
    Updates a Freshservice Asset via REST API.

    https://api.freshservice.com/#update_an_asset

.PARAMETER display_id
    Unique Display Id of the Asset.

.PARAMETER name
    Name of the asset.

.PARAMETER description
    Description of the asset.

.PARAMETER asset_type_id
    Unique id of the asset type.

.PARAMETER asset_tag
    Asset tag of the asset.

.PARAMETER impact
    Impact of the asset.

.PARAMETER usage_type
    Usage type of the asset (Loaner / Permanent).

.PARAMETER user_id
    Unique id of the associated user (Used By).

.PARAMETER location_id
    Unique id of the associated location.

.PARAMETER department_id
    Unique id of the associated department.

.PARAMETER agent_id
    Unique id of the associated agent (Managed By).

.PARAMETER group_id
    Unique id of the associated agent group (Managed By Group).

.PARAMETER assigned_on
    Date and time when the asset was assigned.

.PARAMETER type_fields
    Key-value pair containing the names and values of the asset type fields.

.EXAMPLE
    Set-FreshServiceAsset -display_id 1 -description 'Updated description'

    attachments       : {}
    cloud_files       : {}
    id                : 21000207683
    display_id        : 1
    name              : Andrea's Laptop
    description       : Updated description
    asset_type_id     : 21000855304
    impact            : medium
    usage_type        : permanent
    asset_tag         : ASSET-1
    user_id           : 21000418006
    department_id     :
    location_id       :
    agent_id          :
    group_id          :
    assigned_on       :
    created_at        : 8/29/2022 2:17:48 PM
    updated_at        : 3/30/2023 3:13:48 AM
    author_type       : User
    type_fields       : @{product_21000855267=21000056898; vendor_21000855267=21000085371; cost_21000855267=1099;
                        warranty_21000855267=; acquisition_date_21000855267=8/29/2022 2:17:48 PM;
                        warranty_expiry_date_21000855267=8/29/2025 2:17:48 PM; domain_21000855267=;
                        asset_state_21000855267=In Use; serial_number_21000855267=FRSHW1234;
                        last_audit_date_21000855267=; os_21000855272=Mac; os_version_21000855272=OS X;
                        os_service_pack_21000855272=10.13.5; memory_21000855272=16; disk_space_21000855272=512;
                        cpu_speed_21000855272=2.2; cpu_core_count_21000855272=4;
                        mac_address_21000855272=1g:23:57:1d:c2:e7; uuid_21000855272=; hostname_21000855272=;
                        computer_ip_address_21000855272=192.168.55.254; last_login_by_21000855272=; depreciation_id=;
                        salvage=}
    end_of_life       :
    discovery_enabled : True

    Update a Freshservice asset.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceAsset {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the Asset',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('id')]
        [string]$display_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the Asset',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description about the asset.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the asset type.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$asset_type_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Asset tag of the asset.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$asset_tag,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Impact of the asset. Default is Low.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('low','medium','high')]
        [string]$impact,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Usage type of the asset (Loaner / Permanent). Default is permanent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('permanent','loaner')]
        [string]$usage_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated user (Used By).',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$user_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated Location.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$location_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated Department.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated agent (Managed By).',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated agent group (Managed By Group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Datetime value of assignment.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$assigned_on,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key-value pair containing the names and values of the asset type fields.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$type_fields
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/assets' -f $PrivateData['FreshserviceBaseUri'])

        if ($display_id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $display_id
            [void]$PSBoundParameters.Remove('display_id')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            Write-Verbose ("Processing body parameter {0}" -f $PSItem)
            if ( 'impact','usage_type' -contains $PSItem ) {
                $jsonBody[$PSItem.ToLower()] = ($PSBoundParameters[$PSItem]).ToLower()
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
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
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
