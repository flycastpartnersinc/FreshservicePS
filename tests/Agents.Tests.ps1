Describe "Agents" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:agent_test_guid = New-Guid
            $Script:testerEmail = 'agent.{0}@mailinator.com' -f (Get-Date).TimeOfDay.Ticks

            $role_id = Get-FreshServiceAgentRole |
                            Where-Object -FilterScript {$_.name -eq 'SD Agent'} |
                                Select-Object -ExpandProperty id

            # $groups = Get-FreshServiceAgentGroup |
            #             Where-Object -FilterScript {$_.name -like '*Incident Team'} |
            #                 Select-Object -ExpandProperty Id

            $newFreshServiceAgentRoleConfigSplat = @{
                role_id          = $role_id
                assignment_scope = 'entire_helpdesk'
                # groups           = $groups
                workspace_id     = 3
            }

            $newAgtRole = New-FreshServiceAgentRoleConfig @newFreshServiceAgentRoleConfigSplat

            $newFreshServiceAgentSplat = @{
                first_name             = 'Sam'
                last_name              = 'Sung'
                job_title              = 'Pester Test: {0}' -f $agent_test_guid
                email                  = $testerEmail
                background_information = 'Awesome helpdesk training'
                roles                  = $newAgtRole
                time_zone              = 'Eastern Time (US & Canada)'
                workspace_ids          = 3
                scoreboard_level_id    = 3
            }

            $Script:newFSAgent = New-FreshServiceAgent @newFreshServiceAgentSplat

        }

        Context "New" {
            It "New-FreshServiceAgent should create a New FreshService agent." -Tag "Agent" {
               $newFSAgent | Should -Not -BeNullOrEmpty
            }

            $rowNum = 0
            foreach ($agt in $newFSAgent)  {
                $rowNum++
                Context "Validating Agent schema on object $rowNum has the correct properties" -Tag "Agent" {
                    # Load an array with the properties we need to look for
                    $properties = ('active',
                                   'auto_assign_status_changed_at',
                                   'auto_assign_tickets',
                                   'background_information',
                                   'can_see_all_tickets_from_associated_departments',
                                   'external_id',
                                   'first_name',
                                   'has_logged_in',
                                   'id',
                                   'last_active_at',
                                   'last_login_at',
                                   'occasional',
                                   'role_ids',
                                   'roles',
                                   'scopes',
                                   'scoreboard_level_id',
                                   'scoreboard_points',
                                   'observer_of',
                                   'member_of_pending_approval',
                                   'observer_of_pending_approval')

                    foreach ($property in $properties) {
                        It "Agent schema on object $rowNum should have a property of $property" {
                            [bool]($agt.PSObject.Properties.Name -match $property) |
                                Should -BeTrue
                        }
                    }
                }
            }
        }

        Context "Get" {
            It "Get-FreshServiceAgent should return data" -Tag "Agent" {
                $agents = Get-FreshServiceAgent
                $agents | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAgent -id should return the test agent" -Tag "Agent" {
                $testAgent = Get-FreshServiceAgent -id $newFSAgent.ID
                $testAgent.job_title | Should -BeLike "*$agent_test_guid"
            }
            It "Get-FreshServiceAgent -filter should return agents" -Tag "Agent" {
                {Get-FreshServiceAgent -filter "email:'$testerEmail' AND time_zone:'Eastern Time (US & Canada)'"} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAgent -id should throw on bad id" -Tag "Agent" {
                {Get-FreshServiceAgent -id $agent_test_guid} |
                    Should -Throw
            }
            It "Get-FreshServiceAgent -fields should get Agent fields" -Tag "Form" {
                {Get-FreshServiceAgent -fields} |
                    Should -Not -BeNullOrEmpty
            }
        }

        Context "Set" {
            It "Set-FreshServiceAgent should change the -mobile_phone_number of agent to 1234" -Tag "Agent" {
                Set-FreshServiceAgent -id $newFSAgent.Id -mobile_phone_number 1234 |
                    Select-Object -ExpandProperty mobile_phone_number |
                        Should -Be 1234
            }
        }

        Context "Deactivate" {
            It "Remove-FreshServiceAgent should soft delete the parent agent" -Tag "Agent" {
                Remove-FreshServiceAgent -id $newFSAgent.Id|
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        Context "Reactivate" {
            It "Set-FreshServiceAgent should restore deleted agent" -Tag "Agent" {
                Set-FreshServiceAgent -id $newFSAgent.Id -reactivate |
                    Select-Object -ExpandProperty active |
                        Should -Be $true
            }
        }

        Context "Forget" {
            It "Remove-FreshServiceAgent should soft delete the parent agent" -Tag "Agent" {
                Remove-FreshServiceAgent -id $newFSAgent.Id -Forget |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
