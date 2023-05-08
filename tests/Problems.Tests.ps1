
Describe "Problems" {
    InModuleScope PSFreshservice {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:problem_test_guid = New-Guid
            $Script:testerEmail = "rob.simmers@flycastpartners.com"

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $assets = Get-FreshServiceAsset |
                            Select-Object -First 2 -Property display_id

            $newFreshServiceProblemSplat = @{
                requester_id    = $agent_id
                agent_id        = $agent_id
                description     = "Problem test from Pester: {0}" -f $problem_test_guid
                status          = 1
                impact          = 1
                priority        = 1
                subject         = "Problem test from Pester {0}" -f $problem_test_guid
                due_by          = (Get-Date).AddDays(5)
                known_error     = $true
                category        = "Hardware"
                sub_category    = 'Peripherals'
                item_category   = 'Router'
                problem_impact  = "This is the impact of this problem"
                problem_cause   = "The cause of the problem"
                problem_symptom = "The symptom of the problem"
                assets          = $assets
                # workspace_id    = 3
            }

            $Script:newFSProblem = New-FreshServiceProblem @newFreshServiceProblemSplat

            $newFreshServiceNoteSplat = @{
                parent_id = $newFSProblem.id
                type      = 'Problem'
                body      = "Test note from Pester {0}" -f $problem_test_guid
            }

            $Script:newFSPblmNote = New-FreshServiceNote @newFreshServiceNoteSplat

            $timeParams = @{
                parent_id  = $newFSProblem.id
                time_spent = "01:00"
                billable   = $true
                note       = "Test time entry from Pester {0}" -f $problem_test_guid
                agent_id   = $agent_id
                type       = "Problem"
            }

            $Script:newFSPblmTimeEntry = New-FreshServiceTimeEntry @timeParams

            $taskParams = @{
                parent_id   = $newFSProblem.id
                type        = 'Problem'
                status      = 1
                due_date    = (Get-Date).AddDays(3)
                title       = ('Task for parent Problem {0}' -f $problem_test_guid)
                description = ('Task for parent Problem {0}' -f $problem_test_guid)
            }

            $Script:newFSPblmTask = New-FreshServiceTask @taskParams
        }

        Context "New"  -Tag "Problem" {
            It "New-FreshServiceProblem should create a New FreshService Problem." {
               $newFSProblem | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                            'agent_id',
                            'description',
                            'description_text',
                            'assets',
                            'requester_id',
                            'subject',
                            'group_id',
                            'priority',
                            'impact',
                            'status',
                            'due_by',
                            'known_error',
                            'department_id',
                            'category',
                            'sub_category',
                            'item_category')
            It "Object schema Contains property <_>" -ForEach $properties -Tag "Problem" {
                $newFSProblem.PSObject.Properties.Name | Should -Contain $_
            }
            It "New-FreshServiceNote should create a note" -Tag "Note" {
                $newFSPblmNote | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceTimeEntry should create a time entry" -Tag "TimeEntry" {
                $newFSPblmTimeEntry | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceTask -type Problem should create a task" -Tag "Task" {
                $newFSPblmTask | Should -Not -BeNullOrEmpty
            }
        }

        Context "Get" {
            It "Get-FreshServiceProblem should return data" -Tag "Problem" {
                $Problems = Get-FreshServiceProblem
                $Problems | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceProblem -id should return the test Problem" -Tag "Problem" {
                $pblById = Get-FreshServiceProblem -id $newFSProblem.ID
                $pblById.Subject | Should -BeLike "*$problem_test_guid"
            }
            It "Get-FreshServiceTimeEntry should return time entries" -Tag "TimeEntry" {
                {Get-FreshServiceTimeEntry -type Problem -parent_id $newFSProblem.ID} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTimeEntry -id should return time entry" -Tag "TimeEntry" {
                {Get-FreshServiceTimeEntry -type Problem -parent_id $newFSProblem.ID -id $newFSPblmTimeEntry.Id} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceProblem -id should throw on bad id" -Tag "Problem" {
                {Get-FreshServiceProblem -id $problem_test_guid} |
                    Should -Throw
            }
            It "Get-FreshServiceOnboardingRequest -fields should get Problem fields" -Tag "Form" {
                {Get-FreshServiceProblem -fields} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTask -type Problem should get Problem Task" -Tag "Task" {
                Get-FreshServiceTask -parent_id $newFSProblem.id -type Problem | Should -Not -BeNullOrEmpty
            }
        }

        Context "Set" {
            It "Set-FreshServiceTimeEntry should Problem the Time Entry" -Tag "TimeEntry" {
                $timeEntry = Set-FreshServiceTimeEntry -type Problem -parent_id $newFSProblem.Id -id $newFSPblmTimeEntry.Id -note "Updated Note"
                $timeEntry.note | Should -Be "Updated Note"
            }
            It "Set-FreshServiceNote should Problem the Note body" -Tag "Note" {
                Set-FreshServiceNote -parent_id $newFSProblem.id -id $newFSPblmNote.Id -type Problem -body "Updated Body" |
                    Select-Object -ExpandProperty body |
                        Should -Be "Updated Body"
            }
            It "Set-FreshServiceTask -Type Problem should Problem status to 3 (Completed)" -Tag "Task" {
                $updTask = Set-FreshServiceTask -parent_id $newFSProblem.id -id $newFSPblmTask.id -type Problem -status 3
                $updTask.status | Should -Be 3
            }
            It "Set-FreshServiceProblem should Problem the status of Problem to 5 (Pending Review)" -Tag "Problem" {
                Set-FreshServiceProblem -id $newFSProblem.Id -Status 2 |
                    Select-Object -ExpandProperty Status |
                        Should -Be 2
            }
        }

        Context "Remove" {
            It "Remove-FreshServiceProblem should soft delete the Problem" -Tag "Problem" {
                Remove-FreshServiceProblem -id $newFSProblem.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        Context "Restore" {
            It "Set-FreshServiceProblem should restore deleted Problem" -Tag "Problem" {
                Restore-FreshServiceProblem -id $newFSProblem.Id|
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        Context "Remove" {
            It "Remove-FreshServiceTimeEntry should delete the time entry" -Tag "TimeEntry" {
                Remove-FreshServiceTimeEntry -type Problem -parent_id $newFSProblem.Id -id $newFSPblmTimeEntry.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceTask should delete the task" -Tag "Task" {
                Remove-FreshServiceTask -parent_id $newFSProblem.id -id $newFSPblmTask.id -type Problem |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceProblem should soft delete the Problem" -Tag "Problem" {
                Remove-FreshServiceProblem -id $newFSProblem.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
