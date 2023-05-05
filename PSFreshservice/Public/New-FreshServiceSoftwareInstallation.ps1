<#
.SYNOPSIS
    Creates a new Freshservice Software Installation.

.DESCRIPTION
    Creates a new Freshservice Software Installation via REST API.

    https://api.freshservice.com/#create_an_installations

.PARAMETER id
    Unique ID of the software installation.

.PARAMETER installation_machine_id
    Display ID (display_id) of device where the software is installed in.

.PARAMETER installation_path
    Path where the software is installed.

.PARAMETER version
    Version of the installed software.

.PARAMETER installation_date
    Date and time when the application was installed.

.EXAMPLE
    New-FreshServiceSoftwareInstallation -id 21000240239 -installation_machine_id 1 -installation_path 'C:\Program Files\Freshservice' -version '13.5.1211' -Verbose

    id                      : 21024172801
    created_at              : 3/28/2023 6:44:09 PM
    updated_at              : 3/28/2023 6:44:09 PM
    installation_path       : C:\Program Files\Freshservice
    version                 : 13.5.1211
    installation_machine_id : 1
    user_id                 : 21000418006
    department_id           :
    installation_date       :

    Associate a installation with a device.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceSoftwareInstallation {
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
            HelpMessage = 'Display ID of device where the software is installed in.',
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('display_id','machine_id')]
        [long]$installation_machine_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Path where the software is installed.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('Path','Fullname')]
        [string]$installation_path,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Version of the installed software.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$version,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Date and time when the application was installed.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$installation_date
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/applications' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        if ($id) {
            $uri.Path = "{0}/{1}/installations" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json -Depth 5

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
