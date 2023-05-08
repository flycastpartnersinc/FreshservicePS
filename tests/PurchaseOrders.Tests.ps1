
Describe "Purchase Orders" {
    InModuleScope PSFreshservice {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:purchase_order_test_guid = New-Guid

            $vendor_id = Get-FreshServiceVendor |
                            Where-Object -FilterScript {$_.name -eq 'Dell' } |
                                Select-Object -ExpandProperty Id

            $item_id = Get-FreshServiceProduct |
                            Where-Object -FilterScript {$_.Name -eq 'Dell 22-inch Monitor'} |
                                Select-Object -ExpandProperty id

            $purchaseItemSplat = @{
                item_id              = $item_id
                item_type            = 1 #Product = 1, Software = 2
                item_name            = 'Dell 22-inch Monitor'
                description          = 'Dell 22-inch Monitor Model DELLMON22-2023'
                cost                 = 200.00
                quantity             = 2
                tax_percentage       = 5
            }

            $purchase_items = New-FreshServicePurchaseItem @purchaseItemSplat

            $poParams = @{
                vendor_id                = $vendor_id
                name                     = 'Purchase Order {0}' -f $purchase_order_test_guid
                po_number                = $purchase_order_test_guid
                vendor_details           = 'Dell Corporation'
                shipping_address         = '123 Nowhere Ave'
                billing_same_as_shipping = $true
                billing_address          = '123 Nowhere Ave'
                currency_code            = 'USD'
                purchase_items           =  $purchase_items
                expected_delivery_date   =  (Get-Date).AddDays(30)
            }

            $Script:newFSPurchaseOrder = New-FreshServicePurchaseOrder @poParams
        }

        Context "Create" {
            It "New-FreshServicePurchaseOrder should create a New FreshService Purchase Order." -Tag "Purchase Order" {
               $newFSPurchaseOrder | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                           'name',
                           'po_number',
                           'vendor_id',
                           'vendor_details',
                           'department_id',
                           'created_by',
                           'expected_delivery_date',
                           'shipping_address',
                           'billing_same_as_shipping',
                           'billing_address',
                           'created_at',
                           'updated_at',
                           'custom_fields',
                           'status',
                           'purchase_items',
                           'discount_percentage',
                           'tax_percentage',
                           'shipping_cost',
                           'total_cost',
                           'currency')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Purchase Order" {
                $newFSPurchaseOrder.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServicePurchaseOrder should return data" -Tag "Purchase Order" {
                $pos = Get-FreshServicePurchaseOrder
                $pos | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServicePurchaseOrder -id should return the test Purchase Order" -Tag "Purchase Order" {
                $po= Get-FreshServicePurchaseOrder -id $newFSPurchaseOrder.ID
                $po.name | Should -BeLike "*$purchase_order_test_guid"
            }
            It "Get-FreshServicePurchaseOrder -id should throw on bad id" -Tag "Purchase Order" {
                {Get-FreshServicePurchaseOrder -id $purchase_order_test_guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServicePurchaseOrder should change the -vendor_details of Purchase Order to Dell Inc" -Tag "Purchase Order" {
                Set-FreshServicePurchaseOrder -id $newFSPurchaseOrder.Id -vendor_details "Dell Inc" |
                    Select-Object -ExpandProperty vendor_details |
                        Should -Be "Dell Inc"
            }
        }

        Context "Delete" {
            It "Remove-FreshServicePurchaseOrder should delete the Purchase Order" -Tag "Purchase Order" {
                Remove-FreshServicePurchaseOrder -id $newFSPurchaseOrder.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
