<#
.SYNOPSIS
    Returns a Freshservice Vendor.

.DESCRIPTION
    Returns a Freshservice Vendor via REST API.

    https://api.freshservice.com/#view_a_vendor

.PARAMETER Id
    Unique id of the Vendor.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceVendor

    address            : @{line1=1 Infinite Loop; city=Cupertino; state=California; country=United States; zipcode=95014}
    id                 : 21000085371
    name               : Apple
    description        :
    contact_name       :
    email              :
    mobile             :
    phone              :
    primary_contact_id :
    custom_fields      :
    created_at         : 8/29/2022 2:17:31 PM
    updated_at         : 8/29/2022 2:17:31 PM

    address            : @{line1=1 Dell Way; city=Round Rock; state=Texas; country=United States; zipcode=78664}
    id                 : 21000085372
    name               : Dell
    description        :
    contact_name       :
    email              :
    mobile             :
    phone              :
    primary_contact_id :
    custom_fields      :
    created_at         : 8/29/2022 2:17:31 PM
    updated_at         : 8/29/2022 2:17:31 PM

    address            : @{line1=2950 S Delaware St Suite 201; city=San Mateo; state=California; country=United States; zipcode=94401}
    id                 : 21000085374
    name               : Freshworks
    description        :
    contact_name       :
    email              :
    mobile             :
    phone              :
    primary_contact_id :
    custom_fields      :
    created_at         : 8/29/2022 2:17:31 PM
    updated_at         : 8/29/2022 2:17:31 PM

    Get all Freshservice Vendors.
.EXAMPLE
    Get-FreshServiceVendor -Id 21000085375

    address            : @{line1=; city=; state=; country=; zipcode=}
    id                 : 21000085375
    name               : Microsoft
    description        :
    contact_name       :
    email              :
    mobile             :
    phone              :
    primary_contact_id :
    custom_fields      :
    created_at         : 8/29/2022 2:17:31 PM
    updated_at         : 8/29/2022 2:17:31 PM

    Get FreshService Vendor by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceVendor {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of Vendor',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/vendors' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()

            $uri = $uri.Uri.AbsoluteUri

            do {

                $params = @{
                    Uri         = $uri
                    Method      = 'GET'
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

                if ($result.Headers.Link) {
                    $uri = [regex]::Matches($result.Headers.Link,'<(?<Uri>.*)>')[0].Groups['Uri'].Value
                }

            }
            until (!$result.Headers.Link)

        }
        catch {
            Throw $_
        }

    }
    end {}
}
