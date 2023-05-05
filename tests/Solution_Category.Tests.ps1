
Describe "Solution Category" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid

            $newFreshServiceSolutionCategorySplat = @{
                name        = ('Category {0}' -f $guid)
                description = "Pester Test Category"
            }

            $Script:newFSSolutionCategory = New-FreshServiceSolutionCategory @newFreshServiceSolutionCategorySplat
        }

        Context "Create" {
            It "New-FreshServiceSolutionCategory should create a New FreshService SolutionCategory." -Tag "Solution Category" {
               $newFSSolutionCategory | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                           'name',
                           'description',
                           'default_category',
                           'position',
                           'translations')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Solution Category" {
                $newFSSolutionCategory.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceSolutionCategory should return data" -Tag "Solution Category" {
                $solCat = Get-FreshServiceSolutionCategory
                $solCat | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceSolutionCategory -id should return the test SolutionCategory" -Tag "Solution Category" {
                $solCat = Get-FreshServiceSolutionCategory -id $newFSSolutionCategory.ID
                $solCat.name | Should -BeLike "*$guid"
            }
            It "Get-FreshServiceSolutionCategory -id should throw on bad id" -Tag "Solution Category" {
                {Get-FreshServiceSolutionCategory -id $guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceSolutionCategory should change the -description of SolutionCategory to 'Updated Desc'" -Tag "Solution Category" {
                Set-FreshServiceSolutionCategory -id $newFSSolutionCategory.Id -description "Updated Desc" |
                    Select-Object -ExpandProperty description |
                        Should -Be "Updated Desc"
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceSolutionCategory should delete the SolutionCategory" -Tag "Solution Category" {
                Remove-FreshServiceSolutionCategory -id $newFSSolutionCategory.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
