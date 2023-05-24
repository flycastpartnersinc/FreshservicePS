
Describe "Assets" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:asset_test_guid = New-Guid

            $asset_types = Get-FreshServiceAssetType

            $hardware_layer_id = $asset_types |
                                    Where-Object -FilterScript {$_.name -eq 'Hardware'} |
                                        Select-Object -ExpandProperty id

            $computer_layer_id = $asset_types |
                                    Where-Object -FilterScript {$_.name -eq 'Computer'} |
                                        Select-Object -ExpandProperty id

            $switch_layer_id = $asset_types |
                                        Where-Object -FilterScript {$_.name -eq 'Switch'} |
                                            Select-Object -ExpandProperty id

            $manufacturer_id = Get-FreshServiceVendor |
                                    Where-Object -FilterScript{$_.name -eq 'Dell'}  |
                                        Select-Object -ExpandProperty id

            $asset_type_id = Get-FreshServiceAssetType |
                                Where-Object -FilterScript {$_.name -eq 'Laptop'} |
                                    Select-Object -ExpandProperty id

            $user_id = Get-FreshServiceRequester |
                            Select-Object -First 1 -ExpandProperty id

            $location_id = Get-FreshServiceLocation |
                                Select-Object -Skip 2 -First 1 -ExpandProperty id

            $department_id = Get-FreshServiceDepartment |
                                 Select-Object -Skip 2 -First 1 -ExpandProperty id

            $newFreshServiceProductSplat = @{
                name               = "Dell Laptop XPS 17 {0}" -f $asset_test_guid
                asset_type_id      = $asset_type_id
                description        = "Dell Laptop XPS 17 {0}" -f $asset_test_guid
                manufacturer       = $manufacturer_id
                mode_of_procurement = 'Buy'
            }

            $product_id = New-FreshServiceProduct @newFreshServiceProductSplat

            $Script:asset_name = 'Laptop{0}' -f $asset_test_guid

            $assetParams = @{
                name          = $asset_name
                description   = 'New Laptop from Pester: {0}' -f $asset_test_guid
                asset_type_id = $asset_type_id
                asset_tag     = "LAP-{0}" -f $asset_test_guid
                impact        = 'Low'
                usage_type    = 'Permanent'
                user_id       = $user_id
                location_id   = $location_id
                assigned_on   = (Get-Date)
                type_fields = @{
                    ('product_{0}' -f $hardware_layer_id)     = ($product_id | Select-Object -ExpandProperty id)
                    ('asset_state_{0}' -f $hardware_layer_id) = 'In Stock'
                    ('hostname_{0}' -f $computer_layer_id)    = 'Laptop{0}' -f $asset_test_guid
                }
            }

            $Script:newFreshServiceAsset = New-FreshServiceAsset @assetParams

            $Script:sec_guid = New-Guid

            $sec_asset_type_id = Get-FreshServiceAssetType |
                                Where-Object -FilterScript {$_.name -eq 'Switch'} |
                                    Select-Object -ExpandProperty id

            $secFreshServiceProductSplat = @{
                name               = "Dell PowerConnect 2808 {0}" -f $asset_test_guid
                asset_type_id      = $asset_type_id
                description        = "PC2808 - Dell PowerConnect 2808 8 x Ports 10/100/1000Base-T Gigabit Ethernet Managed Network Switch {0}" -f $asset_test_guid
                manufacturer       = $manufacturer_id
                mode_of_procurement = 'Buy'
            }

            $sec_product_id = New-FreshServiceProduct @secFreshServiceProductSplat

            $sec_asset_name = 'Dell PowerConnect 2808{0}' -f $sec_guid

            $secAssetParams = @{
                name          = $sec_asset_name
                description   = 'Dell PowerConnect 2808: {0}' -f $sec_guid
                asset_type_id = $sec_asset_type_id
                asset_tag     = "SWCH-{0}" -f $sec_guid
                impact        = 'Medium'
                usage_type    = 'Permanent'
                department_id = $department_id
                assigned_on   = (Get-Date)
                type_fields = @{
                    ('product_{0}' -f $hardware_layer_id)     = ($sec_product_id | Select-Object -ExpandProperty id)
                    ('asset_state_{0}' -f $hardware_layer_id) = 'In Use'
                    ('ip_address_{0}' -f $switch_layer_id)    = '10.10.10.10'
                    ('subnet_mask_{0}' -f $switch_layer_id)   = '255.255.255.0'
                }
            }

            $Script:secFreshServiceAsset = New-FreshServiceAsset @secAssetParams

            $relationship_type_id = Get-FreshServiceRelationshipType |
                            Where-Object -FilterScript {$_.downstream_relation -eq 'Routes Traffic'} |
                                Select-Object -ExpandProperty id

            $newFreshServiceRelationshipItemSplat = @{
                relationship_type_id = $relationship_type_id #Get-FreshServiceRelationshipType
                primary_id           = $secFreshServiceAsset.display_id
                primary_type         = 'asset'
                secondary_id         = $newFreshServiceAsset.display_id
                secondary_type       = 'asset'
            }

            $relationship_item = New-FreshServiceRelationshipItem @newFreshServiceRelationshipItemSplat

            $Script:newFreshServiceRelationship = New-FreshServiceRelationship -relationship_item $relationship_item
        }

        Context "Create" {
            It "New-FreshServiceAsset should create a New FreshService Asset." -Tag "Asset" {
               $newFreshServiceAsset | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceAsset should create a secondary New FreshService Asset." -Tag "Asset" {
                $secFreshServiceAsset | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                           'display_id',
                           'name',
                           'description',
                           'asset_type_id',
                           'impact',
                           'author_type',
                           'usage_type',
                           'asset_tag',
                           'user_id',
                           'department_id',
                           'location_id',
                           'agent_id',
                           'group_id',
                           'assigned_on',
                           'end_of_life',
                           'discovery_enabled')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Asset" {
                $newFreshServiceAsset.PSObject.Properties.Name | Should -Contain $_
            }
            It "New-FreshServiceRelationship should create a job for asset relationship." -Tag "Relationship" {
                $newFreshServiceRelationship | Should -Not -BeNullOrEmpty
            }
        }

        Context "View and List" {
            It "Get-FreshServiceAsset should return data" -Tag "Asset" {
                $assets = Get-FreshServiceAsset
                $assets | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAsset -display_id should return the test Asset" -Tag "Asset" {
                $asset = Get-FreshServiceAsset -display_id $newFreshServiceAsset.display_id
                $asset.name | Should -BeLike "*$asset_test_guid"
            }
            It "Get-FreshServiceAsset -id should throw on bad id" -Tag "Asset" {
                {Get-FreshServiceAsset -display_id $asset_test_guid} |
                    Should -Throw
            }
            It "Get-FreshServiceBackground should return data" -Tag "Job" {
                #Adding sleep to allow time for job to complete before testing
                Start-Sleep -Seconds 5
                $job = Get-FreshServiceBackgroundJob -Id $newFreshServiceRelationship.job_id
                $job.status | Should -Be 'success'
            }
            It "Get-FreshserviceRelationship should return data" -Tag "Relationship" {
                $relationships = Get-FreshServiceRelationship
                $relationships | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAsset -relationships should return data" -Tag "Relationship" {
                $Script:asset_rel = Get-FreshServiceAsset -display_id $newFreshServiceAsset.display_id -relationships
                $asset_rel | Should -Not -BeNullOrEmpty
            }
        }

        Context "Search and Filter" {
            It ("Get-FreshServiceAsset -name {0} should return data" -f $asset_name) -Tag "Asset" {
                #Adding sleep to allow time for indexing for search\filters to work
                Start-Sleep -Seconds 5
                $assets = Get-FreshServiceAsset -name $asset_name
                $assets | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAsset -filter user_id:$($newFreshServiceAsset.user_id) should return data" -Tag "Asset" {
                $assets = Get-FreshServiceAsset -filter "user_id:$($newFreshServiceAsset.user_id)"
                $assets | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAsset -filter should return data" -Tag "Asset" {
                $date = (Get-Date).AddHours(-1).ToString('yyyy-MM-dd')
                $assets = Get-FreshServiceAsset -filter "created_at:>'$date'"
                $assets | Should -Not -BeNullOrEmpty
            }
        }

        Context "Set" {
            It "Set-FreshServiceAsset should change the -usage_type of Asset to Retired" -Tag "Asset" {
                Set-FreshServiceAsset -display_id $newFreshServiceAsset.display_id -usage_type loaner |
                    Select-Object -ExpandProperty usage_type |
                        Should -Be "loaner"
            }
        }

        Context "Restore" {
            It "Remove-FreshServiceAsset should soft delete the Asset" -Tag "Asset" {
                Remove-FreshServiceAsset -display_id $newFreshServiceAsset.display_id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceAsset should delete the Asset" -Tag "Asset" {
                Restore-FreshServiceAsset -display_id $newFreshServiceAsset.display_id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceRelationship should delete the Relationship" -Tag "Relationship" {
                Remove-FreshServiceRelationship -id $asset_rel.id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceAsset should delete the Asset" -Tag "Asset" {
                Remove-FreshServiceAsset -display_id $newFreshServiceAsset.display_id -delete_forever |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceAsset should delete the Asset" -Tag "Asset" {
                Remove-FreshServiceAsset -display_id $secFreshServiceAsset.display_id -delete_forever |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
