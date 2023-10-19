<#
.SYNOPSIS
    Returns a Freshservice Custom Object Record.

.DESCRIPTION
    Returns a Freshservice Custom Object Record via REST API.

    https://api.freshservice.com/#create_custom_object_record

.PARAMETER custom_object_id
    Unique id of the Custom Object

.PARAMETER data
    Hashtable with data to be inserted as Custom Object Record.

.EXAMPLE
    $params = @{
        custom_object_id = 21000011818
        data = @{
            agent_group        = 21000188390
            approver           = 21000418009
            category_dd1       = 'Hardware'
            item_name          = 21000487364
            vendor_information = 'sales@dell.com'
        }
    }

    New-FreshServiceCustomObjectRecord @params

    Create a new Custom Object Record.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceCustomObjectRecord {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Custom Object.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('id')]
        [long]$custom_object_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Hashtable with data to be inserted as Custom Object Record.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$data
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/objects' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        if ($custom_object_id) {
            $uri.Path = "{0}/{1}/records" -f $uri.Path, $custom_object_id
            [void]$PSBoundParameters.Remove('custom_object_id')
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
                    Method      = 'POST'
                    Body        =  $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                if ($result.Content) {
                    $content = $result.Content |
                                    ConvertFrom-Json

                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)".data
                }
            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
