<#
.SYNOPSIS
    Update a Freshservice Asset Type.

.DESCRIPTION
    Update a Freshservice Asset Type via REST API.

    https://api.freshservice.com/#asset-types

.PARAMETER id
    Unique Id of the asset type.

.PARAMETER name
    Name of the asset type.

.PARAMETER description
    Description of the asset type.

.PARAMETER visible
    Visibility of the default asset type. Set to true if the asset type is visible. Custom asset types are set to true by default and cannot be modified.

.EXAMPLE
    Set-FreshServiceAssetType -id 21002835997 -description 'Updated Description'

    id                   : 21002835997
    name                 : Test
    parent_asset_type_id :
    visible              : True
    description          : Updated Description
    created_at           : 3/30/2023 3:22:28 AM
    updated_at           : 3/30/2023 3:23:18 AM

    Update a Freshservice Asset Type.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceAssetType {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the asset type.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the Product.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the asset type.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Visibility of the default asset type. Set to true if the asset type is visible. Custom asset types are set to true by default and cannot be modified.',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$visible
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/asset_types' -f $PrivateData['FreshserviceBaseUri'])

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
