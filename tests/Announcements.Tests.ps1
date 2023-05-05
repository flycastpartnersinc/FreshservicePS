
Describe "Announcements" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid
            $Script:testerEmail = 'rob.simmers@flycastpartners.com'

            $newFreshServiceAnnouncementSplat = @{
                title             = "SAP Outtage {0}" -f $guid
                body_html         = '<h1>SAP IS DOWN</h1><p>No ETA on service restoration</p>'
                visible_from      = (get-date)
                visibility        = 'Everyone'
                send_email        = $false
                additional_emails = 'rasimmers@gmail.com'
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
                $Announcement.title | Should -BeLike "*$guid"
            }
            It "Get-FreshServiceAnnouncement -id should throw on bad id" -Tag "Announcement" {
                {Get-FreshServiceAnnouncement -id $guid} |
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
