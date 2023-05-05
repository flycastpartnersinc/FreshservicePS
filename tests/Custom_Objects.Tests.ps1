
Describe "Custom Objects" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid

            $Script:testerEmail = "rob.simmers@flycastpartners.com"

            $Script:agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                                    Select-Object -ExpandProperty id

            $Script:agent_group_id = Get-FreshServiceAgentGroup |
                                        Where-Object -FilterScript {$_.name -eq 'Hardware Team'} |
                                            Select-Object -ExpandProperty id

            $Script:item_id = Get-FreshServiceCatalogItem |
                                    Where-Object -FilterScript {$_.name -eq 'Dell Monitor'} |
                                        Select-Object -ExpandProperty id
        }
        Context "View and List" {
            It "Get-FreshServiceCustomObject should return data" -Tag "Custom Objects" {
                $Script:customObjects = Get-FreshServiceCustomObject
                $customObjects | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCustomObject -id should return the test Custom Objects" -Tag "Custom Objects" {
                $customObject = Get-FreshServiceCustomObject -id $customObjects[0].id
                $customObject | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceCustomObject -id should throw on bad id" -Tag "Custom Objects" {
                {Get-FreshServiceCustomObject -id $guid} |
                    Should -Throw
            }
            It "Get-FreshServiceCustomObjectRecord -id should return the test Custom Objects" -Tag "Custom Objects" {
                $customObjectRecs = Get-FreshServiceCustomObjectRecord -custom_object_id $customObjects[0].id
                $customObjectRecs | Should -Not -BeNullOrEmpty
            }
        }

        Context "New"  -Tag "Change" {
            It "New-FreshServiceCustomObjectRecord should create a New FreshService Change." {
                $newFreshServiceCustomObjectRecordSplat = @{
                    custom_object_id = $customObjects[0].id
                    data = @{
                        agent_group        = $agent_group_id
                        approver           = $agent_id
                        category_dd1       = 'Hardware'
                        item_name          = $item_id
                        vendor_information = 'sales@dell.com'
                    }
                }

                $Script:newFSCustObjRec = New-FreshServiceCustomObjectRecord @newFreshServiceCustomObjectRecordSplat

                $newFSCustObjRec | Should -Not -BeNullOrEmpty
            }
        }

        Context "Set" {
            It "Set-FreshServiceCustomObjectRecord should update Contract description to 'Updated contract for MS Office'" -Tag "Contract" {

                $setFreshServiceCustomObjectRecordSplat = @{
                    custom_object_id = $customObjects[0].id
                    id = $newFSCustObjRec.bo_display_id
                    data = @{
                        category_dd1       = 'Software'
                        vendor_information = 'salesteam@dell.com'
                    }
                }

                Set-FreshServiceCustomObjectRecord @setFreshServiceCustomObjectRecordSplat |
                    Select-Object -ExpandProperty vendor_information |
                        Should -Be 'salesteam@dell.com'
            }
        }
    }
}
