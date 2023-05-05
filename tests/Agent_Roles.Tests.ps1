
Describe "Agents" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:agentRoles = Get-FreshServiceAgentRole
        }
        Context "Get" {
            It "Get-FreshServiceAgentRole should return data" -Tag "AgentRole" {
                $agentRoles | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAgentRole -id should return the test agent" -Tag "AgentRole" {
                $agentRole = Get-FreshServiceAgentRole -id $agentRoles[0].ID
                $agentRole | Should -Not -BeNullOrEmpty
            }
        }

    }
}
