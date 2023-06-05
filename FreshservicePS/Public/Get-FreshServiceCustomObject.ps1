<#
.SYNOPSIS
    Returns a Freshservice Custom Object.

.DESCRIPTION
    Returns a Freshservice Custom Object via REST API.

    https://api.freshservice.com/#list_all_custom_objects

.PARAMETER Id
    Unique id of the Custom Object.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceCustomObject

    id              : 21000011818
    title           : Service Item Approvals
    description     : This is a sample object to store additional information about the Items available on the Service
                    Catalog such as designated Approvers, Vendor Information and Category. When a request for an item
                    in this list is raised, you can use this information within the workflows to enrich your
                    automations. Check out our sample workflow "Service Item Approvals/Routing with Custom Objects"
    updated_at      : 8/29/2022 2:17:57 PM
    last_updated_by : @{email=system-noreply@its-fine.freshservice.com; id=21000418007; name=System}

    Returns all Freshservice Custom Objects.

.EXAMPLE
    Get-FreshServiceCustomObject -id 21000011818

    id          : 21000011818
    name        : service_item_approva_11
    title       : Service Item Approvals
    description : This is a sample object to store additional information about the Items available on the Service
                Catalog such as designated Approvers, Vendor Information and Category. When a request for an item in
                this list is raised, you can use this information within the workflows to enrich your automations.
                Check out our sample workflow "Service Item Approvals/Routing with Custom Objects"
    fields      : {@{name=item_name; label=Item Name; type=lookup; required=True; choices=System.Object[]; meta=},
                @{name=approver; label=Approver; type=lookup; required=False; choices=System.Object[]; meta=},
                @{name=vendor_information; label=Vendor Information; type=text; required=False;
                choices=System.Object[]; meta=}, @{name=category; label=Category; type=dropdown; required=False;
                fields=System.Object[]; choices=System.Object[]; meta=}...}
    meta        : @{total_records_count=10}

    Returns a Freshservice Custom Object by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceCustomObject {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Custom Object.',
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
        $uri = [System.UriBuilder]('{0}/objects' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $false

    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $true
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
                    $objProperty = $content[0].PSObject.Properties.Name |
                                        Where-Object -FilterScript {$_ -like 'custom_object*'}

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
