<#
.SYNOPSIS
    Creates a Freshservice Solution Category.

.DESCRIPTION
    Creates a Freshservice Solution Category via REST API.

    https://api.freshservice.com/#create_solution_category

.PARAMETER name
    Name of the Solution Category. The maximum number of characters allowed is 255.

.PARAMETER description
    Description of the Solution Category in plain text or HTML format.

.PARAMETER visible_in_portals
    List of Unique portal IDs where this category is visible. Allowed only if the account is configured with multiple portals.

.EXAMPLE
    New-FreshServiceSolutionCategory -name MyCategory

    id                 : 18000040165
    created_at         : 9/29/2022 1:29:35 PM
    updated_at         : 9/29/2022 1:29:35 PM
    name               : MyCategory
    description        :
    default_category   : False
    position           : 4
    translations       :
    visible_in_portals : {18000009042}

    Creates a new Freshservice Solution category.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceSolutionCategory {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (

        [Parameter(
            Mandatory = $true,
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

        $uri = [System.UriBuilder]('{0}/solutions/categories' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

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
                    Method      = 'POST'
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json -Depth 5

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
