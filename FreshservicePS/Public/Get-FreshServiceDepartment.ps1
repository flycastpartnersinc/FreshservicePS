<#
.SYNOPSIS
    Returns a Freshservice Department.

.DESCRIPTION
    Returns a Freshservice Department via REST API.

    https://api.freshservice.com/#view_a_department

.PARAMETER Id
    Unique id of the Department.

.PARAMETER Name
    Return by Department Name.

.PARAMETER Fields
    Allows you to view all the built-in and custom fields for Department in your Freshservice account.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceDepartment

    description   : Support Team
    custom_fields :
    id            : 21000097759
    name          : Customer Support
    created_at    : 8/29/2022 2:17:32 PM
    updated_at    : 8/29/2022 2:17:32 PM
    prime_user_id :
    head_user_id  :
    domains       : {}

    description   : Development Team
    custom_fields :
    id            : 21000097757
    name          : Development
    created_at    : 8/29/2022 2:17:32 PM
    updated_at    : 8/29/2022 2:17:32 PM
    prime_user_id :
    head_user_id  :
    domains       : {}

    description   : Finance Team
    custom_fields :
    id            : 21000097760
    name          : Finance
    created_at    : 8/29/2022 2:17:32 PM
    updated_at    : 8/29/2022 2:17:32 PM
    prime_user_id :
    head_user_id  :
    domains       : {}

    Returns all Freshservice Departments.
.EXAMPLE
    Get-FreshServiceDepartment -Id 21000097759

    description   : Support Team
    custom_fields :
    id            : 21000097759
    name          : Customer Support
    created_at    : 8/29/2022 2:17:32 PM
    updated_at    : 8/29/2022 2:17:32 PM
    prime_user_id :
    head_user_id  :
    domains       : {}

    Return Freshservice Department by Id.

.EXAMPLE
    Get-FreshServiceDepartment -Name 'Customer Support'

    description   : Support Team
    custom_fields :
    id            : 21000097759
    name          : Customer Support
    created_at    : 8/29/2022 2:17:32 PM
    updated_at    : 8/29/2022 2:17:32 PM
    prime_user_id :
    head_user_id  :
    domains       : {}

    Return Freshservice Department By Name.

.EXAMPLE
    Get-FreshServiceDepartment -Fields

    created_at       : 2022-08-29 14:17:31
    updated_at       : 2022-08-29 14:17:31
    name             : name
    label            : Department Name
    mandatory        : True
    is_default_field : True

    created_at       : 2022-08-29 14:17:31
    updated_at       : 2022-08-29 14:17:31
    name             : description
    label            : Description
    mandatory        : False
    is_default_field : True

    created_at       : 2022-08-29 14:17:31
    updated_at       : 2022-08-29 14:17:31
    name             : domain_names
    label            : Domains for this Department
    mandatory        : False
    is_default_field : True

    created_at       : 2022-08-29 14:17:31
    updated_at       : 2022-08-29 14:17:31
    name             : head_name
    label            : Department Head
    mandatory        : False
    is_default_field : True

    created_at       : 2022-08-29 14:17:31
    updated_at       : 2022-08-29 14:17:31
    name             : prime_user_name
    label            : Prime User
    mandatory        : False
    is_default_field : True

    Return all the built-in and custom fields for Department.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceDepartment {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Department.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the department',
            ParameterSetName = 'ByName',
            Position = 0
        )]
        [string]$Name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allows you to view all the built-in and custom fields for Department in your Freshservice account.',
            ParameterSetName = 'Form',
            Position = 0
        )]
        [Alias('Form')]
        [switch]$fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'ByName',
            Position = 1
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'ByName',
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

        if ($fields){
            $uri = [System.UriBuilder]('{0}/department_fields' -f $PrivateData['FreshserviceBaseUri'])
        }
        else {
            $uri = [System.UriBuilder]('{0}/departments' -f $PrivateData['FreshserviceBaseUri'])
        }

        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }
        elseif ($Name) {
            $qry.Add('query', '"name:''{0}''"' -f $Name )
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

                if ($result.Content) {
                    $content = $result.Content |
                                    ConvertFrom-Json

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
