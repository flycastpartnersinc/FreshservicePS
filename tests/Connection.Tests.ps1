
Describe "Connection" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:connection_test_guid = New-Guid
            $Script:testerEmail = $env:FreshservicePS_Instance_Admin_Email

            $newFreshServiceConnectionSplat = @{
                Name         = 'my_connection_{0}' -f $connection_test_guid
                ApiKey       = $connection_test_guid
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
                $connection.Name | Should -BeLike "*$connection_test_guid"
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
