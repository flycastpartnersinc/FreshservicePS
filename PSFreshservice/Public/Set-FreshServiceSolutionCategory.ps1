<#
.SYNOPSIS
    Updates a Freshservice Solution Category.

.DESCRIPTION
    Updates a Freshservice Solution Category via REST API.

    https://api.freshservice.com/#update_solution_category

.PARAMETER id
    Unique id of the Solution Category.

.PARAMETER name
    Name of the solution category. The maximum number of characters allowed is 255.

.PARAMETER description
    Description of the solution category in plain text or HTML format.

.PARAMETER visible_in_portals
    List of Unique portal IDs where this category is visible. Allowed only if the account is configured with multiple portals.

.EXAMPLE
    Set-FreshServiceSolutionCategory -id 21000070438 -name 'Widget' -description 'Fixes for Widgets'

    id               : 21000070438
    created_at       : 2/14/2023 2:22:36 PM
    updated_at       : 3/31/2023 2:01:49 AM
    name             : Widget
    description      : Fixes for Widgets
    default_category : False
    position         : 5
    translations     :

    Updates the name and description of a Freshservice Solution Category.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceSolutionCategory {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique identifier of the solution category.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the solution category. The maximum number of characters allowed is 255.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the solution category in plain text.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of Unique portal IDs where this category is visible. Allowed only if the account is configured with multiple portals.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$visible_in_portals
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/solutions/categories' -f $PrivateData['FreshserviceBaseUri'])

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
