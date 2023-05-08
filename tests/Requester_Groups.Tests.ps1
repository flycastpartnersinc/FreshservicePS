
Describe "Requester Groups" {
    InModuleScope PSFreshservice {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:requester_group_test_guid = New-Guid

            $Script:requester_id = Get-FreshServiceRequester |
                                        Where-Object -FilterScript {$_.active -eq $true} |
                                            Select-Object -First 1 -ExpandProperty id

            $newFreshServiceRequesterGroupSplat = @{
                name        = ("Pester Test {0}" -f $requester_group_test_guid)
                description = ("Pester Test: {0}" -f $requester_group_test_guid)
            }

            $Script:newFSRequesterGroup = New-FreshServiceRequesterGroup @newFreshServiceRequesterGroupSplat

        }

        Context "Create" {
            It "New-FreshServiceRequesterGroup should create a New FreshService Requester Group." -Tag "Requester Group" {
               $newFSRequesterGroup | Should -Not -BeNullOrEmpty
            }

                    $properties = ('id',
                                   'name',
                                   'description',
                                   'type')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Requester Group" {
                $newFSRequesterGroup.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceRequesterGroup should return data" -Tag "Requester Group" {
                $reqGroups = Get-FreshServiceRequesterGroup
                $reqGroups | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceRequesterGroup -id should return the test Requester Group" -Tag "Requester Group" {
                $testReqGroups= Get-FreshServiceRequesterGroup -id $newFSRequesterGroup.ID
                $testReqGroups.description | Should -BeLike "*$requester_group_test_guid"
            }
            It "Get-FreshServiceRequesterGroup -id should throw on bad id" -Tag "Requester Group" {
                {Get-FreshServiceRequesterGroup -id $requester_group_test_guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceRequesterGroup should change the -description of Requester Group to Test" -Tag "Requester Group" {
                Set-FreshServiceRequesterGroup -id $newFSRequesterGroup.Id -description "Test" |
                    Should -Not -BeNullOrEmpty
            }
        }

        Context "Add Member" {
            It "Add-FreshServiceRequesterGroupMember should add requester to group" -Tag "Requester Group" {
                Add-FreshServiceRequesterGroupMember -id $newFSRequesterGroup.Id -requester_id $requester_id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        Context "List Group Members" {
            It "Get-FreshServiceRequesterGroupMember should list Requester Group members" -Tag "Requester Group" {
                $reqGroupMembers = Get-FreshServiceRequesterGroupMember -requester_group_id $newFSRequesterGroup.id
                $reqGroupMembers | Should -Not -BeNullOrEmpty
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceRequesterGroupMember should remove the group member" -Tag "Requester Group" {
                Remove-FreshServiceRequesterGroupMember -id $newFSRequesterGroup.Id -requester_id $requester_id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Remove-FreshServiceRequesterGroup should delete the group" -Tag "Requester Group" {
                Remove-FreshServiceRequesterGroup -id $newFSRequesterGroup.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
