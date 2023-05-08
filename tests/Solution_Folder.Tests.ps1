
Describe "Solution Folder" {
    InModuleScope PSFreshservice {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:solution_folder_test_guid = New-Guid
            $Script:testerEmail = 'rob.simmers@flycastpartners.com'

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $Script:category_id = Get-FreshServiceSolutionCategory |
                                Where-Object -FilterScript {$_.name -eq 'General'} |
                                    Select-Object -ExpandProperty id

            $group_ids = Get-FreshServiceAgentGroup |
                            Where-Object -FilterScript {$_.name -like 'H*Team*'} |
                                Select-Object -ExpandProperty id

            $newFreshServiceSolutionFolderSplat = @{
                name        = ('Folder {0}' -f $solution_folder_test_guid)
                description = "Pester Test Folder"
                category_id = $category_id
                visibility  = 1 #All
                approval_settings = @{
                    "approval_type" = 1 #All
                    "approver_ids"  = @($agent_id)
                }
                manage_by_group_ids = @($group_ids)
            }

            $Script:newFSSolutionFolder = New-FreshServiceSolutionFolder @newFreshServiceSolutionFolderSplat
        }

        Context "Create" {
            It "New-FreshServiceSolutionFolder should create a New FreshService SolutionFolder." -Tag "Solution Folder" {
               $newFSSolutionFolder | Should -Not -BeNullOrEmpty
            }

            $properties = ('description',
                           'id',
                           'name',
                           'category_id',
                           'position',
                           'visibility',
                           'approval_settings',
                           'default_folder',
                           'manage_by_group_ids')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Solution Folder" {
                $newFSSolutionFolder.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceSolutionFolder should return data" -Tag "Solution Folder" {
                $solCat = Get-FreshServiceSolutionFolder -category_id $category_id
                $solCat | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceSolutionFolder -id should return the test SolutionFolder" -Tag "Solution Folder" {
                $solCat = Get-FreshServiceSolutionFolder -category_id $category_id -id $newFSSolutionFolder.ID
                $solCat.name | Should -BeLike "*$solution_folder_test_guid"
            }
            It "Get-FreshServiceSolutionFolder -id should throw on bad id" -Tag "Solution Folder" {
                {Get-FreshServiceSolutionFolder -category_id $category_id -id $solution_folder_test_guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceSolutionFolder should change the -description of SolutionFolder to 'Updated Desc'" -Tag "Solution Folder" {
                Set-FreshServiceSolutionFolder -id $newFSSolutionFolder.Id -description "Updated Desc" |
                    Select-Object -ExpandProperty description |
                        Should -Be "Updated Desc"
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceSolutionFolder should delete the SolutionFolder" -Tag "Solution Folder" {
                Remove-FreshServiceSolutionFolder -id $newFSSolutionFolder.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
