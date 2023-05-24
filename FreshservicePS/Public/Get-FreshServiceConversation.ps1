<#
.SYNOPSIS
    Returns a Freshservice Ticket conversation.

.DESCRIPTION
    Returns a Freshservice Ticket conversation via REST API.

    https://api.freshservice.com/#list_all_conversations

.PARAMETER Id
    Unique id of the ticket to get conversation.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceConversation -id 5

    id            : 21004158707
    user_id       : 21000418005
    to_emails     : {}
    body          : <div style="font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,sans-serif; font-size: 14px; "><div>Customer has been down for multiple days.</div></div>
    body_text     : Customer has been down for multiple days.
    ticket_id     : 5
    created_at    : 11/17/2022 8:18:40 PM
    updated_at    : 11/17/2022 8:18:40 PM
    incoming      : False
    private       : True
    support_email :
    source        : 2
    from_email    :
    cc_emails     : {}
    bcc_emails    :
    attachments   : {}

    id            : 21004158695
    user_id       : 21000418005
    to_emails     : {alex@example.com}
    body          : <div style="font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,sans-serif; font-size: 14px; ">
                    <div>Hi Alex,<br><br>Ticket: <a href="https://its-fine.freshservice.com/helpdesk/tickets/5" rel="noreferrer">https://its-fine.freshservice.com/helpdesk/tickets/5</a>
                    </div>
                    <div><br></div>
                    <div>Working on this</div>
                    </div>
    body_text     : Hi Alex,  Ticket: https://its-fine.freshservice.com/helpdesk/tickets/5     Working on this
    ticket_id     : 5
    created_at    : 11/17/2022 8:18:18 PM
    updated_at    : 11/17/2022 8:18:18 PM
    incoming      : False
    private       : False
    support_email : helpdesk@its-fine.freshservice.com
    source        : 0
    from_email    : "its-fine" <helpdesk@its-fine.freshservice.com>
    cc_emails     : {}
    bcc_emails    : {}
    attachments   : {}

    Get all FreshService ticket conversations by ticket id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceConversation {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id for Ticket to get conversations',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Alias('ticket_id')]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
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
        $uri = [System.UriBuilder]('{0}/tickets/{1}/conversations' -f $PrivateData['FreshserviceBaseUri'], $Id)
        $enablePagination = $true

    }
    process {

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
                    $objProperty = $content[0].PSObject.Properties.Name |
                                        Where-Object -FilterScript {$_ -like 'conversation*'}
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
