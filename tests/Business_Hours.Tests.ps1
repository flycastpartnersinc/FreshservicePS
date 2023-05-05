
Describe "Business Hours" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
        }
        Context "View and List" {
            It "Get-FreshServiceBusinessHour should return data" -Tag "Business Hours" {
                $Script:bizHours = Get-FreshServiceBusinessHour
                $bizHours | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceBusinessHour -id should return the test Business Hours" -Tag "Business Hours" {
                $bizHour = Get-FreshServiceBusinessHour -id $bizHours[0].id
                $bizHour | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceBusinessHour -id should throw on bad id" -Tag "Business Hours" {
                {Get-FreshServiceBusinessHour -id $guid} |
                    Should -Throw
            }
        }
    }
}
