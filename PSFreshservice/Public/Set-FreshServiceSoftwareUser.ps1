<#
.SYNOPSIS
    Updates a Freshservice Software User.

.DESCRIPTION
    Updates a Freshservice Software User via REST API.

    https://api.freshservice.com/#bulk_update_users

.PARAMETER id
    Unique Id of the software to add the user.

.PARAMETER user_id
    Unique id of the User using the Software.

.PARAMETER license_id
    Display ID of the allocated Software License Contract.

.PARAMETER allocated_date
    Date and time when the license was allocated.

.PARAMETER first_used
    Date and time when the application was first used by the user.

.PARAMETER last_used
    Date and time when the application was last used by the user.

.PARAMETER source
    Name of the source from where the user details are updated (API, Okta, Google...etc).

.EXAMPLE
    Set-FreshServiceSoftwareUser -software_id 21000240240 -user_id 21000418006 -last_used (Get-Date)

    api/v2/applications/21000240240/users/21000064394

    Updates the last used date on a Freshservice Software User on a provided Freshservice Software.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceSoftwareUser {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the software to add the installation.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('software_id')]
        [long]$id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the User using the Software. ',
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$user_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Display ID of the allocated Software License Contract.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$license_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Date and time when the license was allocated.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$allocated_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Date and time when the application was first used by the user.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$first_used,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Date and time when the application was last used by the user.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$last_used,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the source from where the user details are updated (API, Okta, Google...etc).',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$source
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $newRecords = @()

        $uri = [System.UriBuilder]('{0}/applications' -f $PrivateData['FreshserviceBaseUri'])

        if ($id) {
            $uri.Path = "{0}/{1}/users" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('id')
        }

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ($PSBoundParameters[$PSItem] -is [datetime]) {
                $jsonBody[$PSItem.ToLower()] = Get-Date -Date $PSBoundParameters[$PSItem] -Format "o"
            }
            else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }
        }

       foreach ($id in $user_id) {
            $newRecords += [PSCustomobject[]]$jsonBody
        }
    }
    end {
        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
                    Body        = [PSCustomObject]@{application_users = $newRecords} | ConvertTo-Json
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
}
