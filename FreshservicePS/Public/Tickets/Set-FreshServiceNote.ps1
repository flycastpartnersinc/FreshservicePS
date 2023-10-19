<#
.SYNOPSIS
    Updates a Freshservice Note on a Problem, Change or Release.

.DESCRIPTION
    Updates a Freshservice Note on a Problem, Change or Release via REST API. For Note updates on Tickets, see Set-FreshServiceConversation.

    https://api.freshservice.com/#update_a_problem_note
    https://api.freshservice.com/#update_a_change_note
    https://api.freshservice.com/#update_a_release_note

.PARAMETER Id
    Unique id of the Note.

.PARAMETER parent_id
    Unique id of the parent Problem, Change or Release.

.PARAMETER body
    The body of the note in HTML format.

.PARAMETER notify_emails
    Addresses to which the note must be notified to.

.PARAMETER type
    Parent object type to create note (Problem, Change or Release).

.EXAMPLE
    Set-FreshServiceNote -parent_id 2 -type Problem -id 21000071797 -body "Updated note on a problem"

    id            : 21000071797
    created_at    : 1/10/2023 7:52:26 PM
    updated_at    : 1/10/2023 8:01:18 PM
    body          : Updated note on a problem
    body_text     : Updated note on a problem
    user_id       : 21000418005
    notify_emails :

    Update the body on a specific note on a problem.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceNote {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the note.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$id,
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

        $uri = [System.UriBuilder]('{0}/{1}s/{2}\notes/{3}' -f $PrivateData['FreshserviceBaseUri'], $type.ToLower(),$parent_id,$id)

        [void]$PSBoundParameters.Remove('type')
        [void]$PSBoundParameters.Remove('parent_id')
        [void]$PSBoundParameters.Remove('id')

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                if ($result.Content) {
                    $content = $result.Content |
                                    ConvertFrom-Json

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
