<#
.SYNOPSIS
    Returns a Freshservice Custom Object Record.

.DESCRIPTION
    Returns a Freshservice Custom Object Record via REST API.

    https://api.freshservice.com/#list_all_custom_object_records

.PARAMETER custom_object_id
    Unique id of the Custom Object.

.PARAMETER Filter
    Filter results for Custom Object Record.  Documentation can be found here to get the latest capabilities and examples:

    https://api.freshservice.com/#list_all_custom_object_records

    The function will automatically encode the url query prior to the API call.

    Note:  Important! This filter requires spaces between the key\value pairs. Using category_dd1:'Hardware' will fail, the API requires the spacing category_dd1 : 'Hardware'.

.PARAMETER sort_field
	Name of the object field\header to be used for sorting the records.

.PARAMETER sort_order
    Order of sorting the records (ASC or DESC).

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceCustomObjectRecord -custom_object_id 21000011818

    agent_group        : @{id=21000188395; value=Hardware Team}
    approver           : @{id=21000418006; value=Andrea Smith <andrea@freshservice.com>}
    bo_created_at      : 8/29/2022 2:17:58 PM
    bo_created_by      : @{id=21000418007}
    bo_display_id      : 2
    bo_updated_at      : 8/29/2022 2:17:58 PM
    bo_updated_by      : @{id=21000418007}
    category_dd1       : Hardware
    category_dd2       :
    category_dd3       :
    item_name          : @{id=21000487361; value=Apple MacBook}
    vendor_information : Apple-sales@apple.com

    agent_group        : @{id=21000188395; value=Hardware Team}
    approver           : @{id=21000418006; value=Andrea Smith <andrea@freshservice.com>}
    bo_created_at      : 8/29/2022 2:17:58 PM
    bo_created_by      : @{id=21000418007}
    bo_display_id      : 1
    bo_updated_at      : 8/29/2022 2:17:58 PM
    bo_updated_by      : @{id=21000418007}
    category_dd1       : Hardware
    category_dd2       :
    category_dd3       :
    item_name          : @{id=21000487352; value=Windows Laptop}
    vendor_information : Microsoft - sales@microsoft.com

    ...

    Returns all Freshservice Custom Object Records for a specified Custom Object Id.

.EXAMPLE
    Get-FreshServiceCustomObjectRecord -custom_object_id 21000011818 -Filter "category_dd1 : 'Hardware'" -sort_field bo_display_id -sort_order ASC

    agent_group        : @{id=21000188395; value=Hardware Team}
    approver           : @{id=21000418006; value=Andrea Smith <andrea@freshservice.com>}
    bo_created_at      : 8/29/2022 2:17:58 PM
    bo_created_by      : @{id=21000418007}
    bo_display_id      : 1
    bo_updated_at      : 8/29/2022 2:17:58 PM
    bo_updated_by      : @{id=21000418007}
    category_dd1       : Hardware
    category_dd2       :
    category_dd3       :
    item_name          : @{id=21000487352; value=Windows Laptop}
    vendor_information : Microsoft - sales@microsoft.com

    agent_group        : @{id=21000188395; value=Hardware Team}
    approver           : @{id=21000418006; value=Andrea Smith <andrea@freshservice.com>}
    bo_created_at      : 8/29/2022 2:17:58 PM
    bo_created_by      : @{id=21000418007}
    bo_display_id      : 2
    bo_updated_at      : 8/29/2022 2:17:58 PM
    bo_updated_by      : @{id=21000418007}
    category_dd1       : Hardware
    category_dd2       :
    category_dd3       :
    item_name          : @{id=21000487361; value=Apple MacBook}
    vendor_information : Apple-sales@apple.com

    agent_group        : @{id=21000188390; value=Service Request Fulfillment Team}
    approver           : @{id=21000418009; value=Jack <jack@freshservice.com>}
    bo_created_at      : 2/17/2023 2:01:43 PM
    bo_created_by      : @{id=21000418005; value=Andrea Smith <andrea@freshservice.com>}
    bo_display_id      : 5
    bo_updated_at      : 2/17/2023 2:01:43 PM
    bo_updated_by      : @{id=21000418005; value=Andrea Smith <andrea@freshservice.com>}
    category_dd1       : Hardware
    category_dd2       :
    category_dd3       :
    item_name          : @{id=21000487364; value=Dell Monitor}
    vendor_information : sales@dell.com

    Returns filtered Freshservice Custom Object Records for a specified Custom Object Id where the column category_dd1 = Hardware.
    The result is sorted on column bo_display_id and sorted by ascended order.

    Note: Filtering requires spaces between key\value pairs.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceCustomObjectRecord {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Custom Object.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Custom Object.',
            ParameterSetName = 'filter',
            Position = 0
        )]
        [Alias('id')]
        [long]$custom_object_id,
        #https://github.com/flycastpartnersinc/FreshservicePS/issues/11
        # [Parameter(
        #     Mandatory = $true,
        #     HelpMessage = 'Filter results for Custom Object Record.',
        #     ParameterSetName = 'filter',
        #     Position = 1
        # )]
        # [string]$filter,
        # [Parameter(
        #     Mandatory = $true,
        #     HelpMessage = 'Filter option for specific header\field to sort results for Custom Object Record(s).',
        #     ParameterSetName = 'filter',
        #     Position = 2
        # )]
        # [string]$sort_field,
        # [Parameter(
        #     Mandatory = $false,
        #     HelpMessage = 'Filter option for sort order ((Asc)ending or (Desc)ending) to sort results for Custom Object Record(s)',
        #     ParameterSetName = 'filter',
        #     Position = 3
        # )]
        # [ValidateSet('ASC', 'DESC')]
        # [string]$sort_order,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            Position = 4
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            Position = 5
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/objects' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $false

        if ($custom_object_id) {
            $uri.Path = "{0}/{1}/records" -f $uri.Path, $custom_object_id
            $enablePagination = $true
        }

        if ($filter) {
            $qry.Add('query', $filter )
            $enablePagination = $true
        }

        if ($sort_field) {
            $qry.Add('sort_field', $sort_field.ToLower() )
        }

        if ($sort_order) {
            $qry.Add('sort_order', $sort_order.ToLower() )
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
                    $objProperty = $content[0].PSObject.Properties.Name  |
                                        Where-Object -FilterScript {$_ -like 'record*'}

                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)".data
                }

                #Default loop condition - link exists indicates another page for pagination
                $loopCondition = !$result.Headers.Link

                if ($PSBoundParameters.ContainsKey('filter')) {
                    #Pagination is manual for results returned from filter
                    Write-Verbose ('Using filter pagination for page {0}' -f $page)
                    #Manually increment page
                    $page++
                    #Update query
                    $qry['page'] = $page
                    $uri.Query = $qry.ToString()
                    $uriFinal = $uri.Uri.AbsoluteUri
                    #Update loop condition based on return results
                    $loopCondition = $content."$($objProperty)".Count -eq 0
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
