

Describe "Onboarding Requests" {
    InModuleScope PSFreshservice {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:onboarding_request_test_guid = New-Guid
            # $Script:testerEmail = 'rob.simmers@flycastpartners.com'

            $location_id = Get-FreshServiceLocation -Name 'America' |
                                Select-Object -ExpandProperty id

            $newFreshServiceOnboardingRequestSplat = @{
                fields = @{
                    cf_employee_name   = "Frank Johnson"
                    cf_job_title       = "Analyst I"
                    cf_date_of_joining = (Get-Date -Format 'yyyy-MM-dd')
                    cf_department      = 'IT' #$department_id
                    cf_location        = $location_id
                }
            }

            $Script:newFSOnboardRequest = New-FreshServiceOnboardingRequest @newFreshServiceOnboardingRequestSplat
        }

        Context "Create" {
            It "New-FreshServiceOnboardingRequest should create a New FreshService Location." -Tag "Onboarding Request" {
               $newFSOnboardRequest | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                            'status',
                            'requester_id',
                            'subject',
                            'ticket_id',
                            'actors',
                            'fields',
                            'lookup_values')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Onboarding Request" {
                $newFSOnboardRequest.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceOnboardingRequest should return data" -Tag "Onboarding Request" {
                $obReqs = Get-FreshServiceOnboardingRequest
                $obReqs | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceOnboardingRequest -id should return the test Onboarding Ticket" -Tag "Onboarding Request" {
                $obReq = Get-FreshServiceOnboardingRequest -id $newFSOnboardRequest.id
                $obReq | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceOnboardingRequest -id should throw on bad id" -Tag "Onboarding Request" {
                {Get-FreshServiceOnboardingRequest -id $onboarding_request_test_guid} |
                    Should -Throw
            }
            It "Get-FreshServiceOnboardingRequest -tickets should return associated ticket data" -Tag "Onboarding Request" {
                $obTixs = Get-FreshServiceOnboardingRequest -id $newFSOnboardRequest.ID -tickets
                $obTixs | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceOnboardingRequest -fields should return form data" -Tag "Onboarding Request" {
                $obForm = Get-FreshServiceOnboardingRequest -fields
                $obForm | Should -Not -BeNullOrEmpty
            }

        }
    }
}
