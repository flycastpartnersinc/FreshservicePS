
Describe "Departments" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
            $Script:testerEmail = 'rob.simmers@flycastpartners.com'

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $newFreshServiceDepartmentSplat = @{
                name          = ('Department {0}' -f $guid)
                description   = ('Department {0}' -f $guid)
                head_user_id  = $agent_id
                prime_user_id = $agent_id
                domains       = "foo$guid.com","faa$guid.com"
            }

            $Script:newFSDepartment = New-FreshServiceDepartment @newFreshServiceDepartmentSplat
        }

        Context "Create" {
            It "New-FreshServiceDepartment should create a New FreshService Department." -Tag "Department" {
               $newFSDepartment | Should -Not -BeNullOrEmpty
            }

            $properties = ('description',
                           'custom_fields',
                           'id',
                           'name',
                           'prime_user_id',
                           'head_user_id',
                           'domains')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Department" {
                $newFSDepartment.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceDepartment should return data" -Tag "Department" {
                $Departments = Get-FreshServiceDepartment
                $Departments | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceDepartment -id should return the test Department" -Tag "Department" {
                $Department = Get-FreshServiceDepartment -id $newFSDepartment.ID
                $Department.name | Should -BeLike "*$guid"
            }
            It "Get-FreshServiceDepartment -id should throw on bad id" -Tag "Department" {
                {Get-FreshServiceDepartment -id $guid} |
                    Should -Throw
            }
            It "Get-FreshServiceDepartment -fields should get Department fields" -Tag "Form" {
                {Get-FreshServiceDepartment -fields} |
                    Should -Not -BeNullOrEmpty
            }
        }

        Context "Set" {
            It "Set-FreshServiceDepartment should change the -description of Department to 'Updated Desc'" -Tag "Department" {
                Set-FreshServiceDepartment -id $newFSDepartment.Id -description "Updated Desc" |
                    Select-Object -ExpandProperty description |
                        Should -Be "Updated Desc"
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceDepartment should delete the Department" -Tag "Department" {
                Remove-FreshServiceDepartment -id $newFSDepartment.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
