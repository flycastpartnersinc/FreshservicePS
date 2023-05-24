<#
.SYNOPSIS
    Creates Freshservice Note on Problems, Changes and Releases

.DESCRIPTION
    Creates Freshservice Note via REST API for Problems, Changes and Releases.  For Ticket, see New-FreshServiceConversation.

    https://api.freshservice.com/#create_problem_note
    https://api.freshservice.com/#create_change_note
    https://api.freshservice.com/#create_release_note

.PARAMETER parent_id
    Unique id of the parent Problem, Change or Release.

.PARAMETER body
    The body of the note in HTML format.

.PARAMETER notify_emails
    Addresses to which the note must be notified to.

.PARAMETER type
    Parent object type to create note (e.g. Problem, Change, Release)'

.EXAMPLE
    New-FreshServiceNote -parent_id 2 -type Problem -body "A note added to a Problem."

    id            : 21000071797
    created_at    : 1/10/2023 7:52:26 PM
    updated_at    : 1/10/2023 7:52:26 PM
    body          : <div>A note added to a Problem.</div>
    body_text     : A note added to a Problem.
    user_id       : 21000418005
    notify_emails :

    Creates a Freshservice Note on a Problem.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceNote {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the parent Problem, Change or Release.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('ParentId')]
        [long]$parent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the time-entry',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('note')]
        [string]$body,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the time-entry',
            ValueFromPipelineByPropertyName = $true
        )]
        [string[]]$notify_emails,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Parent object type to create note (e.g. Problem, Change, Release)',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('Problem','Change','Release')]
        [string]$type
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/{1}s/{2}/notes' -f $PrivateData['FreshserviceBaseUri'], $Type.ToLower(),$parent_id)

        [void]$PSBoundParameters.Remove('type')
        [void]$PSBoundParameters.Remove('parent_id')

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
