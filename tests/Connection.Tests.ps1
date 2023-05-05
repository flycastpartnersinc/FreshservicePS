
Describe "Connection" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
            $Script:testerEmail = "rob.simmers@flycastpartners.com"


            $newFreshServiceConnectionSplat = @{
                Name         = 'my_connection_{0}' -f $guid
                ApiKey       = $guid
                Tenant       = 'my-fstenant'
                EmailAddress = $testerEmail
                Environment  = 'Production'
                Default      = $false
            }

            $Script:newFSConnection = New-FreshServiceConnection @newFreshServiceConnectionSplat
        }

        Context "New"  -Tag "Connection" {
            It "New-FreshServiceConnection should create a New FreshService Connection." {
               $newFSConnection | Should -Not -BeNullOrEmpty
            }

            $properties = ('Name','ApiKey','Tenant','BaseUri','EmailAddress','Environment','Default')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Connection" {
                $newFSConnection.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "Get" {
            It "Get-FreshServiceConnection should return data" -Tag "Connection" {
                $connections = Get-FreshServiceConnection
                $connections | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceConnection -Name should return the test connection" -Tag "Connection" {
                $connection = Get-FreshServiceConnection -name $newFSConnection.Name
                $connection.Name | Should -BeLike "*$guid"
            }
            It "Get-FreshServiceConnection -Name should throw on bad name" -Tag "Connection" {
                {Get-FreshServiceConnection -Name 'foo'} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceConnection should update the ApiKey of Connection to 'NewAPIKey'" -Tag "Connection" {
                Set-FreshServiceConnection -Name $newFSConnection.Name -ApiKey 'NewAPIKey' |
                    Select-Object -ExpandProperty ApiKey |
                        Should -Not -BeNullOrEmpty
            }
        }

        Context "Remove" {
            It "Remove-FreshServiceConnection should delete the Connection" -Tag "Connection" {
                {Remove-FreshServiceConnection -Name $newFSConnection.Name} |
                        Should -Not -Throw
            }
        }
    }
}
