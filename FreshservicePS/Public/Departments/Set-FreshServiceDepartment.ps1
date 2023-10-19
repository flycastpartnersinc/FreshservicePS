<#
.SYNOPSIS
    Updates a Freshservice Department.

.DESCRIPTION
    Updates a Freshservice Department via REST API.

    https://api.freshservice.com/#update_a_department

.PARAMETER id
    Unique id of the department.

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
    Set-FreshServiceDepartment -id 21000097757 -description "Development Team"

    description   : Development Team
    custom_fields :
    id            : 21000097757
    name          : Development
    created_at    : 8/29/2022 2:17:32 PM
    updated_at    : 8/29/2022 2:17:32 PM
    prime_user_id :
    head_user_id  :
    domains       : {}

    Updates the description ona Freshservice Department.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceDepartment {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the department.'
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
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

    }
    process {

        $uri = [System.UriBuilder]('{0}/departments' -f $PrivateData['FreshserviceBaseUri'])

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
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
