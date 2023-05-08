Describe "Agent Groups" {
    InModuleScope PSFreshservice {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:agent_group_test_guid = New-Guid
            $Script:testerEmail = 'rob.simmers@flycastpartners.com'

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $business_hours_id = Get-FreshServiceBusinessHour |
                                    Select-Object -First 1 -ExpandProperty id

            $newFreshServiceAgentGroupSplat = @{
                name               = ('Pester Test {0}' -f $agent_group_test_guid)
                description        = ('Pester Test: {0}' -f $agent_group_test_guid)
                unassigned_for     = '30m'
                business_hours_id  = $business_hours_id
                escalate_to        = $agent_id
                auto_ticket_assign = $true
            }

            $script:newFSAgentGroup = New-FreshServiceAgentGroup @newFreshServiceAgentGroupSplat
        }

        Context "Create" {
            It "New-FreshServiceAgentGroup should create a New FreshService Agent Group." -Tag "Agent Group" {
               $newFSAgentGroup | Should -Not -BeNullOrEmpty
            }

        $properties = ('id',
                        'name',
                        'description',
                        'escalate_to',
                        'unassigned_for',
                        'business_hours_id',
                        'auto_ticket_assign',
                        'restricted',
                        'approval_required',
                    #    'ocs_schedule_id',
                        'agent_ids',
                        'members',
                        'observers',
                        'leaders')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Agent Group" {
                $newFSAgentGroup.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceAgentGroup should return data" -Tag "Agent Group" {
                $agentGroups = Get-FreshServiceAgentGroup
                $agentGroups | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAgentGroup -id should return the test agent group" -Tag "Agent Group" {
                $testAgentGroup = Get-FreshServiceAgentGroup -id $newFSAgentGroup.ID
                $testAgentGroup.description | Should -BeLike "*$agent_group_test_guid"
            }
            It "Get-FreshServiceAgentGroup -id should throw on bad id" -Tag "Agent Group" {
                {Get-FreshServiceAgentGroup -id $agent_group_test_guid} |
                    Should -Throw
            }
            It "Get-FreshServiceAgent -fields should get Agent fields" -Tag "Form" {
                {Get-FreshServiceAgent -fields} |
                    Should -Not -BeNullOrEmpty
            }
        }

        Context "Update" {
            It "Set-FreshServiceAgentGroup should change the -scoreboard_level_id of agent to 3" -Tag "Agent Group" {
                Set-FreshServiceAgentGroup -id $newFSAgentGroup.Id -auto_ticket_assign $false |
                    Select-Object -ExpandProperty auto_ticket_assign |
                        Should -Be $false
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceAgentGroup should delete the agent group" -Tag "Agent Group" {
                Remove-FreshServiceAgentGroup -id $newFSAgentGroup.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
