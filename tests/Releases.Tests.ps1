
Describe "Release" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
            $Script:testerEmail = "rob.simmers@flycastpartners.com"

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $assets = Get-FreshServiceAsset |
                            Select-Object -First 2 -Property display_id

            $group_id = Get-FreshServiceAgentGroup |
                            Where-Object -FilterScript {$_.Name -eq 'Hardware Team'} |
                                Select-Object -ExpandProperty id

            $addAgentToGroup = Add-FreshServiceAgentGroupMember -id $group_id -members $agent_id

            $newFreshServiceReleaseSplat = @{
                subject            = "Release from Pester: {0}" -f $guid
                description        = "Release from Pester: {0}" -f $guid
                priority           = 1
                status             = 1
                planned_start_date = Get-Date -hour 20 -Minute 0 -Second 0
                planned_end_date   = Get-Date -hour 22 -Minute 0 -Second 0
                release_type       = 2
                assets             = $assets
                category           = "Hardware"
                sub_category       = 'Peripherals'
                item_category      = 'Router'
                agent_id           = $agent_id
                group_id           = $group_id
                # build_plan         = 'Build Plan for Release'
                # test_plan          = 'Test Plan for Release'
            }

            $Script:newFSRelease = New-FreshServiceRelease @newFreshServiceReleaseSplat

            $Script:newFSRelNote = New-FreshServiceNote -parent_id $newFSRelease.id -type Release -body "Test note from Pester"

            $timeParams = @{
                parent_id  = $newFSRelease.id
                time_spent = "01:00"
                billable   = $true
                note       = "Worked on stuff"
                agent_id   = $agent_id
                type       = "Release"
            }

            $Script:newFSRelTimeEntry = New-FreshServiceTimeEntry @timeParams

            $taskParams = @{
                parent_id   = $newFSRelease.id
                type        = 'Release'
                status      = 1
                due_date    = (Get-Date).AddDays(3)
                title       = ('Task for parent release {0}' -f $guid)
                description = ('Task for parent release {0}' -f $guid)
            }

            $Script:newFSRelTask = New-FreshServiceTask @taskParams
        }

        Context "New" {
            It "New-FreshServiceRelease should create a New FreshService release." -Tag "Release" {
               $newFSRelease | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                            'planned_start_date',
                            'planned_end_date',
                            'status',
                            'priority',
                            'release_type',
                            'work_start_date',
                            'work_end_date',
                            'associated_change_ids',
                            'planning_fields')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Release" {
                $newFSRelease.PSObject.Properties.Name | Should -Contain $_
            }

            It "New-FreshServiceNote should create a time entry" -Tag "Note" {
                $newFSRelNote | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceTimeEntry should create a time entry" -Tag "TimeEntry" {
                $newFSRelTimeEntry | Should -Not -BeNullOrEmpty
            }
            It "New-FreshServiceTask -type Release should create a task" -Tag "Task" {
                $newFSRelTask | Should -Not -BeNullOrEmpty
            }
        }

        Context "Get" {
            It "Get-FreshServiceRelease should return data" -Tag "Release" {
                $release = Get-FreshServiceRelease
                $release | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceRelease -id should return the test release" -Tag "Release" {
                $testRelease = Get-FreshServiceRelease -id $newFSRelease.ID
                $testRelease.Subject | Should -BeLike "*$guid"
            }
              It "Get-FreshServiceTimeEntry should return time entries" -Tag "TimeEntry" {
                {Get-FreshServiceTimeEntry -type Release -parent_id $newFSRelease.ID} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTimeEntry -id should return time entry" -Tag "TimeEntry" {
                {Get-FreshServiceTimeEntry -type Release -parent_id $newFSRelease.ID -id $newFSRelTimeEntry.Id} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceRelease -predefined_filter should return release" -Tag "Release" {
                {Get-FreshServiceRelease -predefined_filter my_open} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceRelease -id should throw on bad id" -Tag "Release" {
                {Get-FreshServiceRelease -id $guid} |
                    Should -Throw
            }
            It "Get-FreshServiceRelease -fields should get Release fields" -Tag "Form" {
                {Get-FreshServiceRelease -fields} |
                    Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceTask -type Release should get Release Task" -Tag "Task" {
                Get-FreshServiceTask -parent_id $newFSRelease.id -type Release | Should -Not -BeNullOrEmpty
            }
        }

        Context "Set" {
            It "Set-FreshServiceTimeEntry should change the note" -Tag "TimeEntry" {
                $timeEntry = Set-FreshServiceTimeEntry -type Release -parent_id $newFSRelease.Id -id $newFSRelTimeEntry.Id -note "Updated Note"
                $timeEntry.note | Should -Be "Updated Note"
            }
            It "Set-FreshServiceTask -Type Release should change status to 3 (Completed)" -Tag "Task" {
                $updTask = Set-FreshServiceTask -parent_id $newFSRelease.id -id $newFSRelTask.id -type Release -status 3
                $updTask.status | Should -Be 3
            }
            It "Set-FreshServiceRelease should change the status of release to 3 (In Progress)" -Tag "Release" {
                Set-FreshServiceRelease -id $newFSRelease.Id -Status 3 |
                    Select-Object -ExpandProperty Status |
                        Should -Be 3
            }
        }

        Context "Remove" {
            It "Remove-FreshServiceRelease should soft delete the parent release" -Tag "Release" {
                Remove-FreshServiceRelease -id $newFSRelease.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'

            }
        }

        Context "Restore" {
            It "Set-FreshServiceRelease should restore deleted release" -Tag "Release" {
                Restore-FreshServiceRelease -id $newFSRelease.Id|
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        Context "Remove" {
            It "Remove-FreshServiceTimeEntry should delete the time entry" -Tag "TimeEntry" {
                Remove-FreshServiceTimeEntry -type Release -parent_id $newFSRelease.Id -id $newFSRelTimeEntry.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceTask should delete the task" -Tag "Task" {
                Remove-FreshServiceTask -parent_id $newFSRelease.id -id $newFSRelTask.id -type Release |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceRelease should soft delete the release" -Tag "Release" {
                Remove-FreshServiceRelease -id $newFSRelease.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
