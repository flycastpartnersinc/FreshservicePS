
Describe "Announcements" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:announcement_test_guid = New-Guid
            $Script:testerEmail = $env:FreshservicePS_Instance_Admin_Email

            $newFreshServiceAnnouncementSplat = @{
                title             = "SAP Outtage {0}" -f $announcement_test_guid
                body_html         = '<h1>SAP IS DOWN</h1><p>No ETA on service restoration</p>'
                visible_from      = (get-date)
                visibility        = 'Everyone'
                send_email        = $false
            }

            $Script:newFSAnnouncement = New-FreshServiceAnnouncement @newFreshServiceAnnouncementSplat

        }

        Context "Create" {
            It "New-FreshServiceAnnouncement should create a New FreshService Announcement." -Tag "Announcement" {
               $newFSAnnouncement | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                           'created_at',
                           'updated_at',
                           'title',
                           'created_by',
                           'visible_from',
                           'visible_till',
                           'body',
                           'body_html',
                           'visibility',
                           'state',
                           'groups',
                           'departments',
                           'is_read',
                           'send_email',
                           'additional_emails')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Announcement" {
                $newFSAnnouncement.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceAnnouncement should return data" -Tag "Announcement" {
                $Announcements = Get-FreshServiceAnnouncement
                $Announcements | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAnnouncement -id should return the test Announcement" -Tag "Announcement" {
                $Announcement= Get-FreshServiceAnnouncement -id $newFSAnnouncement.ID
                $Announcement.title | Should -BeLike "*$announcement_test_guid"
            }
            It "Get-FreshServiceAnnouncement -id should throw on bad id" -Tag "Announcement" {
                {Get-FreshServiceAnnouncement -id $announcement_test_guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceAnnouncement should change the -body_html of Announcement to 'SAP will restored by 10:30 EST'" -Tag "Announcement" {
                Set-FreshServiceAnnouncement -id $newFSAnnouncement.ID -body_html 'SAP will restored by 10:30 EST' -visible_till (Get-Date).AddHours(1) |
                    Select-Object -ExpandProperty body_html |
                        Should -Be "SAP will restored by 10:30 EST"
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceAnnouncement should delete the Announcement" -Tag "Announcement" {
                Remove-FreshServiceAnnouncement -id $newFSAnnouncement.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
