
Describe "Workspaces" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:workspace_test_guid = New-Guid
        }
        Context "View and List" {
            It "Get-FreshServiceWorkspace should return data" -Tag "Workspaces" {
                $Script:bizHours = Get-FreshServiceWorkspace
                $bizHours | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceWorkspace -id should return the test Workspaces" -Tag "Workspaces" {
                $bizHour = Get-FreshServiceWorkspace -id $bizHours[0].id
                $bizHour | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceWorkspace -id should throw on bad id" -Tag "Workspaces" {
                {Get-FreshServiceWorkspace -id $workspace_test_guid} |
                    Should -Throw
            }
        }
    }
}
