<#
.SYNOPSIS
    Creates Freshservice asset.

.DESCRIPTION
    Creates Freshservice asset via REST API.

    https://api.freshservice.com/#create_an_asset

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
    Key-value pair containing the names and values of the asset type fields. Once a asset_layer_id is assigned, all mandatory fields must be
    provided or an validation error will occur to indicated the mandatory fields:

    {"description":"Validation failed","errors":[{"field":"product_21000855267","message":"This field cannot be empty","code":"missing_field"},{"field":"asset_state_21000855267","message":"This field cannot be empty","code":"missing_field"}]}

    IMPORTANT: These type fields vary on every Freshservice tenant and are represented by the layer id. See Get-FreshServiceAssetType.

.EXAMPLE
    New-FreshServiceAsset -name 'Laptop123' -description 'Apple Laptop' -asset_type_id 21000855304 -type_fields @{product_21000855267 = 21000056898;asset_state_21000855267 = 'In Use'}

    attachments       : {}
    cloud_files       : {}
    id                : 21001571617
    display_id        : 40
    name              : Laptop123
    description       : Apple Laptop
    asset_type_id     : 21000855304
    impact            : low
    usage_type        : permanent
    asset_tag         : ASSET-40
    user_id           :
    department_id     :
    location_id       :
    agent_id          :
    group_id          :
    assigned_on       :
    created_at        : 3/27/2023 5:39:55 PM
    updated_at        : 3/27/2023 5:39:55 PM
    author_type       : User
    type_fields       : @{product_21000855267=21000056898; vendor_21000855267=; cost_21000855267=; warranty_21000855267=; acquisition_date_21000855267=; warranty_expiry_date_21000855267=; domain_21000855267=; asset_state_21000855267=In Use; serial_number_21000855267=; last_audit_date_21000855267=;
                        os_21000855272=; os_version_21000855272=; os_service_pack_21000855272=; memory_21000855272=; disk_space_21000855272=; cpu_speed_21000855272=; cpu_core_count_21000855272=; mac_address_21000855272=; uuid_21000855272=; hostname_21000855272=; computer_ip_address_21000855272=;
                        last_login_by_21000855272=; depreciation_id=; salvage=}
    end_of_life       :
    discovery_enabled : True

    Create a new Freshservice Asset.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceAsset {
     [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
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
            Mandatory = $true,
            HelpMessage = 'Unique id of the asset type.'
        )]
        [long]$asset_type_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Asset tag of the asset.'
        )]
        [string]$asset_tag,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Impact of the asset. Default is Low.'
        )]
        [ValidateSet('low','medium','high')]
        [string]$impact,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Usage type of the asset (Loaner / Permanent). Default is permanent.'
        )]
        [ValidateSet('permanent','loaner')]
        [string]$usage_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated user (Used By).'
        )]
        [long]$user_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated Location.'
        )]
        [long]$location_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated Department.'
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated agent (Managed By).'
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the associated agent group (Managed By Group.'
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Datetime value of assignment.'
        )]
        [datetime]$assigned_on,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key-value pair containing the names and values of the asset type fields.'
        )]
        [hashtable]$type_fields
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/assets' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        if ($PSBoundParameters.ContainsKey('impact')) {
            $PSBoundParameters['impact'] = $impact.ToLower()
        }

        if ($PSBoundParameters.ContainsKey('usage_type')) {
            $PSBoundParameters['usage_type'] = $usage_type.ToLower()
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ( 'impact','usage_type' -contains $PSItem ) {
                $jsonBody[$PSItem.ToLower()] = ($PSBoundParameters[$PSItem]).ToLower()
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
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json -Depth 5

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
