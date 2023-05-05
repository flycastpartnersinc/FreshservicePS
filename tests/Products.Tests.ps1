
Describe "Products" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid

            $asset_type_id = Get-FreshServiceAssetType |
                                Where-Object -FilterScript {$_.name -eq 'Computer'} |
                                    Select-Object -ExpandProperty id

            $newFreshServiceProductSplat = @{
                name                = 'Pester {0}' -f $guid
                description         = 'Test product from Pester: {0}' -f $guid
                asset_type_id       = $asset_type_id
                manufacturer        = 'Pester'
                status              = 'In Production'
                mode_of_procurement = 'Buy'
            }

            $Script:newFSProduct = New-FreshServiceProduct @newFreshServiceProductSplat

        }

        Context "Create" {
            It "New-FreshServiceProduct should create a New FreshService Product." -Tag "Product" {
               $newFSProduct | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                           'name',
                           'manufacturer',
                           'asset_type_id',
                           'description',
                           'description_text',
                           'depreciation_type_id',
                           'status',
                           'mode_of_procurement')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Product" {
                $newFSProduct.PSObject.Properties.Name | Should -Contain $_
            }

        }

        Context "View and List" {
            It "Get-FreshServiceProduct should return data" -Tag "Product" {
                $products = Get-FreshServiceProduct
                $products | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceProduct -id should return the test Product" -Tag "Product" {
                $product = Get-FreshServiceProduct -id $newFSProduct.ID
                $product.name | Should -BeLike "*$guid"
            }
            It "Get-FreshServiceProduct -id should throw on bad id" -Tag "Product" {
                {Get-FreshServiceProduct -id $guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceProduct should change the -status of Product to Retired" -Tag "Product" {
                Set-FreshServiceProduct -id $newFSProduct.Id -status Retired |
                    Select-Object -ExpandProperty status |
                        Should -Be "Retired"
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceProduct should delete the Product" -Tag "Product" {
                Remove-FreshServiceProduct -id $newFSProduct.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
