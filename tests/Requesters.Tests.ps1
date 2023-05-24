
Describe "Requesters" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:requester_test_guid = New-Guid
            $Script:requester_test_guid2 = New-Guid

            $Script:testerEmail = $env:FreshservicePS_Instance_Admin_Email

            $department_ids = Get-FreshServiceDepartment |
                                Select-Object -First 2 -ExpandProperty id

            $Script:job_title = 'Pester Test: {0}' -f $requester_test_guid

            $newFreshServiceRequesterSplat = @{
                external_id            = $requester_test_guid
                first_name             = 'Alex'
                last_name              = 'Smith'
                job_title              = $job_title
                primary_email          = 'requester.{0}@mailinator.com' -f (Get-Date).TimeOfDay.Ticks
                # secondary_emails       = 'rs1@hotmail.com', 'rs1@yahoo.com'
                work_phone_number      = '888-555-1234'
                mobile_phone_number    = '888-555-4321'
                can_see_all_tickets_from_associated_departments = $true
                address                = '123 Anywhere Lane'
                time_zone              = 'Eastern Time (US & Canada)'
                language               = 'en'
                background_information = "Technical Wizard Lvl 1000."
                department_ids         = $department_ids
            }

            $Script:newFSRequester = New-FreshServiceRequester @newFreshServiceRequesterSplat

            $department_ids = Get-FreshServiceDepartment |
                                Select-Object -Last 2 -ExpandProperty id

            $Script:job_title = 'Pester Test: {0}' -f $requester_test_guid2

            $secFreshServiceRequesterSplat = @{
                external_id            = $requester_test_guid2
                first_name             = 'Tom'
                last_name              = 'Johnson'
                job_title              = $job_title
                primary_email          = 'requester.{0}@mailinator.com' -f (Get-Date).TimeOfDay.Ticks
                # secondary_emails       = 'rs2@hotmail.com', 'rs2@yahoo.com'
                # work_phone_number      = '888-555-1111'
                # mobile_phone_number    = '888-555-2222'
                can_see_all_tickets_from_associated_departments = $true
                address                = '987 Nowhere Drive'
                time_zone              = 'Eastern Time (US & Canada)'
                language               = 'en'
                background_information = "Technical Wizard Lvl 1000."
                department_ids         = $department_ids
            }

            $Script:secFSRequester = New-FreshServiceRequester @secFreshServiceRequesterSplat

        }

        Context "New" {
            It "New-FreshServiceRequester should create a New FreshService requester." -Tag "Requester" {
                $newFSRequester | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceRequester should create a New FreshService secondary requester." -Tag "Requester" {
                $secFSRequester | Should -Not -BeNullOrEmpty
            }

            $properties = ('active',
                            'address',
                            'background_information',
                            'can_see_all_changes_from_associated_departments',
                            'can_see_all_tickets_from_associated_departments',
                            'external_id',
                            'first_name',
                            'has_logged_in',
                            'id',
                            'is_agent',
                            'job_title',
                            'language',
                            'last_name',
                            'primary_email',
                            'reporting_manager_id',
                            'vip_user',
                            'work_phone_number')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Requester" {
                $newFSRequester.PSObject.Properties.Name | Should -Contain $_
            }

        }

        Context "Get" {
            It "Get-FreshServiceRequester should return data" -Tag "Requester" {
                $requesters = Get-FreshServiceRequester
                $requesters | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceRequester -id should return the test requester" -Tag "Requester" {
                $testRequester = Get-FreshServiceRequester -id $newFSRequester.ID
                $testRequester.job_title | Should -BeLike "*$requester_test_guid"
            }
            It "Get-FreshServiceRequester -include_agents should return agents in query" -Tag "Requester", "IncludeAgents" {
                $reqAndAgent = Get-FreshServiceRequester -include_agents |
                    Where-Object -FilterScript {$_.is_agent -eq $true}
                $reqAndAgent | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceRequester -filter should return requesters" -Tag "Requester" {
                {Get-FreshServiceRequester -filter "job_title:'$job_title' AND language:'en'"} |
                    Should -Not -BeNullOrEmpty
            }
        }

        Context "Set" {
            It "Set-FreshServiceRequester should change the mobile phone number to 800-555-9999" -Tag "Requester" {
                Set-FreshServiceRequester -id $newFSRequester.Id -mobile_phone_number '800-555-9999' |
                    Select-Object -ExpandProperty mobile_phone_number |
                        Should -Be '800-555-9999'
            }
        }

        Context "Merge" {
            It "Set-FreshServiceRequester -merge should merge the requesters" -Tag "Requester" {
                $merge = Set-FreshServiceRequester -id $newFSRequester.Id -merge -secondary_requesters $secFSRequester.Id
                $merge.secondary_emails | Should -BeIn $secFSRequester.primary_email
            }
        }

        Context "Deactivate" {
            It "Remove-FreshServiceRequester should deactivate" -Tag "Requester" {
                Remove-FreshServiceRequester -id $newFSRequester.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        Context "Reactivate" {
            It "Set-FreshServiceRequester should reactivate requester" -Tag "Requester" {
                {Set-FreshServiceRequester -id $newFSRequester.Id -reactivate} |
                    Should -Not -Throw
            }
        }

        Context "Forget" {
            It "Remove-FreshServiceRequester should forget the requester" -Tag "Requester" {
                Remove-FreshServiceRequester -id $newFSRequester.Id -Forget |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }

        }
    }
}
