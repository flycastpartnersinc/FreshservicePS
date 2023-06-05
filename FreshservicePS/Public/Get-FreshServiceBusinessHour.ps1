<#
.SYNOPSIS
    Returns a Freshservice Business Hours.

.DESCRIPTION
    Returns a Freshservice Business Hours via REST API.

.PARAMETER Id
    Unique id of the specific Business Hour.

    https://api.freshservice.com/#business-hours

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceBusinessHour

    id                 : 21000011791
    created_at         : 8/29/2022 2:17:01 PM
    updated_at         : 8/29/2022 2:17:01 PM
    name               : Default
    description        : Default Business Calendar
    is_default         : True
    time_zone          : Eastern Time (US & Canada)
    service_desk_hours : @{monday=; tuesday=; wednesday=; thursday=; friday=}
    list_of_holidays   : {@{holiday_date=--01-16; holiday_name=Birthday of Martin Luther King Jr}, @{holiday_date=--02-20;
                        holiday_name=Washington's Birthday}, @{holiday_date=--05-28; holiday_name=Memorial Day},
                        @{holiday_date=--07-04; holiday_name=Independence Day}...}

    Return all Freshservice Business Hours.

.EXAMPLE
    Get-FreshServiceBusinessHour -Id 21000011791

    id                 : 21000011791
    created_at         : 8/29/2022 2:17:01 PM
    updated_at         : 8/29/2022 2:17:01 PM
    name               : Default
    description        : Default Business Calendar
    is_default         : True
    time_zone          : Eastern Time (US & Canada)
    service_desk_hours : @{monday=; tuesday=; wednesday=; thursday=; friday=}
    list_of_holidays   : {@{holiday_date=--01-16; holiday_name=Birthday of Martin Luther King Jr}, @{holiday_date=--02-20;
                        holiday_name=Washington's Birthday}, @{holiday_date=--05-28; holiday_name=Memorial Day},
                        @{holiday_date=--07-04; holiday_name=Independence Day}...}

    Returns a Freshservice Business Hour by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceBusinessHour {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of Business Hour.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/business_hours' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
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
