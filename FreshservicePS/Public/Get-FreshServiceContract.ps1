<#
.SYNOPSIS
    Returns a Freshservice Contract.

.DESCRIPTION
    Returns a Freshservice Contract via REST API.

    https://api.freshservice.com/#view_a_contract

.PARAMETER id
    Unique id of the FreshService Contract.

.PARAMETER associated_assets
    View information about all the associated assets of a contract.

.PARAMETER attachments
    View information about all the associated attachments of a contract.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceContract

    id                    : 6
    name                  : Microsoft O365 Contract V2
    description           : Test contract from API
    vendor_id             : 18000414331
    auto_renew            : True
    notify_expiry         : True
    notify_before         : 30
    approver_id           : 18012453181
    start_date            : 9/21/2022 11:21:24 PM
    end_date              : 9/21/2023 11:21:24 PM
    cost                  : 1234
    status                : draft
    contract_number       : MSFT2
    contract_type_id      : 3
    visible_to_id         : 18000144649
    notify_to             : {john.smith@company.com}
    custom_fields         :
    software_id           : 18001038620
    license_type          : volume
    billing_cycle         : annual
    license_key           :
    item_cost_details     : {@{id=18000043113; item_name=Installation; pricing_model=per_unit; cost=200; comments=;
                            count=1; created_at=9/21/2022 11:21:25 PM; updated_at=9/21/2022 11:21:25 PM}}
    future_contract_id    :
    has_associated_assets : False
    has_attachments       : False
    expiry_notified       : False
    requester_id          : 18012453181
    delegatee_id          :
    created_at            : 9/21/2022 12:56:44 PM
    updated_at            : 9/21/2022 11:21:25 PM

    id                    : 5
    name                  : Microsoft O365 Contract
    description           : Test contract from API
    vendor_id             : 18000414331
    auto_renew            : True
    notify_expiry         : True
    notify_before         : 30
    approver_id           : 18012453181
    start_date            : 9/19/2022 7:56:40 PM
    end_date              : 9/19/2023 7:56:40 PM
    cost                  : 1500
    status                : draft
    contract_number       : MSFT1
    contract_type_id      : 3
    visible_to_id         : 18000144649
    notify_to             : {john.smith@company.com}
    custom_fields         :
    software_id           : 18001038620
    license_type          : volume
    billing_cycle         : one_time
    license_key           :
    item_cost_details     : {@{id=18000043084; item_name=Installation; pricing_model=per_unit; cost=200; comments=;
                            count=1; created_at=9/19/2022 7:56:41 PM; updated_at=9/19/2022 7:56:41 PM}}
    future_contract_id    :
    has_associated_assets : False
    has_attachments       : False
    expiry_notified       : False
    requester_id          : 18012453181
    delegatee_id          :
    created_at            : 9/19/2022 7:56:41 PM
    updated_at            : 9/19/2022 7:56:41 PM

    Returns all Freshservice Contracts.

.EXAMPLE
    Get-FreshServiceContract -Id 5

    id                    : 5
    name                  : Microsoft O365 Contract
    description           : Test contract from API
    vendor_id             : 18000414331
    auto_renew            : True
    notify_expiry         : True
    notify_before         : 30
    approver_id           : 18012453181
    start_date            : 9/19/2022 7:56:40 PM
    end_date              : 9/19/2023 7:56:40 PM
    cost                  : 1500
    status                : draft
    contract_number       : MSFT1
    contract_type_id      : 3
    visible_to_id         : 18000144649
    notify_to             : {john.smith@company.com}
    custom_fields         :
    software_id           : 18001038620
    license_type          : volume
    billing_cycle         : one_time
    license_key           :
    item_cost_details     : {@{id=18000043084; item_name=Installation; pricing_model=per_unit; cost=200; comments=;
                            count=1; created_at=9/19/2022 7:56:41 PM; updated_at=9/19/2022 7:56:41 PM}}
    future_contract_id    :
    has_associated_assets : False
    has_attachments       : False
    expiry_notified       : False
    requester_id          : 18012453181
    delegatee_id          :
    created_at            : 9/19/2022 7:56:41 PM
    updated_at            : 9/19/2022 7:56:41 PM

    Return a Freshservice Contract by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceContract {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the contract',
            ParameterSetName = 'id',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the contract',
            ParameterSetName = 'assets',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the contract',
            ParameterSetName = 'attachments',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'View information about all the associated assets of a contract.',
            ParameterSetName = 'assets',
            Position = 1
        )]
        [switch]$associated_assets,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'View information about all the associated attachments of a contract.',
            ParameterSetName = 'attachments',
            Position = 1
        )]
        [switch]$attachments,
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
        $uri = [System.UriBuilder]('{0}/contracts' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

        if ($id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

        if ($associated_assets) {
            $uri.Path = "{0}/associated-assets" -f $uri.Path
        }elseif ($attachments) {
            $uri.Path = "{0}/attachments" -f $uri.Path
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
