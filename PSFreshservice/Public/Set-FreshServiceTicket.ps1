<#
.SYNOPSIS
    Updates a Freshservice Ticket.

.DESCRIPTION
    Updates a Freshservice Ticket via REST API.

    https://api.freshservice.com/#update_ticket_priority

.PARAMETER id
    Unique id of the ticket.

.PARAMETER name
    Name of the requester

.PARAMETER requester_id
    User ID of the requester. For existing contacts, the requester_id can be passed instead of the requester's email.

.PARAMETER email
    Email address of the requester. If no contact exists with this email address in Freshservice, it will be added as a new contact.

.PARAMETER phone
    Phone number of the requester. If no contact exists with this phone number in Freshservice, it will be added as a new contact.
    If the phone number is set and the email address is not, then the name attribute is mandatory.

.PARAMETER subject
    Subject of the ticket. The default value is null.

.PARAMETER type
    Helps categorize the ticket according to the different kinds of issues your support team deals with. The default Value is
    incident. As of now, API v2 supports only type 'incident'

.PARAMETER status
    Status of the ticket.

    2 = Open
    3 = Pending
    4 = Resolved
    5 = Closed

.PARAMETER priority
    Priority of the ticket.

    4 = Urgent
    3 = High
    2 = Medium
    1 = Low

.PARAMETER description
    HTML content of the ticket.

.PARAMETER responder_id
    Unique id of the agent to whom the ticket has been assigned

.PARAMETER attachments
    Ticket attachments. The total size of these attachments cannot exceed 15MB.

.PARAMETER cc_emails
    Email address added in the 'cc' field of the incoming ticket email.

.PARAMETER custom_fields
    Key value pairs containing the names and values of custom fields. Read more here.

.PARAMETER due_by
    Timestamp that denotes when the ticket is due to be resolved.

.PARAMETER email_config_id
    ID of email config which is used for this ticket. (i.e., support@yourcompany.com/sales@yourcompany.com)

.PARAMETER fr_due_by
    Timestamp that denotes when the first response is due

.PARAMETER group_id
    Unique id of the group to which the ticket has been assigned. The default value is the ID of the group that is
    associated with the given email_config_id

.PARAMETER source
    The channel through which the ticket was created. The default value is 2.

    1  = Email
    2  = Portal
    3  = Phone
    4  = Chat
    5  = Feedback widget
    6  = Yammer
    7  = AWS Cloudwatch
    9  = Pagerduty
    10 = Walkup
    11 = Slack

.PARAMETER tags
    Tags that have been associated with the ticket

.PARAMETER department_id
    Department ID of the requester.

.PARAMETER category
    Ticket category.

.PARAMETER sub_category
    Ticket sub category.

.PARAMETER item_category
    Ticket item category.

.PARAMETER assets
    List of assets associated with the ticket.

.PARAMETER urgency
    Ticket urgency.

.PARAMETER impact
    Ticket impact.

.PARAMETER problem
    Problem that need to be associated with ticket (problem display id).

.PARAMETER change_initiating_ticket
    Change causing the ticket that needs to be associated with ticket (change display id).

.PARAMETER change_initiated_by_ticket
    Change needed for the ticket to be fixed that needs to be associated with ticket (change display id).

.PARAMETER restore
    Restore a deleted ticket using the provided id.

.EXAMPLE
    Set-FreshServiceTicket -id 7 -status 3 -attachments 'C:\Scripts\automation_icon.jpg'

    cc_emails        : {}
    fwd_emails       : {}
    reply_cc_emails  : {}
    spam             : False
    email_config_id  :
    fr_escalated     : True
    group_id         :
    priority         : 1
    requester_id     : 21000418005
    requested_for_id : 21000418005
    responder_id     :
    source           : 2
    status           : 3
    subject          : VPN no worky
    description      : <div>Getting an error that VPN version not supported.</div>
    description_text : Getting an error that VPN version not supported.
    category         : Hardware
    sub_category     :
    item_category    :
    custom_fields    : @{my_custom_dropdown=}
    id               : 7
    type             : Incident
    to_emails        :
    department_id    :
    is_escalated     : False
    tags             : {VPN, Version}
    due_by           : 12/30/2022 9:30:49 PM
    fr_due_by        : 12/23/2022 6:30:49 PM
    created_at       : 12/20/2022 9:30:48 PM
    updated_at       : 12/28/2022 3:56:40 PM
    attachments      : {@{id=21006244756; content_type=image/jpeg; size=14119; name=automation_icon.jpg; attachment_url=https://its-fine.attachments.freshservice.com/data/helpdesk/attachments/production/21006244756/original/automation_icon.jpg?response-content-type=image/jpeg&Expires=1672329400&Signature=PHZ3Hms9A
                    6L4gBGmyRAbaF1ghtfGgFwNSTAYXrQfa-FFI3ukYf7d3Y6ru0PcBNQACcqhGASsc~Q9F8M3JcljLfqZ839paJT7B0u7dC4LYi4ULz7~3zya48gs1JHvN5M-BlR1jd2Bx0g5EfLoGP~Y9WzulFe-QzbEK8iWmnJKPlsxUj4jEzVnbp7PaH-Uk~R8alIinCV0kTSP85YU1nc7plngg2Pjm27yQCzU7nQZWwFCVfXrtnQRKMe8UY4NrNpirpK71zwH4w6t5YvFA54wMVYBJjAMNv1KQLXunilbzVdb~
                    vy3pqAn81g4LhqjDgjvMIJLGTszwrUbL9PFmkGGYQ__&Key-Pair-Id=APKAIPHBXWY2KT5RCMPQ; created_at=12/28/2022 3:56:39 PM; updated_at=12/28/2022 3:56:39 PM}}

    Updates a Freshservice ticket 7 with a status of 3 (Pending) and attaches a jpg image.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceTicket {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Ticket Id of the Ticket',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Ticket Id of the Ticket',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Restore',
            Position = 0
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the ticket',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the ticket. For existing contacts, the ticket_id can be passed instead of the tickets email.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 2
        )]
        [Alias('RequesterId')]
        [long]$requester_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email address of the ticket. If no contact exists with this email address in Freshservice, it will be added as a new contact.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [string]$email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Phone number of the ticket. If no contact exists with this phone number in Freshservice, it will be added as a new contact. If the phone number is set and the email address is not, then the name attribute is mandatory.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [string]$phone,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Subject of the ticket. The default value is null.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [string]$subject,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Helps categorize the ticket according to the different kinds of issues your support team deals with. The default Value is incident.  As of now, API v2 supports only type "incident"',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [string]$type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the ticket.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7
        )]
        [ValidateRange(2,5)]
        [int]$status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Priority of the ticket.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [ValidateRange(1,4)]
        [int]$priority,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'HTML content of the ticket.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 9
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the agent to whom the ticket has been assigned',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 10
        )]
        [long]$responder_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket attachments. The total size of these attachments cannot exceed 15MB.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 11
        )]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw ("Cannot find path {0} because it does not exist." -f $_.FullName)
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw ("{0} is not a valid file. Folder paths are not allowed." -f $_.FullName)
            }
            if($_.Length/1MB -gt 15 ) {
                throw ("{0} exceeds the file size limit. Files must be under 15MB." -f $_.FullName)
            }
            return $true
        })]
        [System.IO.FileInfo[]]$attachments,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields. Read more here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 12
        )]
        [object[]]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp that denotes when the ticket is due to be resolved.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 13
        )]
        [datetime]$due_by,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of email config which is used for this ticket. (i.e., support@yourcompany.com/sales@yourcompany.com)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 14
        )]
        [long]$email_config_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp that denotes when the first response is due',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 15
        )]
        [datetime]$fr_due_by,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the group to which the ticket has been assigned. The default value is the ID of the group that is associated with the given email_config_id',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 16
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The channel through which the ticket was created. The default value is 2.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 17
        )]
        [ValidateRange(1,10)]
        [string]$source,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Tags that have been associated with the ticket',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 18
        )]
        [string[]]$tags,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of assets associated with the ticket',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 19
        )]
        [object[]]$assets,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket urgency',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 20
        )]
        [int]$urgency,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket impact',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 21
        )]
        [int]$impact,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket category',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 22
        )]
        [string]$category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket sub category',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 23
        )]
        [string]$sub_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket item category',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 24
        )]
        [string]$item_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Department ID of the ticket.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 25
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Problem that need to be associated with ticket (problem display id)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 26
        )]
        [object[]]$problem,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Change causing the ticket that needs to be associated with ticket (change display id)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 27
        )]
        [object[]]$change_initiating_ticket,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Change needed for the ticket to be fixed that needs to be associated with ticket (change display id)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 28
        )]
        [object[]]$change_initiated_by_ticket

    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/tickets' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            #if ($PSBoundParameters[$PSItem] -is [boolean]) {
            #    $jsonBody[$PSItem.ToLower()] = [int]$PSBoundParameters[$PSItem]
            #}
            #else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            #}
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
                    ErrorAction = 'Stop'
                }

                if ( $attachments ) {
                    if ( $PSVersionTable.PSVersion.Major -lt 7 ) {
                        Write-Warning "Sorry! Attachments are not currently supported in versions earlier than Powershell 7.x due to multipart/form-data requirements. Attachment parameter will be ignored."
                        $jsonBody.Remove('attachments')
                        $params.Body = $jsonBody | ConvertTo-Json
                    }
                    else {
                        #Invoke-WebRequest -Form is supported in 7+
                        $jsonBody.Add('attachments[]',$attachments)
                        $jsonBody.Remove('attachments')
                        $params.Form = $jsonBody
                    }
                }
                else {
                    $params.Body = $jsonBody | ConvertTo-Json
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

            }
        }
        catch {
            Throw $_
        }
    }
    end {}
}
