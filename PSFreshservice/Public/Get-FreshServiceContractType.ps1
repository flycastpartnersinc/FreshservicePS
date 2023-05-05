<#
.SYNOPSIS
    Returns a Freshservice Contract Type.

.DESCRIPTION
    Returns a Freshservice Contract Type via REST API.

    https://api.freshservice.com/#list_all_contract_types

.PARAMETER id
    Unique id of the FreshService Contract Type.

.PARAMETER fields
    This operation allows you to view all fields of a contract type.

.PARAMETER per_page
    Number of records to return per page during pagination. Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceContractType

    id             : 1
    name           : Lease
    description    :
    needs_approval : False
    is_default     : True
    created_at     : 8/29/2022 2:17:54 PM
    updated_at     : 8/29/2022 2:17:54 PM

    id             : 2
    name           : Maintenance
    description    :
    needs_approval : False
    is_default     : True
    created_at     : 8/29/2022 2:17:54 PM
    updated_at     : 8/29/2022 2:17:54 PM

    id             : 3
    name           : Software License
    description    :
    needs_approval : False
    is_default     : True
    created_at     : 8/29/2022 2:17:54 PM
    updated_at     : 8/29/2022 2:17:54 PM

    id             : 4
    name           : Warranty
    description    :
    needs_approval : False
    is_default     : True
    created_at     : 8/29/2022 2:17:54 PM
    updated_at     : 8/29/2022 2:17:54 PM

    Returns all Freshservice Contracts
.EXAMPLE
    Get-FreshServiceContractType -id 1

    id             : 1
    name           : Lease
    description    :
    needs_approval : False
    is_default     : True
    created_at     : 8/29/2022 2:17:54 PM
    updated_at     : 8/29/2022 2:17:54 PM

    Return a Freshservice Contract by Id.

.EXAMPLE
    Get-FreshserviceContractType -id 4 -fields

    label              : Contract Name
    name               : name
    required           : True
    field_type         : text
    data_type          : string
    visible_in_renewal : False
    default_field      : True
    created_at         : 8/29/2022 2:16:59 PM
    updated_at         : 8/29/2022 2:16:59 PM

    label              : Description
    name               : description
    required           : False
    field_type         : paragraph
    data_type          : string
    visible_in_renewal : False
    default_field      : True
    created_at         : 8/29/2022 2:16:59 PM
    updated_at         : 8/29/2022 2:16:59 PM

    label              : Contract Number
    name               : contract_number
    required           : True
    field_type         : text
    data_type          : string
    visible_in_renewal : False
    default_field      : True
    created_at         : 8/29/2022 2:16:59 PM
    updated_at         : 8/29/2022 2:16:59 PM

   ...

    Returns the fields for a specified contract type, by id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceContractType {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the contract',
            ParameterSetName = 'field',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'This operation allows you to view all fields of a contract type.',
            ParameterSetName = 'field',
            Position = 1
        )]
        [switch]$fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default'
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default'
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/contract_types' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

        if ($id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

        if ($fields) {
            $uri.Path = "{0}/fields" -f $uri.Path
        }

    }
    process {

        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()

            $uri = $uri.Uri.AbsoluteUri

            $results = do {

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
    end {

        $results

    }
}
