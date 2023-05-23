Describe "Contract" {
    InModuleScope PSFreshservice {
        BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:contract_test_guid = New-Guid
            $Script:testerEmail = $env:PSFreshservice_Instance_Admin_Email

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $vendor_id = Get-FreshserviceVendor |
                                Where-Object -FilterScript {$_.Name -eq 'Microsoft'} |
                                    Select-Object -ExpandProperty id

            $agent_group = Get-FreshServiceAgentGroup |
                                Select-Object -First 1 -ExpandProperty id

            $software_id = Get-FreshServiceSoftware |
                                Where-Object -FilterScript {$_.name -eq 'Microsoft Office 365'} |
                                    Select-Object -ExpandProperty id

            $newFreshServiceContractItemSplat = @{
                item_name     = 'License'
                pricing_model = 'per_unit'
                cost          = 18.44
                count         = 350
                comments      = 'Per user licensing costs'
            }

            $icd = New-FreshServiceContractItem @newFreshServiceContractItemSplat

            $contractParams = @{
                name               = 'Microsoft O365 Contract {0}' -f $contract_test_guid
                description        = 'Microsoft Office 365 Contract {0}' -f $contract_test_guid
                vendor_id          = $vendor_id #Get-FreshServiceVendor
                auto_renew         = $true
                notify_expiry      = $true
                notify_before      = 30
                approver_id        = $agent_id #Get-FSRequester
                start_date         = Get-Date
                end_date           = (Get-Date).AddDays(365)
                cost               = 6454.00
                contract_number    = 'MSFT{0}' -f $contract_test_guid
                contract_type_id   = 3
                visible_to_id      = $agent_group #Get-FSAgentGroup
                notify_to          = 'john.smith@company.com'
                software_id        = $software_id #Get-FSSoftware
                billing_cycle      = 'annual'
                item_cost_details  = @($icd)
                # associated_asset_ids = @($asset_ids)
                # attachments        = 'C:\Scripts\Contract.txt'
            }

            $Script:newFSContract = New-FreshserviceContract @contractParams

        }

        Context "New"  -Tag "Contract" {
            It "New-FreshServiceContract should create a New FreshService Contract." {
               $newFSContract | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                           'name',
                           'description',
                           'vendor_id',
                           'auto_renew',
                           'notify_expiry',
                           'notify_before',
                           'approver_id',
                           'start_date',
                           'end_date',
                           'cost',
                           'status',
                           'contract_number',
                           'contract_type_id',
                           'visible_to_id',
                           'notify_to',
                           'custom_fields',
                           'software_id',
                           'license_type',
                           'billing_cycle',
                           'license_key',
                           'item_cost_details',
                           'future_contract_id',
                           'has_associated_assets',
                           'has_attachments',
                           'expiry_notified',
                           'requester_id',
                           'delegatee_id')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Contract" {
                $newFSContract.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "Get" {
            It "Get-FreshServiceContract should return data" -Tag "Contract" {
                $Contract = Get-FreshServiceContract
                $Contract | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceContract -id should return the test Contract" -Tag "Contract" {
                $Contract = Get-FreshServiceContract -id $newFSContract.ID
                $Contract.name | Should -BeLike "*$contract_test_guid"
            }
            It "Get-FreshServiceContract -id should throw on bad id" -Tag "Contract" {
                {Get-FreshServiceContract -id $contract_test_guid} |
                    Should -Throw
            }
            It "Get-FreshServiceContractType should return Contract types" -Tag "Contract Type" {
                $Script:contractTypes = Get-FreshServiceContractType
                $contractTypes | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceContractType -fields should return Contract types" -Tag "Contract Type" {
                $Script:contractFld = Get-FreshServiceContractType -id $contractTypes[0].id -fields
                $contractFld | Should -Not -BeNullOrEmpty
            }

        }

        Context "Set" {
            It "Set-FreshServiceContract should update Contract description to 'Updated contract for MS Office'" -Tag "Contract" {
                Set-FreshServiceContract -id $newFSContract.Id -description 'Updated contract for MS Office' |
                    Select-Object -ExpandProperty description |
                        Should -Be 'Updated contract for MS Office'
            }
            It "Set-FreshServiceContract -attachment should attach a text file to contract" -Tag "Attachment" {
                Set-FreshServiceContract -id $newFSContract.Id -attachments C:\Scripts\Contract.txt |
                    Select-Object -ExpandProperty Status |
                            Should -Not -BeNullOrEmpty
            }
            It "Set-FreshServiceContract -SubmitForApproval should submit Contract for approval" -Tag "Approval" {
                Set-FreshServiceContract -id $newFSContract.Id -SubmitForApproval |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It "Set-FreshServiceContract -Approve should Approve the Contract" -Tag "Approval" {
                Set-FreshServiceContract -id $newFSContract.Id -Approve |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }

        # Context "Remove" {
        #     It "Remove-FreshServiceContract should delete the Contract" -Tag "Contract" {
        #         Remove-FreshServiceContract -id $newFSContract.Id |
        #             Select-Object -ExpandProperty Status |
        #                 Should -BeLike 'success*'
        #     }
        # }

    }
}
