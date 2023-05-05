<#
.SYNOPSIS
    Creates a Freshservice Ticket Conversation.

.DESCRIPTION
    Creates Freshservice Ticket Conversation via REST API.

    https://api.freshservice.com/#create_a_reply
    https://api.freshservice.com/#create_a_note

.PARAMETER Id
    Id for Ticket to create reply\note.

.PARAMETER body
    Content of the note in HTML format

.PARAMETER attachments
    Attachments. The total size of all the ticket's attachments (not just this note) cannot exceed 15MB.

.PARAMETER from_email
    The email address from which the reply is sent. By default the global support email will be used.

.PARAMETER user_id
    Unique id of the agent/user who is adding the note

.PARAMETER cc_emails
    Email address added in the 'cc' field of the outgoing ticket email.

.PARAMETER bcc_emails
    Email address added in the 'bcc' field of the outgoing ticket email.

.PARAMETER incoming
    Set to true if a particular note should appear as being created from the outside (i.e., not through the web portal). The default value is false

.PARAMETER notify_emails
    Email addresses of agents/users who need to be notified about this note

.PARAMETER private
    Set to true if the note is private. The default value is true.

.PARAMETER As
    Type of conversation.  Reply (Default) or Note.

.EXAMPLE
    New-FreshServiceConversation -Id 9 -As Reply -body 'A reply to a ticket'

    id          : 21005968159
    user_id     : 21000418005
    to_emails   : {rob.simmers@flycastpartners.com}
    body        : <div>A reply to a ticket</div>
    body_text   : A reply to a ticket
    ticket_id   : 9
    created_at  : 1/6/2023 8:20:13 PM
    updated_at  : 1/6/2023 8:20:13 PM
    from_email  : helpdesk@its-fine.freshservice.com
    cc_emails   : {}
    bcc_emails  : {}
    attachments : {}

    Creates a Freshservice ticket reply.

.EXAMPLE
    New-FreshServiceConversation -Id 9 -As Note -body 'A private note on a ticket' -private $true -incoming $true

    id            : 21005968234
    user_id       : 21000418005
    to_emails     : {}
    body          : <div>A private note on a ticket</div>
    body_text     : A private note on a ticket
    ticket_id     : 9
    created_at    : 1/6/2023 8:22:25 PM
    updated_at    : 1/6/2023 8:22:25 PM
    incoming      : True
    private       : True
    support_email :
    attachments   : {}

    Creates a Freshservice ticket note.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceConversation {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'Reply')]
    param (

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id for Ticket to create reply\note.',
            ValueFromPipelineByPropertyName = $true,
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Content of the note in HTML format',
            ValueFromPipelineByPropertyName = $true,
            Position = 1
        )]
        [string]$body,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket attachments. The total size of these attachments cannot exceed 15MB.',
            ValueFromPipelineByPropertyName = $true,
            Position = 2
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
            HelpMessage = 'The email address from which the reply is sent. By default the global support email will be used.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Reply',
            Position = 3
        )]
        [string]$from_email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the agent/user who is adding the note',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Reply',
            Position = 4
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the agent/user who is adding the note',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Note',
            Position = 3
        )]
        [long]$user_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email address added in the cc field of the outgoing ticket email.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Reply',
            Position = 5
        )]
        [string[]]$cc_emails,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email address added in the bcc field of the outgoing ticket email.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Reply',
            Position = 6
        )]
        [string[]]$bcc_emails,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set to true if a particular note should appear as being created from the outside (i.e., not through the web portal). The default value is false',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Note',
            Position = 4
        )]
        [boolean]$incoming,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email addresses of agents/users who need to be notified about this note',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Note',
            Position = 5
        )]
        [string[]]$notify_emails,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set to true if the note is private. The default value is true.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Note',
            Position = 6
        )]
        [boolean]$private,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Type of conversation. Reply or Note',
            ValueFromPipelineByPropertyName = $true,
            Position = 7
        )]
        [ValidateSet('Reply','Note')]
        [string]$As
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/tickets/{1}' -f $PrivateData['FreshserviceBaseUri'], $Id)

        if ($PSBoundParameters['As'] -eq 'Note') {
            $uri.Path = "{0}/{1}s" -f $uri.Path, $As.ToLower()
        }
        else {
            $uri.Path = "{0}/{1}" -f $uri.Path, $As.ToLower()
        }

        [void]$PSBoundParameters.Remove('id')
        [void]$PSBoundParameters.Remove('as')

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
            if ($PSCmdlet.ShouldProcess($id)) {

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
