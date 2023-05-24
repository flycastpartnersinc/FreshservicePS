<#
.SYNOPSIS
    Creates Freshservice location.

.DESCRIPTION
    Creates Freshservice location via REST API.

    https://api.freshservice.com/#create_a_new_purchase_order

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
    Creates a new Freshservice Purchase Order.

    $poParams = @{
        vendor_id = 18000079644
        name = 'PO From API'
        po_number = 'PO-1234'
        vendor_details = 'Vendor details'
        shipping_address = '123 Nowhere Ave'
        billing_same_as_shipping = $true
        billing_address = '123 Nowhere Ave'
        currency_code = 'USD'
        purchase_items = @{
            item_id=18000036968
            item_type = 1 #Product = 1, Software = 2
            item_name = 'Monitor'
            description = 'Monitor'
            cost = 200.00
            quantity = 1
            tax_percentage = 5
        }
    }

    New-FreshServicePurchaseOrder @poParams

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServicePurchaseOrder {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the vendor with whom the order is placed.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$vendor_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Title of the purchase order.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Purchase order number.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$po_number,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Details of the vendor with whom the order is placed.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$vendor_details,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Expected delivery date of the purchase order.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$expected_delivery_date,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Address to which the order should be shipped.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$shipping_address,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'True if Billing address is same as Shipping address.',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$billing_same_as_shipping,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Address to which the order should be billed.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$billing_address,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Currency unit used in the transaction.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$currency_code,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Conversion rate to convert selected currency unit to helpdesk currency.',
            ValueFromPipelineByPropertyName = $true
        )]
        [decimal]$conversion_rate,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the department.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Percentage of discount on the order.',
            ValueFromPipelineByPropertyName = $true
        )]
        [decimal]$discount_percentage,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Percentage of tax on the order.',
            ValueFromPipelineByPropertyName = $true
        )]
        [decimal]$tax_percentage,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Total cost of shipping the order.',
            ValueFromPipelineByPropertyName = $true
        )]
        [decimal]$shipping_cost,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Any Custom field required for purchase order.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Items to be ordered.',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$purchase_items
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/purchase_orders' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

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
