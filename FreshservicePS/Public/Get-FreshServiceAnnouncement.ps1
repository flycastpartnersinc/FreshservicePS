<#
.SYNOPSIS
    Returns a Freshservice Announcement.

.DESCRIPTION
    Returns a Freshservice Announcement via REST API.

    https://api.freshservice.com/#view_an_announcement

.PARAMETER Id
    Unique id of the Announcement.

.PARAMETER State
    State of Announcement (archived | active | scheduled | unread ).

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceAnnouncement

    id                : 21000035135
    created_at        : 3/25/2023 5:34:21 PM
    updated_at        : 3/25/2023 5:34:21 PM
    title             : SAP Outtage
    created_by        : 21000418005
    visible_from      : 3/25/2023 5:34:20 PM
    visible_till      :
    body              :  SAP IS DOWN  No ETA on service restoration
    body_html         : <h1>SAP IS DOWN</h1><p>No ETA on service restoration</p>
    visibility        : everyone
    state             : active
    groups            :
    departments       :
    is_read           : False
    send_email        : False
    additional_emails : {Alex@example.com}

    id                : 21000034874
    created_at        : 2/22/2023 7:54:58 PM
    updated_at        : 2/22/2023 7:54:58 PM
    title             : Test Announcement
    created_by        : 21000418005
    visible_from      : 2/22/2023 7:52:08 PM
    visible_till      :
    body              :  Test Announcement from Alex's FreshService Instance!
    body_html         : <p>Test Announcement from Alex's FreshService Instance!</p>
    visibility        : everyone
    state             : active
    groups            :
    departments       :
    is_read           : True
    send_email        : False
    additional_emails : {mymsteamsemail.mycompany.com@amer.teams.ms}

    id                : 21000011768
    created_at        : 8/29/2022 2:17:30 PM
    updated_at        : 8/29/2022 2:17:30 PM
    title             : Welcome to Freshservice
    created_by        : 21000418005
    visible_from      : 8/29/2022 2:17:30 PM
    visible_till      :
    body              :  Your Freshservice account has been activated and is now ready to use. During your free 21-day
                        trial period, your account will be on the highest trial plan - Enterprise (Trial) and you will
                        have access to all of the features and capabilities of Freshservice. Here are a few quick links
                        to help you set up your service desk:       1. Getting Started with Freshservice      2. Admin's
                        guide to managing a service desk      3. Agent's guide to simplifying tasks and automating
                        tickets      4. Go-live handbook      5. Network and engage with peers in the Freshservice
                        Community  You can also explore the Admin settings to get started with your service desk.  If
                        you have any questions or concerns, please contact us at support@freshservice.com and a
                        representative will get in touch with you.  Please note: This is a default announcement banner
                        and can be dismissed by clicking on the cancel icon.
    body_html         : <div>Your Freshservice account has been activated and is now ready to use. During your free
                        21-day trial period, your account will be on the <a
                        href="https://freshservice.com/pricing">highest trial plan - Enterprise (Trial)</a> and you will
                        have access to all of the features and capabilities of Freshservice. Here are a few quick links
                        to help you set up your service desk:<pre><br>     1.<a
                        href="https://support.freshservice.com/en/support/solutions/82979"> Getting Started with
                        Freshservice</a><br>     2.<a
                        href="https://support.freshservice.com/en/support/solutions#agentguidepage"> Admin's guide to
                        managing a service desk</a><br>     3.<a
                        href="https://support.freshservice.com/en/support/solutions#agentguidepage"> Agent's guide to
                        simplifying tasks and automating tickets</a><br>     4.<a
                        href="https://freshservice.com/resources/ebooks/itsm-cheat-sheet"> Go-live handbook</a><br>
                        5.<a href="https://community.freshworks.com/freshservice-11247"> Network and engage with peers
                        in the Freshservice Community</a></pre><br>You can also explore the Admin settings to get
                        started with your service desk.<br><br>If you have any questions or concerns, please contact us
                        at support@freshservice.com and a representative will get in touch with
                        you.<br><br><strong>Please note:</strong> This is a default announcement banner and can be
                        dismissed by clicking on the cancel icon.</div>
    visibility        : everyone
    state             : active
    groups            :
    departments       :
    is_read           : True
    send_email        : False
    additional_emails : {}

    Returns all Freshservice Announcements.

.EXAMPLE
    Get-FreshServiceAnnouncement -id 21000035135

    id                : 21000035135
    created_at        : 3/25/2023 5:34:21 PM
    updated_at        : 3/25/2023 5:34:21 PM
    title             : SAP Outtage
    created_by        : 21000418005
    visible_from      : 3/25/2023 5:34:20 PM
    visible_till      :
    body              :  SAP IS DOWN  No ETA on service restoration
    body_html         : <h1>SAP IS DOWN</h1><p>No ETA on service restoration</p>
    visibility        : everyone
    state             : active
    groups            :
    departments       :
    is_read           : True
    send_email        : False
    additional_emails : {Alex@example.com}

    Returns all Freshservice Announcement by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceAnnouncement {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Announcement.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the Announcement',
            ParameterSetName = 'ByName',
            Position = 0
        )]
        [ValidateSet('archived','active','scheduled','unread')]
        [string]$State,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'ByName',
            Position = 1
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'ByName',
            Position = 2
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/announcements' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true
    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

        if ($State) {
            $qry.Add('state', $State.ToLower() )
        }

        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()

            $uri = $uri.Uri.AbsoluteUri

            $results = do {

                $params = @{
                    Uri         = $uri
                    Method      = 'GET'
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json

                if ($content) {
                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
                }

                if ($result.Headers.Link) {
                    $uri = [regex]::Matches($result.Headers.Link,'<(?<Uri>.*)>')[0].Groups['Uri'].Value
                }

            }
            until (!$result.Headers.Link)

        }
        catch {
            Throw $_
        }

    }
    end {

        $results

    }
}
