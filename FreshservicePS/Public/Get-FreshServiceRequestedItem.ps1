<#
.SYNOPSIS
    Returns a Freshservice Requested Item.

.DESCRIPTION
    Returns a Freshservice Requested Item via REST API.

    https://api.freshservice.com/#view_req_items_of_sr

.PARAMETER Id
    Unique id of the Service Request.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceRequestedItem -id 208

    custom_fields    :
    id               : 21000346032
    created_at       : 3/27/2023 2:01:45 PM
    updated_at       : 3/27/2023 2:01:45 PM
    quantity         : 1
    stage            : 1
    loaned           : False
    cost_per_request : 87.5
    remarks          :
    delivery_time    : 24
    is_parent        : False
    service_item_id  : 14

    custom_fields    :
    id               : 21000346030
    created_at       : 3/27/2023 2:01:29 PM
    updated_at       : 3/27/2023 2:01:29 PM
    quantity         : 1
    stage            : 1
    loaned           : False
    cost_per_request : 1099
    remarks          :
    delivery_time    : 48
    is_parent        : True
    service_item_id  : 13

    Returns all Freshservice Requested Items.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceRequestedItem {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Service Request.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [Alias('service_request_id')]
        [long]$id,
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
        $uri = [System.UriBuilder]('{0}/tickets' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

    }
    process {

        if ($id) {
            $uri.Path = "{0}/{1}/requested_items" -f $uri.Path, $id
            $enablePagination = $false
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

                $content = $result.Content |
                                ConvertFrom-Json

                if ($content) {
                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
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
