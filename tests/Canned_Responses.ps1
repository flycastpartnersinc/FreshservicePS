
Describe "Canned Responses" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
        }
        Context "View and List" {
            It "Get-FreshServiceCannedResponseFolder should return data" -Tag "Canned Folders" {
                $Script:cannedFldrs = Get-FreshServiceCannedResponseFolder
                $cannedFldrs | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCannedResponseFolder -id should return the test Canned Responses" -Tag "Canned Folders" {
                $cannedFldr = Get-FreshServiceCannedResponseFolder -id $cannedFldrs[0].id
                $cannedFldr | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCannedResponseFolder -id should throw on bad id" -Tag "Canned Folders" {
                {Get-FreshServiceCannedResponseFolder -id $guid} |
                    Should -Throw
            }
            It "Get-FreshServiceCannedResponse should return data" -Tag "Canned Response" {
                $Script:cannedResps = Get-FreshServiceCannedResponse
                $cannedResps | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCannedResponse -id should return the test Canned Responses" -Tag "Canned Response" {
                $cannedResp = Get-FreshServiceCannedResponse -id $cannedResps[0].id
                $cannedResp | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCannedResponse -id should throw on bad id" -Tag "Canned Response" {
                {Get-FreshServiceCannedResponse -id $guid} |
                    Should -Throw
            }

        }
    }
}
