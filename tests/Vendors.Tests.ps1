
Describe "Vendors" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid

            $venParams = @{
                name = "Vendor {0}" -f $guid
                description = "My vendor description"
                address = @{
                    line1   = "123 Corporate Avenue"
                    city    = "Jacksonville"
                    state   = "Florida"
                    country = "USA"
                    zipcode = "32217"
                }
            }

            $Script:newFSVendor = New-FreshServiceVendor @venParams

        }

        Context "Create" {
            It "New-FreshServiceVendor should create a New FreshService Vendor." -Tag "Vendor" {
               $newFSVendor | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                           'name',
                           'primary_contact_id',
                           'address',
                           'contact_name')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Vendor" {
                $newFSVendor.PSObject.Properties.Name | Should -Contain $_
            }

        }

        Context "View and List" {
            It "Get-FreshServiceVendor should return data" -Tag "Vendor" {
                $vendors = Get-FreshServiceVendor
                $vendors | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceVendor -id should return the test Vendor" -Tag "Vendor" {
                $vendor= Get-FreshServiceVendor -id $newFSVendor.ID
                $vendor.name | Should -BeLike "*$guid"
            }
            It "Get-FreshServiceVendor -id should throw on bad id" -Tag "Vendor" {
                {Get-FreshServiceVendor -id $guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceVendor should change the -description of Vendor to Test" -Tag "Vendor" {
                Set-FreshServiceVendor -id $newFSVendor.Id -description "Test" |
                    Select-Object -ExpandProperty description |
                        Should -Be "Test"
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceVendor should delete the Vendor" -Tag "Vendor" {
                Remove-FreshServiceVendor -id $newFSVendor.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
