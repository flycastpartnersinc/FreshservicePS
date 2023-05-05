
Describe "Service Catalog" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
        }
        Context "View and List" {
            It "Get-FreshServiceCatalogItem should return data" -Tag "Catalog Item" {
                $Script:catItems = Get-FreshServiceCatalogItem
                $catItems | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCatalogItem -id should return the test Catalog Item" -Tag "Catalog Item" {
                $catItem = Get-FreshServiceCatalogItem -display_id $catItems[0].display_id
                $catItem | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCatalogItem -id should throw on bad id" -Tag "Catalog Item" {
                {Get-FreshServiceCatalogItem -display_id $guid} |
                    Should -Throw
            }
            It "Get-FreshServiceCatalogCategory should return data" -Tag "Service Category" {
                $Script:categories = Get-FreshServiceCatalogCategory
                $categories | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCatalogCategory -id should return the test Catalog Item" -Tag "Service Category" {
                $category = Get-FreshServiceCatalogCategory -id $categories[0].id
                $category | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCatalogCategory -id should throw on bad id" -Tag "Catalog Item" {
                {Get-FreshServiceCatalogCategory -id $guid} |
                    Should -Throw
            }
        }

    }
}
