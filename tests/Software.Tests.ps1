
Describe "Software" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:software_test_guid = New-Guid
            $Script:testerEmail = $env:FreshservicePS_Instance_Admin_Email

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $publisher_id = Get-FreshserviceVendor |
                                Where-Object -FilterScript {$_.Name -eq 'Microsoft'} |
                                    Select-Object -ExpandProperty id

            $newFreshserviceSoftwareSplat = @{
                name             = 'Microsoft Visual Studio Code {0}' -f $software_test_guid
                description      = 'Visual Studio Code is a streamlined code editor with support for development operations like debugging, task running, and version control. It aims to provide just the tools a developer needs for a quick code-build-debug cycle and leaves more complex workflows to fuller featured IDEs, such as Visual Studio IDE'
                application_type = 'desktop'
                status           = 'managed'
                publisher_id     = $publisher_id
                notes            = 'VS Code runs on macOS, Linux, and Windows. VS Code is free for private or commercial use.'
                category         = 'Internal'
                source           = 'API'
                managed_by_id    =  $agent_id
            }

            $script:newFSSoftware = New-FreshserviceSoftware @newFreshserviceSoftwareSplat

            $Script:user_ids = Get-FreshServiceRequester |
                Where-Object -FilterScript {$_.primary_email -like '*freshservice.com'}

            $Script:assetTypes = Get-FSAssetType |
                                    Where-Object -FilterScript {'Laptop','Desktop' -contains $_.name} |
                                        Select-Object -ExpandProperty id

            $Script:installation_machine_ids = Get-FreshServiceAsset |
                Where-Object -FilterScript { $assetTypes -contains $_.asset_type_id -and $_.name -like 'Andrea*'} |
                    Select-Object -First 1
        }

        Context "New"  -Tag "Software" {
            It "New-FreshServiceSoftware should create a New FreshService Software." {
               $newFSSoftware | Should -Not -BeNullOrEmpty
            }

            $properties = ('additional_data',
                           'user_count',
                           'installation_count',
                           'id',
                           'name',
                           'description',
                           'notes',
                           'publisher_id',
                           'application_type',
                           'status',
                           'managed_by_id',
                           'category',
                           'sources')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Software" {
                $newFSSoftware.PSObject.Properties.Name | Should -Contain $_
            }
            It "New-FreshServiceSoftwareUser adds user <_.primary_email> to Software" -ForEach $user_ids -Tag "Users" {
                    $suParams = @{
                        software_id    = $newFSSoftware.id #Get-FreshworksSoftware
                        user_id        = $_.id #Get-FreshServiceRequester
                        #license_id     = 10 #Get-FreshserviceContract
                        allocated_date = (Get-Date -Date '10/10/2022 12:00:00 AM')
                        first_used     = (Get-Date -Date '11/10/2022 12:00:00 AM')
                        last_used      = Get-Date
                        source         = 'API'
                    }

                    New-FreshServiceSoftwareUser @suParams | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceSoftwareInstallation adds asset <_.name> to Software installation" -ForEach $installation_machine_ids -Tag "Installation" {

                    $newFreshServiceSoftwareInstallationSplat = @{
                        id                      = $newFSSoftware.id
                        installation_machine_id = $_.display_id
                        installation_path       = 'C:\MySoftware'
                        version                 = "10.0.1"
                        installation_date       = (Get-Date)
                    }

                    Start-Sleep -Seconds 2
                    New-FreshServiceSoftwareInstallation @newFreshServiceSoftwareInstallationSplat |
                        Should -Not -BeNullOrEmpty
            }

        }

        Context "Get" {
            It "Get-FreshServiceSoftware should return data" -Tag "Software" {
                $software = Get-FreshServiceSoftware
                $software | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceSoftware -id should return the test Software" -Tag "Software" {
                $software = Get-FreshServiceSoftware -id $newFSSoftware.ID
                $software.name | Should -BeLike "*$software_test_guid"
            }
            It "Get-FreshServiceSoftwareUser should return software users" -Tag "Users" {
                $Script:swUser = Get-FreshServiceSoftwareUser -software_id $newFSSoftware.id
                $swUser | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceSoftware -id should return the test Software user" -Tag "Users" {
                Get-FreshServiceSoftwareUser -software_id $newFSSoftware.id -id $swUser[0].id |
                Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceSoftwareInstallation should return software installation" -Tag "Installation" {
                $Script:swInstall = Get-FreshServiceSoftwareInstallation -software_id $newFSSoftware.id
                $swInstall | Should -Not -BeNullOrEmpty
            }

            #Relationships are built in asset module
            # It "Get-FreshServiceSoftware -relationship should return software relationships" -Tag "Relationship" {
            #     $swRel = Get-FreshServiceSoftware -software_id $newFSSoftware.id -relationships
            #     $swRel | Should -Not -BeNullOrEmpty
            # }

        }

        Context "Set" {
            It "Set-FreshServiceSoftware should update Software description to Updated desc" -Tag "Software" {
                Set-FreshServiceSoftware -id $newFSSoftware.Id -description "Updated desc" |
                    Select-Object -ExpandProperty description |
                        Should -Be "Updated desc"
            }
            It "Set-FreshServiceSoftwareUser should update Software user last_used date" -Tag "User" {
                $suParams = @{
                    software_id    = $newFSSoftware.id #Get-FreshworksSoftware
                    user_id        = $swUser[0].user_id #Get-FreshServiceRequester
                    last_used      = Get-Date
                }

                Set-FreshServiceSoftwareUser @suParams |
                    Should -Not -BeNullOrEmpty

            }
        }

        Context "Remove" {
            It "Remove-FreshServiceSoftwareUser should delete the user from the Software" -Tag "User" {
                Remove-FreshServiceSoftwareUser -software_id $newFSSoftware.id -user_id $swUser[0].user_id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceSoftwareInstallation should delete installation (asset) from the Software" -Tag "Installation" {
                Remove-FreshServiceSoftwareInstallation -software_id $newFSSoftware.id -installation_machine_id $swInstall[0].installation_machine_id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }

            It "Remove-FreshServiceSoftware should soft delete the Software" -Tag "Software" {
                Remove-FreshServiceSoftware -id $newFSSoftware.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

    }
}
