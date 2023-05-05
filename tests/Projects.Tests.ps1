
Describe "Projects" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
            $Script:testerEmail = "rob.simmers@flycastpartners.com"

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $newFreshServiceProjectSplat = @{
                name               = 'Project {0}' -f $guid
                description        = 'Project {0}' -f $guid
                project_type       = 1 #Business
                key                = 'P{0}' -f (Get-Random -Minimum 100000 -Maximum 999999 -Count 1)
                priority_id        = 1 #Low
                manager_id         = $agent_id
                start_date         = (Get-Date).AddDays(3)
                end_date           = (Get-Date).AddDays(10)
                visibility         = 1 #Public
            }

            $Script:newFSProject = New-FreshServiceProject @newFreshServiceProjectSplat


            Start-Sleep -Seconds 5

            $Script:task_type_id = Get-FreshServiceProjectTask -project_id $newFSProject.id -task_types |
                                        Where-Object -FilterScript {$_.name -eq 'task'} |
                                            Select-Object -ExpandProperty id

            $Script:task_priority_id = Get-FreshServiceProjectTask -project_id $newFSProject.id -task_priorities |
                                         Where-Object -FilterScript {$_.name -eq 'Medium'} |
                                            Select-Object -ExpandProperty id

            $Script:task_statuses =  Get-FreshServiceProjectTask -project_id $newFSProject.id -task_statuses

            $newFreshServiceProjectTaskSplat = @{
                project_id         = $newFSProject.id
                title              = ('Test task {0}' -f $guid)
                description        = ('Test task {0}' -f $guid)
                type_id            = $task_type_id
                assignee_id        = $agent_id
                planned_start_date = (Get-Date)
                planned_end_date   = (Get-Date).AddDays(10)
                priority_id        = $task_priority_id
                status_id          = ($task_statuses | Where-Object -FilterScript {$_.name -eq 'Open'} | Select-Object -ExpandProperty id)
            }

            $Script:newFSProjectTask = New-FreshServiceProjectTask @newFreshServiceProjectTaskSplat
        }

        Context "New" {
            It "New-FreshServiceProject should create a New FreshService Project." -Tag "Project" {
               $newFSProject | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                           'name',
                           'key',
                           'description',
                           'status_id',
                           'priority_id',
                           'sprint_duration',
                           'project_type',
                           'start_date',
                           'end_date',
                           'archived',
                           'visibility',
                           'manager_id',
                           'created_at',
                           'updated_at',
                           'custom_fields')

            It "Project Object schema Contains property <_>" -ForEach $properties -Tag "Project" {
                $newFSProject.PSObject.Properties.Name | Should -Contain $_
            }

            It "New-FreshServiceProjectTask should create a New FreshService Project Task." -Tag "Project Task" {
                $newFSProjectTask | Should -Not -BeNullOrEmpty
             }

             $properties = ('id',
                            'title',
                            'project_id',
                            'description',
                            'status_id',
                            'priority_id',
                            'created_at',
                            'updated_at',
                            'display_key',
                            'planned_start_date',
                            'type_id',
                            'planned_end_date',
                            'reporter_id',
                            'assignee_id',
                            'planned_effort',
                            'planned_duration',
                            'custom_fields',
                            'version_id',
                            'parent_id',
                            'story_points',
                            'sprint_id')

             It "Project Task Object schema Contains property <_>" -ForEach $properties -Tag "Project Task" {
                 $newFSProjectTask.PSObject.Properties.Name | Should -Contain $_
             }
        }

        Context "Get" {
            It "Get-FreshServiceProject should return data" -Tag "Project" {
                $Projects = Get-FreshServiceProject
                $Projects | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceProject -id should return the test Project" -Tag "Project" {
                $testProject = Get-FreshServiceProject -id $newFSProject.ID
                $testProject.description | Should -BeLike "*$guid"
            }
            It "Get-FreshServiceProject -id should throw on bad id" -Tag "Project" {
                {Get-FreshServiceProject -id $guid} |
                    Should -Throw
            }

            It "Get-FreshServiceProjectTask should return data" -Tag "Project Task" {
                $ProjectTasks = Get-FreshServiceProjectTask -project_id $newFSProject.id
                $ProjectTasks | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceProject -id should return the test Project Task" -Tag "Project Task" {
                $testProject = Get-FreshServiceProjectTask -project_id $newFSProject.id -Id $newFSProjectTask.id
                $testProject.title | Should -BeLike "*$guid"
            }
            It "Get-FreshServiceProject -id should throw on bad id" -Tag "Project Task" {
                {Get-FreshServiceProjectTask -project_id $newFSProject.id -Id $guid} |
                    Should -Throw
            }

        }

        Context "Set" {
            It "Set-FreshServiceProject should change the status of Project to 2 (In Progress)" -Tag "Project" {
                Set-FreshServiceProject -id $newFSProject.Id -status_id 2  |
                    Select-Object -ExpandProperty status_id |
                        Should -Be 2
            }
            It "Set-FreshServiceProjectTask should change the status of Project Task to (In Progress)" -Tag "Project Task" {
                $status_id = ($task_statuses | Where-Object -FilterScript {$_.name -eq 'In Progress'} | Select-Object -ExpandProperty id)

                Set-FreshServiceProjectTask -project_id $newFSProject.id -Id $newFSProjectTask.id -status_id $status_id  |
                    Select-Object -ExpandProperty status_id |
                        Should -Be $status_id
            }
        }

        Context "Remove" {
            It "Remove-FreshServiceTask should delete the task" -Tag "Project Task" {
                Remove-FreshServiceProjectTask -project_id $newFSProject.id -Id $newFSProjectTask.id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceProject should soft delete the Project" -Tag "Project" {
                Remove-FreshServiceProject -id $newFSProject.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
