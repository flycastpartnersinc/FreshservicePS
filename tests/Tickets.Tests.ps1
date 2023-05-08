
Describe "Tickets" {
    InModuleScope PSFreshservice {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:ticket_test_guid = New-Guid
            $Script:testerEmail = "rob.simmers@flycastpartners.com"

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $ticketParams = @{
                email        = $testerEmail
                subject      = ("Pester parent test ticket {0}" -f $ticket_test_guid)
                description  = "Test ticket from Powershell Module with GUID {0}" -f $ticket_test_guid
                priority     = 2
                status       = 2
                impact       = 2
                urgency      = 2
                tags         = "Pester"
                category     = "Software"
                source       = 9
                responder_id = $agent_id
                # workspace_id = 3
            }

            $Script:newFSTicket = New-FreshServiceTicket @ticketParams

            $childTktParams = @{
                email       = $testerEmail
                subject     = ("Pester child test ticket for parent ticket {0}" -f $ticket_test_guid)
                description = "Test child ticket from Powershell Module with GUID {0}" -f $ticket_test_guid
                priority    = 3
                status      = 3
                parent_id   = $newFSTicket.Id
                tags        = "Pester"
            }

            $Script:newFSChildTicket = New-FreshServiceTicket @childTktParams

            $timeParams = @{
                parent_id  = $newFSTicket.id
                time_spent = "01:00"
                billable   = $true
                note       = "Worked on stuff"
                agent_id   = $agent_id
                type       = "Ticket"
            }

            $Script:newFSTimeEntry = New-FreshServiceTimeEntry @timeParams

            $Script:newFSServiceRequest = New-FreshServiceRequest -display_id 2 -quantity 2 -email $testerEmail

            $Script:reqItem = Get-FreshServiceRequestedItem -id $newFSServiceRequest.id |
                                Select-Object -First 1

            $taskParams = @{
                parent_id   = $newFSTicket.id
                type        = 'Ticket'
                status      = 1
                due_date    = (Get-Date).AddDays(3)
                title       = ('Task for parent ticket {0}' -f $ticket_test_guid)
                description = ('Task for parent ticket {0}' -f $ticket_test_guid)
            }

            $Script:newFSTask = New-FreshServiceTask @taskParams
        }

        Context "New" {
            It "New-FreshServiceTicket should create a New FreshService ticket." -Tag "Ticket" {
               $newFSTicket | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                        'priority',
                        'status',
                        'source',
                        'type',
                        'is_escalated',
                        'description_text',
                        'custom_fields'
                        )

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Ticket" {
                $newFSTicket.PSObject.Properties.Name | Should -Contain $_
            }

            It "New-FreshServiceTicket -parent_id should create a child ticket" -Tag "ChildTicket"{
                $newFSChildTicket | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceTimeEntry should create a time entry" -Tag "TimeEntry" {
                $newFSTimeEntry | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceTask -type Ticket should create a task" -Tag "Task" {
                $newFSTask | Should -Not -BeNullOrEmpty
            }
        }

        Context "Get" {
            It "Get-FreshServiceTicket should return data" -Tag "Ticket" {
                $tickets = Get-FreshServiceTicket
                $tickets | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTicket -id should return the test ticket" -Tag "Ticket" {
                $testTicket = Get-FreshServiceTicket -id $newFSTicket.ID
                $testTicket.Subject | Should -BeLike "*$ticket_test_guid"
            }
            It "Get-FreshServiceTicket -activities should return ticket activity" -Tag "Ticket", "Activity" {
                {Get-FreshServiceTicket -id $newFSTicket.ID -activities} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTimeEntry should return time entries" -Tag "TimeEntry" {
                {Get-FreshServiceTimeEntry -type Ticket -parent_id $newFSTicket.ID} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTimeEntry -id should return time entry" -Tag "TimeEntry" {
                {Get-FreshServiceTimeEntry -type Ticket -parent_id $newFSTicket.ID -id $newFSTimeEntry.Id} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTicket -filter should return tickets" -Tag "Ticket" {
                {Get-FreshServiceTicket -filter "email:"$testerEmail" AND priority:>2"} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTicket -predefined_filter should return tickets" -Tag "Ticket" {
                {Get-FreshServiceTicket -predefined_filter new_and_my_open} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTicket -id should throw on bad id" -Tag "Ticket" {
                {Get-FreshServiceTicket -id $ticket_test_guid} |
                    Should -Throw
            }
            It "Get-FreshServiceTicket -fields should get Ticket fields" -Tag "Form" {
                {Get-FreshServiceTicket -fields} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceRequestedItem -id should get Service Request requested items" -Tag "RequestedItems" {
                $reqItem | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTask -type Ticket should get Ticket Task" -Tag "Task" {
                Get-FreshServiceTask -parent_id $newFSTicket.id -type Ticket | Should -Not -BeNullOrEmpty
            }
        }

        Context "Set" {
            It "Set-FreshServiceTimeEntry should change the note" -Tag "TimeEntry" {
                Set-FreshServiceTimeEntry -type Ticket -parent_id $newFSTicket.Id -id $newFSTimeEntry.Id -note "Updated Note"
                $timeEntry = Get-FreshServiceTimeEntry -type Ticket -parent_id $newFSTicket.ID -id $newFSTimeEntry.Id
                $timeEntry.note | Should -Be "Updated Note"
            }
            It "Set-FreshServiceRequestedItem should change the quantity to 1" -Tag "RequestedItem" {
                $updReqItem = Set-FreshServiceRequestedItem -service_request_id $newFSServiceRequest.id -id $reqItem.id -quantity 1
                $updReqItem.quantity | Should -Be 1
            }
            It "Set-FreshServiceTask -Type Ticket should change status to 3 (Completed)" -Tag "Task" {
                $updTask = Set-FreshServiceTask -parent_id $newFSTicket.id -id $newFSTask.id -type Ticket -status 3
                $updTask.status | Should -Be 3
            }
            It "Set-FreshServiceTicket should change the status of child ticket to 5 (Closed)" -Tag "ChildTicket" {
                Set-FreshServiceTicket -id $newFSChildTicket.Id -Status 5 |
                    Select-Object -ExpandProperty Status |
                        Should -Be 5
            }
            It "Set-FreshServiceTicket should change the status of ticket to 4 (Resolved)" -Tag "Ticket" {
                Set-FreshServiceTicket -id $newFSTicket.Id -Status 4 |
                    Select-Object -ExpandProperty Status |
                        Should -Be 4
            }

        }

        Context "Remove" {
            It "Remove-FreshServiceTicket should soft delete the parent ticket" -Tag "Ticket" {
                Remove-FreshServiceTicket -id $newFSTicket.Id
                $ticket = Get-FreshServiceTicket -id $newFSTicket.Id
                $ticket.deleted | Should -Be $true
            }
        }

        Context "Restore" {
            It "Set-FreshServiceTicket should restore deleted ticket" -Tag "Ticket" {
                Restore-FreshServiceTicket -id $newFSTicket.Id
                $ticket = Get-FreshServiceTicket -id $newFSTicket.Id
                $ticket.deleted | Should -Be $false
            }
        }

        Context "Remove" {
            It "Remove-FreshServiceTimeEntry should delete the time entry" -Tag "TimeEntry" {
                Remove-FreshServiceTimeEntry -type Ticket -parent_id $newFSTicket.Id -id $newFSTimeEntry.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceTask should delete the task" -Tag "Task" {
                Remove-FreshServiceTask -parent_id $newFSTicket.id -id $newFSTask.id -type Ticket |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceTicket should soft delete the child ticket" -Tag "ChildTicket" {
                Remove-FreshServiceTicket -id $newFSChildTicket.Id
                $ticket = Get-FreshServiceTicket -id $newFSChildTicket.Id
                $ticket.deleted | Should -Be $true
            }
            It "Remove-FreshServiceTicket should soft delete the parent ticket" -Tag "Ticket" {
                Remove-FreshServiceTicket -id $newFSTicket.Id
                $ticket = Get-FreshServiceTicket -id $newFSTicket.Id
                $ticket.deleted | Should -Be $true
            }
        }
    }
}
