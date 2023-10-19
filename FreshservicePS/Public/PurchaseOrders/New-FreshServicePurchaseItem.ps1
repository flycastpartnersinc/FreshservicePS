<#
.SYNOPSIS
    Helper function to create purchase item for New-FreshServicePurchaseOrder and Set-FreshServicePurchaseOrder.

.DESCRIPTION
    Helper function to create purchase item for New-FreshServicePurchaseOrder and Set-FreshServicePurchaseOrder. A
    purchase order (PO) is an official document issued by a buyer to a seller indicating
    the types, quantities, and agreed prices for products or services.

    See: https://api.freshservice.com/#purchase-order

.PARAMETER item_id
    Product id of the item to be ordered.

.PARAMETER item_type
    Type of item to be ordered. Product = 1 or Software = 2

.PARAMETER item_name
    Name of the items to be ordered.

.PARAMETER description
    Item description.

.PARAMETER cost
    Cost of the item.

.PARAMETER quantity
    Quantity of item to be ordered.

.PARAMETER tax_percentage
    Percentage of tax on item cost.

.EXAMPLE
    New-FreshServicePurchaseItem -item_id 21000056899 -item_type 1 -item_name "Dell 22-inch Monitor" -description 'Dell 22-inch Monitor Model DELLMON22-2023' -cost 200.00 -quantity 2 -tax_percentage 5

    item_name      : Dell 22-inch Monitor
    item_id        : 21000056899
    description    : Dell 22-inch Monitor Model DELLMON22-2023
    cost           : 200
    quantity       : 2
    item_type      : 1
    tax_percentage : 5

    Creates a new Freshservice purchase item for a Dell 22-inch Monitor.  Item id references the Product Id of a Freshservice Product.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServicePurchaseItem {
    [OutputType('System.Object[]')]
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Type of item to be ordered.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('product_id')]
        [long]$item_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Type of item to be ordered.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,2)]
        [int]$item_type,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the items to be ordered.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$item_name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Item description.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Cost of the item.',
            ValueFromPipelineByPropertyName = $true
        )]
        [decimal]$cost,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Represents the number of units of a particular line item.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$quantity,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'To add any additional comments for a particular line item.',
            ValueFromPipelineByPropertyName = $true
        )]
        [decimal]$tax_percentage
    )
    begin {

    }
    process {
        if ($PSCmdlet.ShouldProcess($item_id)) {
            $jsonBody = @{}
            $PSBoundParameters.keys.where{
                $PSItem -notin $PrivateData.FreshserviceBodyExclusions
            }.foreach{
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }

            [pscustomobject[]]$jsonBody
        }
    }
    end {}
}
