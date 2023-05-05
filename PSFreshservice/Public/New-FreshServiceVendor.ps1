<#
.SYNOPSIS
    Creates a new Freshservice Vendor.

.DESCRIPTION
    Creates a new Freshservice Vendor via REST API.

    https://api.freshservice.com/#create_a_vendor

.PARAMETER name
    Name of the vendor.

.PARAMETER description
    Description of the vendor.

.PARAMETER primary_contact_id
    User ID of the primary contact (must be a user in Freshservice)

.PARAMETER address
    Key-value pair containing the names and values of the address fields with line1, city, state, country and zip code properties.

.PARAMETER custom_fields
    Key-value pair containing the names and values of the (custom) vendor fields.

.EXAMPLE
    $venParams = @{
        name = MyNewVendor
        description = "My vendor description"
        address = @{
            line1 = "123 Corporate Avenue"
            city = "Jacksonville"
            state = "Florida"
            country = "USA"
            zipcode = "32217"
        }
    }

    New-FreshServiceVendor @venParams

    Creates a new Freshservice Vendor.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceVendor {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the vendor. '
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the vendor.'
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the primary contact (must be a user in Freshservice)'
        )]
        [long]$primary_contact_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key-value pair containing the names and values of the address fields with line1, city, state, country and zip code properties'
        )]
        [hashtable]$address,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key-value pair containing the names and values of the (custom) vendor fields.'
        )]
        [hashtable]$custom_fields
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/vendors' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
            if ($PSCmdlet.ShouldProcess($name)) {

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
