<#
.SYNOPSIS
    Creates Freshservice Announcement.

.DESCRIPTION
    Creates Freshservice Announcement via REST API.

    https://api.freshservice.com/#create_an_announcement

.PARAMETER title
    Title of the Announcement.

.PARAMETER body_html
    Body of the Announcement in HTML format.

.PARAMETER visible_from
    Timestamp at which Announcement becomes active.

.PARAMETER visible_till
    Timestamp until which Announcement is active.

.PARAMETER visibility
    Who can see the announcement? Values - everyone, agents_only, grouped_visibility

.PARAMETER departments
    Array of Department IDs that can view this Announcement (visibility must be grouped_visibility).

.PARAMETER groups
    Array of Group IDs that can view this Announcement (visibility must be grouped_visibility).

.PARAMETER send_email
    True if the announcement needs to be sent via email as well. False, otherwise.

.PARAMETER additional_emails
    Additional email addresses to which the announcement needs to be sent.

.EXAMPLE
    New-FreshServiceAnnouncement -title "SAP Outtage" -body_html '<h1>SAP IS DOWN</h1><p>No ETA on service restoration</p>' -visible_from (get-date) -visibility Everyone

    id                : 21000035148
    created_at        : 3/27/2023 5:25:29 PM
    updated_at        : 3/27/2023 5:25:29 PM
    title             : SAP Outtage
    created_by        : 21000418005
    visible_from      : 3/27/2023 5:25:29 PM
    visible_till      :
    body              :  SAP IS DOWN  No ETA on service restoration
    body_html         : <h1>SAP IS DOWN</h1><p>No ETA on service restoration</p>
    visibility        : everyone
    state             : active
    groups            :
    departments       :
    is_read           : True
    send_email        : False
    additional_emails : {}

    Creates a Freshservice Announcement.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceAnnouncement {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Title of the Announcement',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [string]$title,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Body of the Announcement in HTML format',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [string]$body_html,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Timestamp at which Announcement becomes active',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 2
        )]
        [datetime]$visible_from,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Timestamp until which Announcement is active',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [datetime]$visible_till,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Who can see the announcement? Values - everyone, agents_only, grouped_visibility',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [ValidateSet('everyone','agents_only','agents_and_groups')]
        [string]$visibility,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Array of Department IDs that can view this Announcement (visibility must be grouped_visibility)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [long[]]$departments,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Array of Group IDs that can view this Announcement (visibility must be grouped_visibility)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [long[]]$groups,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'True if the announcement needs to be sent via email as well. False, otherwise',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7
        )]
        [boolean]$send_email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional email addresses to which the announcement needs to be sent',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [string[]]$additional_emails
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/announcements' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ('visibility' -contains $PSItem) {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem].ToLower()
            }
            else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
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
