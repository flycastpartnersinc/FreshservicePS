<#
.SYNOPSIS
    Updates a Freshservice Location.

.DESCRIPTION
    Updates a Freshservice Location via REST API.

    https://api.freshservice.com/#update_a_location

.PARAMETER id
    Unique id of the location

.PARAMETER name
    Name of the location

.PARAMETER contact_name
    Name of the Location Contact.

.PARAMETER email
    Email of the Location Contact.

.PARAMETER phone
    Phone number of the Location Contact.

.PARAMETER parent_location_id
    Unique id of the parent location.

.PARAMETER primary_contact_id
    User ID of the primary contact (must be a user in Freshservice)

.PARAMETER address
    Address with line1, line2, city, state, country and zip code properties'

.EXAMPLE
    Set-FreshServiceLocation -id 21000506386 -name 'Richmond Headquarters' -address @{line1='123 Corporate Ave';line2='Suite 100';city='Richmond';state='VA';zipcode='23223'}

    address            : @{line1=123 Corporate Ave; line2=Suite 100; city=Richmond; state=VA; country=US; zipcode=23223}
    contact_name       : John Smith
    created_at         : 3/9/2023 3:28:06 AM
    email              :
    id                 : 21000506386
    name               : Richmond Headquarters
    parent_location_id :
    phone              :
    primary_contact_id :
    updated_at         : 3/30/2023 11:53:52 PM

    Update a Freshservice Location.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceLocation {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Location.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the Location. ',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the Contact.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$contact_name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email of the Contact.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Phone of the Contact.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$phone,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the parent location.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$parent_location_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the primary contact (must be a user in Freshservice)',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$primary_contact_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Address with line1, line2, city, state, country and zip code properties',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$address
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/locations' -f $PrivateData['FreshserviceBaseUri'])

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

                $content = $result.Content |
                                ConvertFrom-Json

                if ($content) {
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
