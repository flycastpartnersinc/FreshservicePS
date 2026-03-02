<#
.SYNOPSIS
    Creates a Freshservice Ticket.

.DESCRIPTION
    Creates a Freshservice Ticket via REST API.

    https://api.freshservice.com/#create_ticket

.PARAMETER name
    Name of the requester

.PARAMETER workspace_id
    Workspace ID of the ticket. The attribute is applicable only for accounts with the 'Workspaces' feature enabled. The default value is the ID of the primary workspace of the account.

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
    Status of the ticket. There can be custom fields, use Get-FSTIcket -Fields to get values from API, but these are the defaults:

    'Open'     = 2
    'Pending'  = 3
    'Resolved' = 4
    'Closed'   = 5

.PARAMETER priority
    Priority of the ticket.

    'Urgent' = 4
    'High'   = 3
    'Medium' = 2
    'Low'    = 1

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

    'Email'           = 1
    'Portal'          = 2
    'Phone'              = 3
    'Chat'              = 4
    'Feedback widget' = 5
    'Yammer'          = 6
    'AWS Cloudwatch'  = 7
    'Pagerduty'       = 8
    'Walkup'          = 9
    'Slack'              = 10

.PARAMETER tags
    Tags that have been associated with the ticket

.PARAMETER department_id
    Department ID of the requester.

.PARAMETER category
    Ticket category

.PARAMETER sub_category
    Ticket sub category

.PARAMETER item_category
    Ticket item category

.PARAMETER associate_ci
    Search for asset and associate with ticketTO BE DEPRECATED

.PARAMETER assets
    List of assets associated with the ticket

.PARAMETER urgency
    Ticket urgency

.PARAMETER impact
    Ticket impact

.PARAMETER problem
    Problem that need to be associated with ticket (problem display id)

.PARAMETER change_initiating_ticket
    Change causing the ticket that needs to be associated with ticket (change display id)

.PARAMETER change_initiated_by_ticket
    Change needed for the ticket to be fixed that needs to be associated with ticket (change display id)

.PARAMETER parent_id
    The parent id to create a child ticket.  Create child ticket under parent ticket X.

.EXAMPLE
    New-FreshServiceTicket -email "rob.smith@company.com" -subject "VPN no worky" -description "Getting an error that VPN version not supported." -priority 2 -status 2 -tags 'VPN',"Version"

    cc_emails        : {}
    fwd_emails       : {}
    reply_cc_emails  : {}
    fr_escalated     : False
    spam             : False
    email_config_id  :
    group_id         :
    priority         : 1
    requester_id     : 21000418005
    requested_for_id : 21000418005
    responder_id     :
    source           : 2
    status           : 2
    subject          : VPN no worky
    to_emails        :
    department_id    :
    id               : 8
    type             : Incident
    due_by           : 1/6/2023 8:29:51 PM
    fr_due_by        : 12/30/2022 5:29:51 PM
    is_escalated     : False
    description      : <div>Getting an error that VPN version not supported.</div>
    description_text : Getting an error that VPN version not supported.
    category         :
    sub_category     :
    item_category    :
    custom_fields    : @{my_custom_dropdown=}
    created_at       : 12/27/2022 8:29:51 PM
    updated_at       : 12/27/2022 8:29:51 PM
    tags             : {VPN, Version}
    attachments      : {}

    Creates a new ticket for requester rob.smith@company.com with a Priority of 2 and Status of 2 with tags VPN and Version.

.EXAMPLE
    New-FreshServiceTicket -email "rob.smith@company.com" -subject "Need help with HR forms" -description "What is a W4?" -priority 3 -status 3 -workspace_id 3

    cc_emails          : {}
    fwd_emails         : {}
    reply_cc_emails    : {}
    fr_escalated       : False
    spam               : False
    email_config_id    :
    group_id           :
    priority           : 3
    requester_id       : 22000068599
    requested_for_id   : 22000068599
    responder_id       :
    source             : 2
    status             : 3
    subject            : Need help with HR forms
    to_emails          :
    department_id      :
    id                 : 8
    type               : Case
    due_by             : 3/1/2023 2:53:48 PM
    fr_due_by          : 2/28/2023 3:53:48 PM
    is_escalated       : False
    description        : <div>What is a W4?</div>
    description_text   : What is a W4?
    category           :
    sub_category       :
    item_category      :
    custom_fields      :
    created_at         : 2/27/2023 8:53:48 PM
    updated_at         : 2/27/2023 8:53:48 PM
    tags               : {}
    attachments        : {}
    workspace_id       : 3
    planned_start_date :
    planned_end_date   :
    planned_effort     :

    Create ticket in a specific workspace.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceTicket {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the ticket',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Workspace ID of the ticket. The attribute is applicable only for accounts with the Workspaces feature enabled. The default value is the ID of the primary workspace of the account.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$workspace_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the ticket. For existing contacts, the ticket_id can be passed instead of the tickets email.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('RequesterId')]
        [long]$requester_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Email address of the ticket. If no contact exists with this email address in Freshservice, it will be added as a new contact.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Phone number of the ticket. If no contact exists with this phone number in Freshservice, it will be added as a new contact. If the phone number is set and the email address is not, then the name attribute is mandatory.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$phone,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Subject of the ticket. The default value is null.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$subject,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Helps categorize the ticket according to the different kinds of issues your support team deals with. The default Value is incident.  As of now, API v2 supports only type "incident"',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$type,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Status of the ticket.',
            ValueFromPipelineByPropertyName = $true
        )]
        # [ValidateRange(2,5)] # 9/25/2023 - Remarked out to support custom statuses - GitHub Issue #8
        [int]$status,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Priority of the ticket.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1, 4)]
        [int]$priority,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'HTML content of the ticket.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the agent to whom the ticket has been assigned',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$responder_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket attachments. The total size of these attachments cannot exceed 15MB.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateScript({
                if (-Not ($_ | Test-Path) ) {
                    throw ("Cannot find path {0} because it does not exist." -f $_.FullName)
                }
                if (-Not ($_ | Test-Path -PathType Leaf) ) {
                    throw ("{0} is not a valid file. Folder paths are not allowed." -f $_.FullName)
                }
                if ($_.Length / 1MB -gt 15 ) {
                    throw ("{0} exceeds the file size limit. Files must be under 15MB." -f $_.FullName)
                }
                return $true
            })]
        [System.IO.FileInfo[]]$attachments,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields. Read more here.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string[]]$cc_emails,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields. Read more here.',
            ValueFromPipelineByPropertyName = $true
        )]
        [object]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp that denotes when the ticket is due to be resolved.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$due_by,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of email config which is used for this ticket. (i.e., support@yourcompany.com/sales@yourcompany.com)',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$email_config_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp that denotes when the first response is due',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$fr_due_by,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the group to which the ticket has been assigned. The default value is the ID of the group that is associated with the given email_config_id',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The channel through which the ticket was created. The default value is 2.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$source,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Tags that have been associated with the ticket',
            ValueFromPipelineByPropertyName = $true
        )]
        [string[]]$tags,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of assets associated with the ticket',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$assets,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket urgency',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$urgency,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket impact',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$impact,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket category',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket sub category',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$sub_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket item category',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$item_category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Department ID of the ticket.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$department_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Problem that need to be associated with ticket (problem display id)',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$problem,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Change causing the ticket that needs to be associated with ticket (change display id)',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$change_initiating_ticket,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Change needed for the ticket to be fixed that needs to be associated with ticket (change display id)',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$change_initiated_by_ticket,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Create as child ticket of Parent Id',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('ParentId', 'AsChildOf')]
        [long]$parent_id
    )
    begin {

        $PrivateData = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/tickets' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        if ($PSBoundParameters.ContainsKey('parent_id')) {
            $uri.Path = "/{0}/{1}/create_child_ticket" -f $uri.Path, $parent_id
            [void]$PSBoundParameters.Remove('parent_id')
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
                    Method      = 'POST'
                    ErrorAction = 'Stop'
                }

                if ( $attachments ) {
                    if ( $PSVersionTable.PSVersion.Major -lt 7 ) {
                        Write-Warning "Sorry! Attachments are not currently supported in versions earlier than Powershell 7.x due to multipart/form-data requirements. Attachment parameter will be ignored."
                        $jsonBody.Remove('attachments')
                        $params.Body = $jsonBody | ConvertTo-Json
                    } else {
                        #Invoke-WebRequest -Form is supported in 7+
                        $jsonBody.Add('attachments[]', $attachments)
                        $jsonBody.Remove('attachments')
                        $params.Form = $jsonBody
                    }
                } else {
                    $params.Body = $jsonBody | ConvertTo-Json
                }

                $result = Invoke-FreshworksRestMethod @params

                if ($result.Content) {
                    $content = $result.Content | ConvertFrom-Json

                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
                }
            } else {
                $jsonBody | Out-String
            }
        } catch {
            Throw $_
        }

    }
    end {}
}
