<#
.SYNOPSIS
    Returns a Freshservice Service Request Approval.

.DESCRIPTION
    Returns a Freshservice Service Request Approval via REST API.

    https://api.freshservice.com/#view_all_ticket_approvals
    https://api.freshservice.com/#view_a_ticket_approval

.PARAMETER display_id
    Unique id of the Service Request.

.PARAMETER id
    Unique id of the Service Request Approval.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceRequestApproval -display_id 221

    id              : 21000143868
    created_at      : 4/24/2023 7:29:38 PM
    updated_at      : 4/24/2023 7:29:38 PM
    approver_id     : 21001931878
    approver_name   : Rob Simmers
    approval_type   : 2
    user_id         : 21000418005
    level           : 1
    user_name       : Rob Simmers
    approval_status : @{id=0; name=requested}
    delegatee       :
    latest_remark   :

    List all Freshservice Request Approvals.

.EXAMPLE
    Get-FreshServiceRequestApproval -display_id 221 -id 21000143868

    id              : 21000143868
    created_at      : 4/24/2023 7:29:38 PM
    updated_at      : 4/24/2023 7:29:38 PM
    approver_id     : 21001931878
    approver_name   : Rob Simmers
    approval_type   : 2
    user_id         : 21000418005
    level           : 1
    user_name       : Rob Simmers
    approval_status : @{id=0; name=requested}
    delegatee       :
    email_content   : <p>Hi Rob Simmers, <br>
                        <br>A new Service Request has been submitted for your approval.<br>
                        <br>
                        <b>Request Summary</b>
                        <br>
                        <br>
                        <b>Request for Rob Simmers : Windows Laptop (#SR-221)</b>
                        <br>
                        <br>
                        <b>Requester:</b> Rob Simmers<br>
                        <b>Priority:</b> Medium
                        <br>
                        <b>Status:</b> Open
                    </p>
                    <p>
                        <br>
                    </p>
                    <p>
                        <br>

                        <a href="mailto:helpdesk@its-fine.freshservice.com?subject=RE:%20Request%20for%20Approval%20-%20%5B#SR-221%5
                    D%20Request for Rob Simmers : Windows Laptop&amp;body=Approve%0A%0A%0A%5B%23SR-221%5D%3A504523%3Afs%202100014386
                    8%3A504523%3Afs%0A">Approve<br><br></a>
                        <a href="mailto:helpdesk@its-fine.freshservice.com?subject=RE:%20Request%20for%20Approval%20-%20%5B#SR-221%5
                    D%20Request for Rob Simmers : Windows Laptop&amp;body=Reject%3Cbr%3EENTER%20COMMENT%20HERE">Reject</a>

                        <br>
                        <br>For Approval Link <a href="https://its-fine.freshservice.com/public/approvals/token?value=eyJ0eXAiOiJKV1
                    QiLCJhbGciOiJIUzI1NiJ9.WzIxMDAwMTQzODY4LGZhbHNlLDE2ODIzNjQ1Nzhd.cNlySWJKtAquchuVhebolmXxF4Igdhu4GRWKk8SQcAM">
                            <b>click here</b>
                        </a>
                        <br>You can also approve/reject the request by replying to this email with only one of the following words
                    as the
                        first line of the mail -<span>
                            <strong> 'Approved, Approve, Rejected, Reject.'</strong>
                        </span>
                        <br>While replying to the email, please add additional remarks in the second line of the email(Remarks are
                    mandatory
                        while rejecting the request).<br>To see the complete request <a href="https://its-fine.freshservice.com/publ
                    ic/tickets/8a4a2a27e150207377a1db9073d32f5c7367183075830ef00b398e8156ab0736">
                            <b>click here</b>
                        </a>
                        <br>
                        <br>Regards,
                        <br>its-fine
                    </p>
    latest_remark   :

    Return a specific Freshservice Request Approval.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceRequestApproval {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Service Request.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Service Request.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$display_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Service Request Approval.',
            ParameterSetName = 'id',
            Position = 1
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 3
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/tickets/{1}/approvals' -f $PrivateData['FreshserviceBaseUri'], $display_id)
        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

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
