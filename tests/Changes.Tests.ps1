
Describe "Changes" {
    InModuleScope PSFreshservice {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:change_test_guid = New-Guid
            $Script:testerEmail = $env:PSFreshservice_Instance_Admin_Email

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $group_id = Get-FreshServiceAgentGroup |
                            Where-Object -FilterScript {$_.Name -eq 'Hardware Team'} |
                                Select-Object -ExpandProperty id

            $null = Add-FreshServiceAgentGroupMember -id $group_id -members $agent_id

            $assets = Get-FreshServiceAsset |
                            Select-Object -First 2 -Property display_id

            $newFreshServiceChangeSplat = @{
                requester_id       = $agent_id
                description        = "Test change from Pester: {0}" -f $change_test_guid
                subject            = "Test change from Pester: {0}" -f $change_test_guid
                priority           = 1
                status             = 1
                risk               = 1
                change_type        = 1
                impact             = 1
                planned_start_date = (Get-Date)
                planned_end_date   = (Get-Date).AddHours(2)
                category           = 'Hardware'
                sub_category       = 'Computer'
                assets             = $assets
                agent_id           = $agent_id
                group_id           = $group_id
                # workspace_id       = 3
            }

            $Script:newFSChange = New-FreshServiceChange @newFreshServiceChangeSplat

            $Script:newFSChgNote = New-FreshServiceNote -parent_id $newFSChange.id -type Change -body "Test note from Pester"

            $timeParams = @{
                parent_id  = $newFSChange.id
                time_spent = "01:00"
                billable   = $true
                note       = "Test time entry from Pester"
                agent_id   = $agent_id
                type       = "Change"
            }

            $Script:newFSChgTimeEntry = New-FreshServiceTimeEntry @timeParams

            $taskParams = @{
                parent_id   = $newFSChange.id
                type        = 'Change'
                status      = 1
                due_date    = (Get-Date).AddDays(3)
                title       = ('Task for parent Change {0}' -f $change_test_guid)
                description = ('Task for parent Change {0}' -f $change_test_guid)
            }

            $Script:newFSChgTask = New-FreshServiceTask @taskParams
        }

        Context "New"  -Tag "Change" {
            It "New-FreshServiceChange should create a New FreshService Change." {
               $newFSChange | Should -Not -BeNullOrEmpty
            }

            $properties = ('agent_id',
                            'group_id',
                            'priority',
                            'impact',
                            'status',
                            'risk',
                            'change_type',
                            'planned_start_date',
                            'planned_end_date',
                            'subject',
                            'change_window_id',
                            'maintenance_window',
                            'blackout_window')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Change" {
                $newFSChange.PSObject.Properties.Name | Should -Contain $_
            }
            It "New-FreshServiceNote should create a note" -Tag "Note" {
                $newFSChgNote | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceTimeEntry should create a time entry" -Tag "TimeEntry" {
                $newFSChgTimeEntry | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceTask -type Change should create a task" -Tag "Task" {
                $newFSChgTask | Should -Not -BeNullOrEmpty
            }
        }

        Context "Get" {
            It "Get-FreshServiceChange should return data" -Tag "Change" {
                $changes = Get-FreshServiceChange
                $changes | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceChange -id should return the test change" -Tag "Change" {
                $chgById = Get-FreshServiceChange -id $newFSChange.ID
                $chgById.Subject | Should -BeLike "*$change_test_guid"
            }
            It "Get-FreshServiceTimeEntry should return time entries" -Tag "TimeEntry" {
                {Get-FreshServiceTimeEntry -type Change -parent_id $newFSChange.ID} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTimeEntry -id should return time entry" -Tag "TimeEntry" {
                {Get-FreshServiceTimeEntry -type Change -parent_id $newFSChange.ID -id $newFSChgTimeEntry.Id} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceChange -include stats should return Changes" -Tag "Change" {
                {Get-FreshServiceChange -Id $newFSChange.id -include stats } |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceChange -predefined_filter should return Changes" -Tag "Change" {
                {Get-FreshServiceChange -predefined_filter requester_id} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceChange -id should throw on bad id" -Tag "Change" {
                {Get-FreshServiceChange -id $change_test_guid} |
                    Should -Throw
            }
            It "Get-FreshServiceChange -fields should get Change fields" -Tag "Form" {
                {Get-FreshServiceChange -fields} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTask -type Change should get Change Task" -Tag "Task" {
                Get-FreshServiceTask -parent_id $newFSChange.id -type Change | Should -Not -BeNullOrEmpty
            }
        }

        Context "Set" {
            It "Set-FreshServiceTimeEntry should change the Time Entry" -Tag "TimeEntry" {
                $timeEntry = Set-FreshServiceTimeEntry -type Change -parent_id $newFSChange.Id -id $newFSChgTimeEntry.Id -note "Updated Note"
                $timeEntry.note | Should -Be "Updated Note"
            }
            It "Set-FreshServiceNote should change the Note body" -Tag "Note" {
                Set-FreshServiceNote -parent_id $newFSChange.id -id $newFSChgNote.Id -type Change -body "Updated Body" |
                    Select-Object -ExpandProperty body |
                        Should -Be "Updated Body"
            }
            It "Set-FreshServiceTask -Type Change should change status to 3 (Completed)" -Tag "Task" {
                $updTask = Set-FreshServiceTask -parent_id $newFSChange.id -id $newFSChgTask.id -type Change -status 3
                $updTask.status | Should -Be 3
            }
            It "Set-FreshServiceChange should change the status of Change to 5 (Pending Review)" -Tag "Change" {
                Set-FreshServiceChange -id $newFSChange.Id -Status 2 |
                    Select-Object -ExpandProperty Status |
                        Should -Be 2
            }
        }

        Context "Remove" {
            It "Remove-FreshServiceChange should soft delete the Change" -Tag "Change" {
                Remove-FreshServiceChange -id $newFSChange.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        Context "Restore" {
            It "Set-FreshServiceChange should restore deleted Change" -Tag "Change" {
                Restore-FreshServiceChange -id $newFSChange.Id|
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        Context "Remove" {
            It "Remove-FreshServiceTimeEntry should delete the time entry" -Tag "TimeEntry" {
                Remove-FreshServiceTimeEntry -type Change -parent_id $newFSChange.Id -id $newFSChgTimeEntry.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceTask should delete the task" -Tag "Task" {
                Remove-FreshServiceTask -parent_id $newFSChange.id -id $newFSChgTask.id -type Change |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceChange should soft delete the Change" -Tag "Change" {
                Remove-FreshServiceChange -id $newFSChange.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
