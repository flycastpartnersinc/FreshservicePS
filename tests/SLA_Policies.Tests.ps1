Describe "SLA Policies" {
    Get-Module PSMyModule | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSMyModule" -Force -ErrorAction Stop

    InModuleScope PSMyModule {

        Connect-MyModule -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
        }
        Context "View and List" {
            It "Get-MyModuleSLAPolicy should return data" -Tag "SLA Policies" {
                $Script:SLAs = Get-MyModuleSLAPolicy
                $SLAs | Should -Not -BeNullOrEmpty
            }
        }
    }
}
