<#
.SYNOPSIS
    Updates a Freshservice Announcement.

.DESCRIPTION
    Updates a Freshservice Announcement via REST API.

    https://api.freshservice.com/#edit_an_announcement

.PARAMETER id
    Unique id of the Announcement

.PARAMETER title
    Title of the Announcement

.PARAMETER body_html
    Body of the Announcement in HTML format

.PARAMETER visible_from
    Timestamp at which Announcement becomes active

.PARAMETER visible_till
    Timestamp until which Announcement is active

.PARAMETER visibility
    Who can see the announcement? Values - everyone, agents_only, grouped_visibility

.PARAMETER departments
    Array of Department IDs that can view this Announcement (visibility must be grouped_visibility)

.PARAMETER groups
    Array of Group IDs that can view this Announcement (visibility must be grouped_visibility)

.PARAMETER send_email
    True if the announcement needs to be sent via email as well. False, otherwise

.PARAMETER additional_emails
    Additional email addresses to which the announcement needs to be sent

.EXAMPLE
    Set-FreshServiceAnnouncement -id 21000034874 -body_html 'Updated Announcement Content'

    id                : 21000034874
    created_at        : 2/22/2023 7:54:58 PM
    updated_at        : 2/22/2023 7:54:58 PM
    title             : Test Announcement
    created_by        : 21000418005
    visible_from      : 2/22/2023 7:52:08 PM
    visible_till      :
    body              : Updated Announcement Content
    body_html         : Updated Announcement Content
    visibility        : everyone
    state             : active
    groups            :
    departments       :
    is_read           : True
    send_email        : False
    additional_emails : {}

    Update a description on a specific note on a problem.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceAnnouncement {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Announcement',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Title of the Announcement',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [string]$title,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Body of the Announcement in HTML format',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 2
        )]
        [string]$body_html,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp at which Announcement becomes active',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [datetime]$visible_from,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp until which Announcement is active',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [datetime]$visible_till,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Who can see the announcement? Values - everyone, agents_only, grouped_visibility',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [ValidateSet('everyone','agents_only','agents_and_groups')]
        [string]$visibility,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Array of Department IDs that can view this Announcement (visibility must be grouped_visibility)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [long[]]$departments,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Array of Group IDs that can view this Announcement (visibility must be grouped_visibility)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7
        )]
        [long[]]$groups,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'True if the announcement needs to be sent via email as well. False, otherwise',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [boolean]$send_email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional email addresses to which the announcement needs to be sent',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 9
        )]
        [string[]]$additional_emails

    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/announcements' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
                if ($PSCmdlet.ShouldProcess($id)) {
                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
                    Body        = $jsonBody | ConvertTo-Json
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

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
