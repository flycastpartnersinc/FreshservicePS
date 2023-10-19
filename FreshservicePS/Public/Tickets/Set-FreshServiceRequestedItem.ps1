<#
.SYNOPSIS
    Updates Freshservice Service Request Requested Item.

.DESCRIPTION
    Updates Freshservice Service Request Requested Item via REST API.

    https://api.freshservice.com/#update_req_items_of_sr

.PARAMETER service_request_id
    Unique display id of the service item.

.PARAMETER id
    Unique id of the requested item.

.PARAMETER quantity
    Number of units of the item needed by the requester. By default it is 1

.PARAMETER stage
    Current stage of the requested item

    1 = Requested
    2 = Delivered
    3 = Cancelled
    4 = Fulfilled
    5 = Partially Fulfilled

.PARAMETER service_item_id
    Display id of service item unique to your account

.EXAMPLE
    Set-FreshServiceRequestedItem -id 95 -id 21000277486 -quantity 1

    id                 : 21000277486
    from_date          :
    to_date            :
    item_id            : 2
    location           :
    quantity           : 1
    service_request_id : 21003879652
    remarks            :
    is_parent          : True
    fulfilled_quantity : 0
    stage              : @{id=2; name=Delivered}
    fulfilled          : False
    cost               : 699.00
    ticket_id          : 95
    custom_fields      :
    item               : @{id=21000487352; name=Windows Laptop; display_id=2; deleted=False; item_type=; cost_visibility=True; quantity_visibility=True; icon_detail=; ci_type=; product=; short_description=Request for a new Laptop; description=<div class="fixture-sitem">Windows Laptops are the corporate
                        standard laptop for employees. Request for a
                                                                                                            new Windows laptop. <div>
                                                                                                            <div>PRODUCT FEATURES</div>
                                                                                                            <p>2.5 GHz Intel Core i5 Processor</p>
                                                                                                            <p>750 GB Hard Drive</p>
                                                                                                            <p>8 GB RAM</p>
                                                                                                            <p>Microsoft Windows 8</p>
                                                                                                            <p>Microsoft Office</p> </div></div>}
    Update the quantity requested on a Requested Item of a Service Request.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceRequestedItem {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique display id of the service item.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [long]$service_request_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the requested item',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of units of the item needed by the requester. By default it is 1',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [int]$quantity,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Current stage of the requested item',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [ValidateRange(1,5)]
        [int]$stage
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/tickets' -f $PrivateData['FreshserviceBaseUri'])

        if ($service_request_id) {
            $uri.Path = "{0}/{1}/requested_items" -f $uri.Path, $service_request_id
            [void]$PSBoundParameters.Remove('service_request_id')
        }

        if ($id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
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
