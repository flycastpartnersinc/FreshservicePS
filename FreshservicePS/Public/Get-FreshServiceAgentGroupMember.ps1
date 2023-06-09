<#
.SYNOPSIS
    Returns a Freshservice Agent Group Member.

.DESCRIPTION
    Returns a Freshservice Agent Group Member via REST API.

    This is a wrapper function for https://api.freshservice.com/#view_a_group using the Members property. The
    default behavior is to overwrite existing members with what is passed, so this wrapper function gets the
    existing members and appends them to make the default behavior adding a member.

.PARAMETER id
    Unique id of the Agent Group to get members from.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceAgentGroupMember -id 21000543793

            id first_name last_name   email
            -- ---------- ---------   -----
    21001392937 Dana        Franks dana@example.com
    21001931878 Alex       Smith     Alex@example.com

    Returns members of a Freshservice Agent Group.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceAgentGroupMember {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Agent Group to get members.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Alias('Agent_group_id')]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 3
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/groups' -f $PrivateData['FreshserviceBaseUri'])
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

        try {
            $members = foreach ($member in ($results | Select-Object -ExpandProperty members)) {
                Get-FreshServiceAgent -id $member -ErrorAction Stop |
                    Select-Object -Property id, first_name, last_name, email
            }
        }
        catch {
            Throw $_
        }

    }
    end {

        $members
    }
}
