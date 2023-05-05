<#
.SYNOPSIS
    Search for Freshservice Catalog Item.

.DESCRIPTION
    Search for Freshservice Catalog Item via REST API.

    https://api.freshservice.com/#search_service_item

.PARAMETER search_term
    The keywords for which the solution articles have to be searched. Example: "Vpn issue"

.PARAMETER user_email
    By default, the API will search the articles for the user whose API key is provided. If you want to search articles for a different user, please provide their user_email.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Search-FreshServiceCatalogItem {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The keywords for which the solution articles have to be searched. Example: "Vpn issue"',
            ParameterSetName = 'default',
            Position = 0
        )]
        [string]$search_term,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'By default, the API will search the articles for the user whose API key is provided. If you want to search articles for a different user, please provide their user_email.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [string]$user_email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [int]$per_page = 5,
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
        $uri = [System.UriBuilder]('{0}/service_catalog/items/search' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

    }
    process {

        if ($search_term) {
            $qry.Add('search_term', '{0}' -f $search_term.ToLower() )
        }

        if ($user_email) {
            $qry.Add('user_email', '{0}' -f $user_email.ToLower() )
        }

        try {

            $results = do {

                if ($enablePagination) {
                    $qry['page'] = $page
                    $qry['per_page'] = $per_page
                }

                $uri.Query = $qry.ToString()

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'GET'
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                #$result
                 $content = $result.Content |
                                 ConvertFrom-Json

                Write-Verbose ("Header Link: {0}" -f $result.Headers.Link)
                Write-Verbose ("Meta - Total Items: {0} " -f $content.meta.total_items)
                Write-Verbose ("Meta - Total Pages: {0} " -f $content.meta.total_pages)
                Write-Verbose ("Meta - Current Page: {0} " -f $content.meta.current_page)
                Write-Verbose ("Articles in payload {0} for page {1}:" -f $content.service_items.count, $page)
                # $content

                if ($content) {
                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name |
                                        Where-Object -FilterScript {$_ -like 'service_item*'}
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
                }

                # if ($result.Headers.Link) {
                #     $uri = [regex]::Matches($result.Headers.Link,'<(?<Uri>.*)>')[0].Groups['Uri'].Value
                # }
                Write-Verbose ("Incrementing page {0} to {1}:" -f $page, $page++)

                $page++

            }
            until (($content."$($objProperty)").Count -eq 0)

        }
        catch {
            Throw $_
        }

    }
    end {

        $results

    }
}
