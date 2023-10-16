<#
.SYNOPSIS
    Returns a Freshservice Asset.

.DESCRIPTION
    Returns a Freshservice Asset via REST API.

    https://api.freshservice.com/#view_an_asset

.PARAMETER display_id
    The display Id of the asset.

.PARAMETER workspace_id
    Workspace id filter is applicable only for accounts with Workspaces feature enabled. Providing a Workspace_id will return tickets from a specific workspace.

    If the workspace_id(s) parameter is NOT provided, data will only be returned for the Default\Primary Workspace.
    If the workspace_id(s) parameter is provided, data will be returned from the specified Workspaces.
    If the workspace_id value is 0, data will be returned from all workspaces (the user has access to), with only global level fields.

.PARAMETER filter
    Custom filters supported by the api can be found here: https://api.freshservice.com/#filter_assets.  The filter is automatically url encoded at runtime. Filter queries for asset are 30 records per page with 40 pages maximum.

.PARAMETER name
    Quick filter Assets by Name. Tokenized search appears to be supported.

.PARAMETER asset_tag
    Quick filter Assets by Asset Tag. Tokenized search appears to be supported.

.PARAMETER serial_number
    Quick filter Assets by Serial Number

.PARAMETER SearchTrash
    Will return all the assets that are in trash. Does not return active asset in addition to trash, assets in trash only.

.PARAMETER IncludeTypeFields
    Will return all fields that are specific to each asset type. For example, for Hardware Asset Type, including type_fields will return fields such as Product_ID, Vendor_ID and Serial_number.

    IMPORTANT:  Each include will consume an additional two (2) credits. For example, if you embed the 'type_fields' information you will be charged a total of 3 API credits for each call.

.PARAMETER components
    This operation allows you to view information about all the components of an asset in the account.

.PARAMETER requests
    This operation allows you to view a list of all the requests associated to the asset in the account.

.PARAMETER contracts
    This operation allows you to get a list of all the contracts that an asset has been associated to.

.PARAMETER relationships
    This operation allows you to create new relationships in bulk.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceAsset

    id            : 21000460190
    display_id    : 4
    name          : Asset1234
    description   : ABC1234
    asset_type_id : 21000855272
    impact        : low
    author_type   : User
    usage_type    : permanent
    asset_tag     : ASSET-4
    user_id       :
    department_id :
    location_id   :
    agent_id      :
    group_id      :
    assigned_on   :
    created_at    : 9/30/2022 5:12:04 PM
    updated_at    : 9/30/2022 5:12:04 PM
    end_of_life   :

    id            : 21000207685
    display_id    : 3
    name          : Logitech Mouse
    description   :
    asset_type_id : 21000855268
    impact        : low
    author_type   : User
    usage_type    : permanent
    asset_tag     : ASSET-3
    user_id       :
    department_id :
    location_id   :
    agent_id      :
    group_id      :
    assigned_on   :
    created_at    : 8/29/2022 2:17:48 PM
    updated_at    : 8/29/2022 2:17:48 PM
    end_of_life   :

    id            : 21000207684
    display_id    : 2
    name          : Dell Monitor
    description   :
    asset_type_id : 21000855276
    impact        : low
    author_type   : User
    usage_type    : permanent
    asset_tag     : ASSET-2
    user_id       :
    department_id :
    location_id   :
    agent_id      :
    group_id      :
    assigned_on   :
    created_at    : 8/29/2022 2:17:48 PM
    updated_at    : 8/29/2022 2:17:48 PM
    end_of_life   :

    id            : 21000207683
    display_id    : 1
    name          : Andrea's Laptop
    description   :
    asset_type_id : 21000855304
    impact        : medium
    author_type   : User
    usage_type    : permanent
    asset_tag     : ASSET-1
    user_id       : 21000418006
    department_id :
    location_id   :
    agent_id      :
    group_id      :
    assigned_on   :
    created_at    : 8/29/2022 2:17:48 PM
    updated_at    : 8/29/2022 2:17:48 PM
    end_of_life   :

    Returns all FreshService Assets.
.EXAMPLE
    Get-FreshServiceAsset -Id 4

    id            : 21000460190
    display_id    : 4
    name          : Asset1234
    description   : ABC1234
    asset_type_id : 21000855272
    impact        : low
    author_type   : User
    usage_type    : permanent
    asset_tag     : ASSET-4
    user_id       :
    department_id :
    location_id   :
    agent_id      :
    group_id      :
    assigned_on   :
    created_at    : 9/30/2022 5:12:04 PM
    updated_at    : 9/30/2022 5:12:04 PM
    attachments   : {}
    cloud_files   : {}
    end_of_life   :

    Returns a Freshservice Asset by Display Id.

.EXAMPLE
    Get-FreshServiceAsset -display_id 4 -IncludeTypeFields

    id            : 21000460190
    display_id    : 4
    name          : Asset1234
    description   : ABC1234
    asset_type_id : 21000855272
    impact        : low
    author_type   : User
    usage_type    : permanent
    asset_tag     : ASSET-4
    user_id       :
    department_id :
    location_id   :
    agent_id      :
    group_id      :
    assigned_on   :
    created_at    : 9/30/2022 5:12:04 PM
    updated_at    : 9/30/2022 5:12:04 PM
    attachments   : {}
    cloud_files   : {}
    end_of_life   :
    type_fields   : @{product_21000855267=21000056898; vendor_21000855267=; cost_21000855267=; warranty_21000855267=;
                    acquisition_date_21000855267=; warranty_expiry_date_21000855267=; domain_21000855267=;
                    asset_state_21000855267=In Use; serial_number_21000855267=ABC1234; last_audit_date_21000855267=;
                    os_21000855272=; os_version_21000855272=; os_service_pack_21000855272=; memory_21000855272=;
                    disk_space_21000855272=; cpu_speed_21000855272=; cpu_core_count_21000855272=; mac_address_21000855272=;
                    uuid_21000855272=; hostname_21000855272=Asset1234; computer_ip_address_21000855272=;
                    last_login_by_21000855272=; depreciation_id=; salvage=}

    Returns a Freshservice Asset by Id and Include Type Fields.

.EXAMPLE
    Get-FreshServiceAsset -Filter "asset_state:'In Stock' and asset_type_id:21000855276"

    id            : 21000207684
    display_id    : 2
    name          : Dell Monitor
    description   :
    asset_type_id : 21000855276
    impact        : low
    author_type   : User
    usage_type    : permanent
    asset_tag     : ASSET-2
    user_id       :
    department_id :
    location_id   :
    agent_id      :
    group_id      :
    assigned_on   :
    created_at    : 8/29/2022 2:17:48 PM
    updated_at    : 8/29/2022 2:17:48 PM
    end_of_life   :

    Get Freshservice Asset(s) using filter criteria that the asset state is 'In Stock' and has a Asset Type Id of '21000855276'. See https://api.freshservice.com/#filter_assets
    for examples and available filter parameters.  The passed filter is automatically url encoded at runtime.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
    function Get-FreshServiceAsset {
    [CmdletBinding(DefaultParameterSetName = 'default')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Display id of Agent Role.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Display id of Agent Role.',
            ParameterSetName = 'components',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Display id of Agent Role.',
            ParameterSetName = 'requests',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Display id of Agent Role.',
            ParameterSetName = 'contracts',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Display id of Agent Role.',
            ParameterSetName = 'relationships',
            Position = 0
        )]
        [Alias('DisplayId','id')]
        [long]$display_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Workspace id is applicable only for accounts with Workspaces feature enabled. The value 0 for workspace_id will return tickets from all workspaces, with only global level fields.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [int[]]$workspace_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Filter for Assets',
            ParameterSetName = 'Filter',
            Position = 0
        )]
        [string]$filter,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the Asset',
            ParameterSetName = 'ByName',
            Position = 0
        )]
        [string]$name,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Asset Tag of the Asset',
            ParameterSetName = 'ByAssetTag',
            Position = 0
        )]
        [string]$asset_tag,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Serial Number of the Asset',
            ParameterSetName = 'BySerialNumber',
            Position = 0
        )]
        [string]$serial_number,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Return Freshservice Assets (only) in Trash',
            ParameterSetName = 'Trash',
            Position = 0
        )]
        [Alias('deleted', 'trash')]
        [switch]$SearchTrash,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Will return all fields that are specific to each asset type. For example, for Hardware Asset Type, including type_fields will return fields such as Product_ID, Vendor_ID and Serial_number.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Will return all fields that are specific to each asset type. For example, for Hardware Asset Type, including type_fields will return fields such as Product_ID, Vendor_ID and Serial_number.',
            ParameterSetName = 'id',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Will return all fields that are specific to each asset type. For example, for Hardware Asset Type, including type_fields will return fields such as Product_ID, Vendor_ID and Serial_number.',
            ParameterSetName = 'ByName',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Will return all fields that are specific to each asset type. For example, for Hardware Asset Type, including type_fields will return fields such as Product_ID, Vendor_ID and Serial_number.',
            ParameterSetName = 'BySerialNumber',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Will return all fields that are specific to each asset type. For example, for Hardware Asset Type, including type_fields will return fields such as Product_ID, Vendor_ID and Serial_number.',
            ParameterSetName = 'Filter',
            Position = 1
        )]
       [Parameter(
            Mandatory = $false,
            HelpMessage = 'Will return all fields that are specific to each asset type. For example, for Hardware Asset Type, including type_fields will return fields such as Product_ID, Vendor_ID and Serial_number.',
            ParameterSetName = 'ByAssetTag',
            Position = 1
        )]
        [switch]$IncludeTypeFields,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'This operation allows you to view information about all the components of an asset in the account.',
            ParameterSetName = 'components',
            Position = 1
        )]
        [switch]$components,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'This operation allows you to view a list of all the requests associated to the asset in the account.',
            ParameterSetName = 'requests',
            Position = 1
        )]
        [switch]$requests,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'This operation allows you to get a list of all the contracts that an asset has been associated to.',
            ParameterSetName = 'contracts',
            Position = 1
        )]
        [switch]$contracts,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Lists all the relationships of a particular asset.',
            ParameterSetName = 'relationships',
            Position = 1
        )]
        [switch]$relationships,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 3
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/assets' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

        if ($display_id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $display_id
            $enablePagination = $false
        }
        elseif ($filter) {
            $qry.Add('filter', '"{0}"' -f $filter )
            $enablePagination = $false
        }

        if ($PSBoundParameters.ContainsKey('workspace_id')) {
            $qry.Add('workspace_id', $workspace_id -join ',')
        }

        if ($PSBoundParameters.ContainsKey('name')) {
            $qry.Add('search', '"name:''{0}''"' -f $name )
            $enablePagination = $false
        }

        if ($PSBoundParameters.ContainsKey('asset_tag')) {
            $qry.Add('search', '"asset_tag:''{0}''"' -f $asset_tag )
            $enablePagination = $false
        }

        if ($PSBoundParameters.ContainsKey('serial_number')) {
            $qry.Add('search', '"serial_number:''{0}''"' -f $serial_number )
            $enablePagination = $false
        }

        if ($PSBoundParameters.ContainsKey('IncludeTypeFields')) {
            $qry.Add('include', 'type_fields')
        }

        if ($PSBoundParameters.ContainsKey('SearchTrash')) {
            $qry.Add('trashed', 'true' )
        }

        if ($PSBoundParameters.ContainsKey('components')) {
            $uri.Path = "{0}/components" -f $uri.Path
            $enablePagination = $true
        }

        if ($PSBoundParameters.ContainsKey('requests')) {
            $uri.Path = "{0}/requests" -f $uri.Path
            $enablePagination = $true
        }

        if ($PSBoundParameters.ContainsKey('contracts')) {
            $uri.Path = "{0}/contracts" -f $uri.Path
            $enablePagination = $true
        }

        if ($PSBoundParameters.ContainsKey('relationships')) {
            $uri.Path = "{0}/relationships" -f $uri.Path
            $enablePagination = $true
        }

    }
    process {

        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()

            $uriFinal = $uri.Uri.AbsoluteUri

            $results = do {

                $params = @{
                    Uri         = $uriFinal
                    Method      = 'GET'
                    ErrorAction = 'Stop'
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

                #Default loop condition - link exists indicates another page for pagination
                $loopCondition = !$result.Headers.Link

                if ($PSBoundParameters.ContainsKey('filter')) {
                    #Pagination is manual for results returned from filter with 30 records returned per page with max of 40 pages.
                    Write-Verbose ('Using filter pagination for page {0}' -f $page)
                    #Manually increment page
                    $page++
                    #Update query
                    $qry['page'] = $page
                    $uri.Query = $qry.ToString()
                    $uriFinal = $uri.Uri.AbsoluteUri

                    $maxPages = 40
                    if ($maxPages -gt $page) {
                        Write-Warning -Message  ('Returned maximum allowed {0} pages for filter query' -f $maxPages)
                        Write-Verbose -Message  ('Returned maximum allowed {0} pages for filter query' -f $maxPages)
                    }
                    #Update loop condition based on return results
                    $loopCondition = ($content."$($objProperty)".Count -eq 0) -or ($page -gt $maxPages)
                }
                elseif ($result.Headers.Link) {
                    $uriFinal = [regex]::Matches($result.Headers.Link,'<(?<Uri>.*)>')[0].Groups['Uri'].Value
                    Write-Verbose ('Automatic pagination enabled with next link {0}' -f $uri)
                }
            }
            until ($loopCondition)

        }
        catch {
            Throw $_
        }

    }
    end {

        $results

    }
}
