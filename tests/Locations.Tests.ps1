
Describe "Locations" {
    InModuleScope PSFreshservice {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:location_test_guid = New-Guid
            $Script:testerEmail = 'rob.simmers@flycastpartners.com'

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $newFreshServiceLocationSplat = @{
                name = ('Richmond {0}' -f $location_test_guid)
                address = @{
                    line1   = '123 Anywhere Ln'
                    line2   = 'Suite 1'
                    city    = 'Richmond'
                    state   = 'VA'
                    country = 'US'
                    zipcode = '23117'
                }
                primary_contact_id = $agent_id

            }

            $Script:newFSLocation = New-FreshServiceLocation @newFreshServiceLocationSplat
        }

        Context "Create" {
            It "New-FreshServiceLocation should create a New FreshService Location." -Tag "Location" {
               $newFSLocation | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                            'name',
                            'parent_location_id',
                            'primary_contact_id',
                            'address')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Location" {
                $newFSLocation.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceLocation should return data" -Tag "Location" {
                $locations = Get-FreshServiceLocation
                $locations | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceLocation -id should return the test Location" -Tag "Location" {
                $location= Get-FreshServiceLocation -id $newFSLocation.ID
                $location.name | Should -BeLike "*$location_test_guid"
            }
            It "Get-FreshServiceLocation -id should throw on bad id" -Tag "Location" {
                {Get-FreshServiceLocation -id $location_test_guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceLocation should change the -contact_name of Location to John Smith" -Tag "Location" {
                Set-FreshServiceLocation -id $newFSLocation.Id -contact_name "John Smith" |
                    Select-Object -ExpandProperty contact_name |
                        Should -Be "John Smith"
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceLocation should delete the Location" -Tag "Location" {
                Remove-FreshServiceLocation -id $newFSLocation.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
