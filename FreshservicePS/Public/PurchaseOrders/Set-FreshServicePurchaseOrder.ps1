<#
.SYNOPSIS
    Updates a Freshservice Purchase Order.

.DESCRIPTION
    Updates a Freshservice Purchase Order via REST API.

    https://api.freshservice.com/#_update_a_purchase_order

.PARAMETER id
    Unique Id of the Purchase Order.

.PARAMETER vendor_id
    Unique id of the vendor with whom the order is placed.

.PARAMETER name
    Title of the purchase order.

.PARAMETER po_number
    Unique Purchase order number.

.PARAMETER vendor_details
    Details of the vendor with whom the order is placed.

.PARAMETER expected_delivery_date
    Expected delivery date of the purchase order.

.PARAMETER shipping_address
    Address to which the order should be shipped.

.PARAMETER billing_same_as_shipping
    True if Billing address is same as Shipping address.

.PARAMETER billing_address
    Address to which the order should be billed.

.PARAMETER currency_code
    Currency unit used in the transaction.

.PARAMETER conversion_rate
    Conversion rate to convert selected currency unit to helpdesk currency.

.PARAMETER department_id
    Unique ID of the department.

.PARAMETER discount_percentage
    Percentage of discount on the order.

.PARAMETER tax_percentage
    Percentage of tax on the order.

.PARAMETER shipping_cost
    Total cost of shipping the order.

.PARAMETER custom_fields
    Any Custom field required for purchase order.

.PARAMETER purchase_items
    Items to be ordered. Use helper function New-FreshServicePurchaseItem.

.EXAMPLE
    Set-FreshServicePurchaseOrder -id 4 -shipping_address '123 North Pole'

    id                       : 4
    name                     : PO From API
    po_number                : PO-2222
    vendor_id                : 21000085372
    vendor_details           : Vendor details
    department_id            :
    created_by               : 21000418005
    expected_delivery_date   :
    shipping_address         : 123 North Pole
    billing_same_as_shipping : True
    billing_address          : 123 North Pole
    created_at               : 2/11/2023 6:50:15 PM
    updated_at               : 2/11/2023 6:50:43 PM
    custom_fields            : @{terms_and_conditions=}
    status                   : 20
    purchase_items           : {@{item_type=1; item_name=Monitor; id=21000070017; item_id=21000056899;
                            description=Monitor; cost=200; quantity=1; received=0; tax_percentage=5;
                            total_cost=210; created_at=2/11/2023 6:50:15 PM; updated_at=2/11/2023 6:50:15 PM}}
    discount_percentage      :
    tax_percentage           :
    shipping_cost            :
    total_cost               : 210
    currency                 : @{id=USD; conversion_rate=; symbol=$; name=Dollar ($); currency_country=; separator=.}

    Updates the address of a Purchase Order.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServicePurchaseOrder {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the Purchase Order.'
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the vendor with whom the order is placed.'
        )]
        [long]$vendor_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Title of the purchase order.'
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique Purchase order number.'
        )]
        [string]$po_number,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Details of the vendor with whom the order is placed.'
        )]
        [string]$vendor_details,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Expected delivery date of the purchase order.'
        )]
        [datetime]$expected_delivery_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Address to which the order should be shipped.'
        )]
        [string]$shipping_address,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'False if Billing address is same as Shipping address.'
        )]
        [boolean]$billing_same_as_shipping,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Address to which the order should be billed.'
        )]
        [string]$billing_address,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Currency unit used in the transaction.'
        )]
        [string]$currency_code,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Conversion rate to convert selected currency unit to helpdesk currency.'
        )]
        [decimal]$conversion_rate,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the department.'
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Percentage of discount on the order.'
        )]
        [decimal]$discount_percentage,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Percentage of tax on the order.'
        )]
        [decimal]$tax_percentage,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Total cost of shipping the order.'
        )]
        [decimal]$shipping_cost,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Any Custom field required for purchase order.'
        )]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Items to be ordered.'
        )]
        [object[]]$purchase_items
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/purchase_orders' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        #Force to array for JSON formatting
        if ($PSBoundParameters['purchase_items']) {$PSBoundParameters['purchase_items'] = @($purchase_items)}

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ($PSBoundParameters[$PSItem] -is [datetime]) {
                $jsonBody[$PSItem.ToLower()] = Get-Date -Date $PSBoundParameters[$PSItem] -Format "yyyy-MM-dd"
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
                    Body        = $jsonBody | ConvertTo-Json
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

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
