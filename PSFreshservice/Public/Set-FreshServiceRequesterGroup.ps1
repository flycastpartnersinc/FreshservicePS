<#
.SYNOPSIS
    Updates a Freshservice Requester Group.

.DESCRIPTION
    Updates a Freshservice Requester Group via REST API.

    https://api.freshservice.com/#update_a_requester_group

.PARAMETER id
    Unique id of the group.

.PARAMETER name
    Name of the group.

.PARAMETER description
    Description of the group.

.PARAMETER type
    Type of the group.

.EXAMPLE
    Set-FreshServiceRequesterGroup -id 21000137988 -name 'Marketing Department' -description 'Marketing Department'

    id name                 description          type
    -- ----                 -----------          ----
    21000137988 Marketing Department Marketing Department manual

    Updates the name and description of the Freshservice Requester Group.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceRequesterGroup {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/requester_groups' -f $PrivateData['FreshserviceBaseUri'])

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
