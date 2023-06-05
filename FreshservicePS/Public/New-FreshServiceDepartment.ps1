<#
.SYNOPSIS
    Creates a Freshservice Department.

.DESCRIPTION
    Creates Freshservice Department via REST API.

    https://api.freshservice.com/#create_a_department

.PARAMETER name
    Name of the Department

.PARAMETER description
    Description about the department

.PARAMETER head_user_id
    Unique identifier of the agent or requester who serves as the head of the department

.PARAMETER prime_user_id
    Unique identifier of the agent or requester who serves as the prime user of the department

.PARAMETER domains
    Email domains associated with the department

.PARAMETER custom_fields
    Custom fields that are associated with departments

.EXAMPLE
    New-FreshServiceDepartment -Name "TestDeptFromApi3" -description 'Another Test dept from API call' -domains "anotherchild.acme.com" -custom_fields @{awesome=$true}

    description   : Another Test dept from API call
    custom_fields : @{address=; awesome=True; support_expires=; msp_customer=; vendor_hosted=}
    id            : 18000196571
    name          : TestDeptFromApi3
    created_at    : 3/31/2022 12:10:50 AM
    updated_at    : 3/31/2022 12:10:50 AM
    prime_user_id :
    head_user_id  :
    domains       : {anotherchild.acme.com}

    Adds a new department called TestDeptFromApi3 with email domains anotherchild.acme.com and sets a custom field "awesome"

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceDepartment {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the Department',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description about the department..',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent or requester who serves as the head of the department.'
        )]
        [long]$head_user_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the agent or requester who serves as the prime user of the department.'
        )]
        [long]$prime_user_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email domains associated with the department'
        )]
        [string[]]$domains,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Custom fields that are associated with departments'
        )]
        [hashtable]$custom_fields
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/departments' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            #if ($PSBoundParameters[$PSItem] -is [boolean]) {
            #    $jsonBody[$PSItem.ToLower()] = [int]$PSBoundParameters[$PSItem]
            #}
            #else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            #}
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
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
