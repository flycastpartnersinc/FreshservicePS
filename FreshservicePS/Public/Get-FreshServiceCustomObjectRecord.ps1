<#
.SYNOPSIS
    Returns a Freshservice Custom Object Record.

.DESCRIPTION
    Returns a Freshservice Custom Object Record via REST API.

    https://api.freshservice.com/#list_all_custom_object_records

.PARAMETER custom_object_id
    Unique id of the Custom Object.

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

    Returns all Freshservice Custom Objects.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceCustomObjectRecord {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Custom Object.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [Alias('id')]
        [long]$custom_object_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 1
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

    }
    process {

        if ($custom_object_id) {
            $uri.Path = "{0}/{1}/records" -f $uri.Path, $custom_object_id
            $enablePagination = $true
        }

        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()

            $uri = $uri.Uri.AbsoluteUri

            $results = do {

                $params = @{
                    Uri         = $uri
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

                if ($result.Headers.Link) {
                    $uri = [regex]::Matches($result.Headers.Link,'<(?<Uri>.*)>')[0].Groups['Uri'].Value
                }

            }
            until (!$result.Headers.Link)

        }
        catch {
            Throw $_
        }

    }
    end {

        $results

    }
}
