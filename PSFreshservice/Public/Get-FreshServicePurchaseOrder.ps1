<#
.SYNOPSIS
    Returns a Freshservice Purchase Order.

.DESCRIPTION
    Returns a Freshservice Purchase Order via REST API.

    https://api.freshservice.com/#list_all_purchase_orders

.PARAMETER Id
    Unique id of the Purchase Order.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServicePurchaseOrder

    id                     : 1
    name                   : Purchase Order for Dell laptops
    po_number              : PO-1
    total_cost             : 11030
    expected_delivery_date : 8/31/2022 4:00:00 AM
    created_at             : 8/29/2022 2:17:31 PM
    updated_at             : 8/29/2022 2:17:31 PM
    vendor_id              : 21000085372
    department_id          :
    created_by             : 21000418008
    status                 : 20

    Returns all Freshservice Purchase Orders.

.EXAMPLE
    Get-FreshServicePurchaseOrder -Id 1

    id                       : 1
    name                     : Purchase Order for Dell laptops
    po_number                : PO-1
    vendor_id                : 21000085372
    vendor_details           : 1 Dell Way
                            Round Rock
                            Texas
                            United States
                            78664
    department_id            :
    created_by               : 21000418008
    expected_delivery_date   : 8/31/2022 4:00:00 AM
    shipping_address         : Level 28, 161 Castlereagh Street, Sydney NSW 2000
    billing_same_as_shipping : True
    billing_address          : Level 28, 161 Castlereagh Street, Sydney NSW 2000
    created_at               : 8/29/2022 2:17:31 PM
    updated_at               : 8/29/2022 2:17:31 PM
    custom_fields            : @{terms_and_conditions=1. Please quote the Purchase Order (P.O.) number on your bills and on any other correspondence in connection with this order.
                            2. The company does not accept any responsibility for any order unless it is issued on company's official P.O. duly signed by authorised signatory. However no physical signature is required in case of electronic copy generated through system.
                            3. Please confirm acceptance of this order to company's materials department. In the absence of such acceptance, the delivery of any material, equipment or services shall constitute full acceptance by the Supplier of the terms and conditions herein.
                            4. Payment will be made after 60 days from the date of receipt of supplies unless otherwise specified.}
    status                   : 20
    purchase_items           : {@{item_type=3; item_name=Dell Laptops; id=21000023474; item_id=; description=Laptops W/ 10th Gen Intel Core Processor; cost=1000; quantity=10; received=0; tax_percentage=12.5; total_cost=11250; created_at=8/29/2022 2:17:31 PM; updated_at=8/29/2022 2:17:31 PM},
                            @{item_type=3; item_name=Laptop sleeves; id=21000023475; item_id=; description=13" black laptop sleeves; cost=15; quantity=10; received=0; tax_percentage=0; total_cost=150; created_at=8/29/2022 2:17:31 PM; updated_at=8/29/2022 2:17:31 PM}}
    discount_percentage      : 5
    tax_percentage           : 0
    shipping_cost            : 200
    total_cost               : 11030
    currency                 : @{id=USD; conversion_rate=1; symbol=$; name=Dollar ($); currency_country=; separator=.}

    Return Freshservice Purchase Order by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServicePurchaseOrder {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Purchase Order.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
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
        $uri = [System.UriBuilder]('{0}/purchase_orders' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
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
