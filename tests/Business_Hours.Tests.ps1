
Describe "Business Hours" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:business_hour_test_guid = New-Guid
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
                {Get-FreshServiceBusinessHour -id $business_hour_test_guid} |
                    Should -Throw
            }
        }
    }
}
