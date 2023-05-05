<#
.SYNOPSIS
    Updates a Freshservice Custom Object Record.

.DESCRIPTION
    Updates a Freshservice Custom Object Record via REST API.

    https://api.freshservice.com/#put_custom_object_record

.PARAMETER custom_object_id
    Unique ID of the Custom Object.

.PARAMETER id
    Unique ID of the Custom Object Record.

.PARAMETER data
    Hashtable containing the data to update on Custom Object Record.

.EXAMPLE
    Set-FreshServiceCustomObjectRecord -custom_object_id 21000011818 -id 4 -data @{vendor_information='sales@dell.com'}

    agent_group        : 21000188390
    approver           : 21000418009
    bo_created_at      : 8/29/2022 2:17:58 PM
    bo_created_by      : 21000418007
    bo_display_id      : 4
    bo_updated_at      : 3/30/2023 7:41:23 PM
    bo_updated_by      : 21000418005
    category_dd1       : Software
    category_dd2       :
    category_dd3       :
    item_name          : 21000487354
    vendor_information : sales@dell.com

    Updates a FreshService Custom Object Record. The data is passed as a hashtable.  Any dropdown lookups on Freshservice objects are the object id of the selected item.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceCustomObjectRecord {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique ID of the Custom Object.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$custom_object_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique ID of the Custom Object Record',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('record_id')]
        [long]$id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Hashtable containing the data to update on Custom Object Record.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$data
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/objects' -f $PrivateData['FreshserviceBaseUri'])

        if ($PSBoundParameters.ContainsKey('custom_object_id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $custom_object_id
            [void]$PSBoundParameters.Remove('custom_object_id')
        }

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/records/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
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
