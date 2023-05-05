
Describe "Conversations" -Tag 'Conversations' {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
            $Script:testerEmail = "rob.simmers@flycastpartners.com"

            $agent_id = Get-FreshServiceAgent -Filter "email:'$testerEmail'" |
                            Select-Object -ExpandProperty id

            $ticketParams = @{
                email        = $testerEmail
                subject      = ("Pester Conversation test ticket {0}" -f $guid)
                description  = ("Pester Conversation test ticket {0}" -f $guid)
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

            $Script:newTktNote = New-FreshServiceConversation -Id $newFSTicket.Id -body "Adding conversation to ticket $guid" -private $true -As Note
            $Script:newTktReply = New-FreshServiceConversation -Id $newFSTicket.Id -body "Adding conversation to ticket $guid" -As Reply


        }

        Context 'New' {
            It 'New-FreshServiceTicket should create a ticket' {
               $newFSTicket | Should -Not -BeNullOrEmpty
            }
            It 'New-FreshServiceConversation -As Note should create a private note on Ticket' {
                $newTktNote | Should -Not -BeNullOrEmpty
             }
             It 'New-FreshServiceConversation -As Reply should create a ticket reply' {
                $newTktReply | Should -Not -BeNullOrEmpty
             }

        }

        Context 'Get' {
            It 'Get-FreshServiceConversation should get conversations' {
                Get-FreshServiceConversation -id $newFSTicket.Id |
                    Should -Not -BeNullOrEmpty
            }
        }

        Context 'Set' {
            It 'Set-FreshServiceConversation should update the note' {
                Set-FreshServiceConversation -id $newTktNote.Id -body "Updated body" |
                    Should -Not -BeNullOrEmpty
            }
            # Only public & private notes can be edited.
            # It 'Set-FreshServiceConversation should update the reply' {
            #     Set-FreshServiceConversation -id $newTktReply.Id -body "Updated body" -Verbose |
            #         Should -Not -BeNullOrEmpty
            #  }

        }

        Context 'Remove' {
            It 'Remove-FreshServiceConversation should delete the Note' {
                Remove-FreshServiceConversation -id $newTktNote.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It 'Remove-FreshServiceConversation should delete the Note' {
                Remove-FreshServiceConversation -id $newTktReply.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
            It 'Remove-FreshServiceTicket should delete the Note' {
                Remove-FreshServiceTicket -id $newFSTicket.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
