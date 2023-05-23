<#
.SYNOPSIS
    Updates a Freshservice Product.

.DESCRIPTION
    Updates a Freshservice Product via REST API.

    https://api.freshservice.com/#update_a_product

.PARAMETER display_id
    Unique Display id of the Service Request.

.PARAMETER id
    Unique id of the Service Request Approval.

.PARAMETER cancel
    Cancel the approval.

.PARAMETER remind
    Send reminder for the approval.

.EXAMPLE
    Set-FreshServiceRequestApproval -display_id 221 -id 21000143868 -remind

    id display_id status
    -- ---------- ------
    21000143868        221 success

    Send a reminder for a Freshservice Request Approval. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.EXAMPLE
    Set-FreshServiceRequestApproval -display_id 221 -id 21000143868 -cancel

    id              : 21000143868
    created_at      : 4/24/2023 7:29:38 PM
    updated_at      : 4/24/2023 8:20:54 PM
    approver_id     : 21001931878
    approver_name   : Alex
    approval_type   : 2
    user_id         : 21000418005
    level           : 1
    user_name       : Alex
    approval_status : @{id=3; name=cancelled}
    delegatee       :
    latest_remark   :

    Cancel a Freshservice Request Approval.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceRequestApproval {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium',DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique ID of the Service Request.',
            Position = 0
        )]
        [long]$display_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique ID of the Service Request Approval.',
            Position = 1
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Cancel the approval.',
            ParameterSetName = 'cancel',
            Position = 2
        )]
        [switch]$cancel,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Send reminder for the Approval.',
            ParameterSetName = 'remind',
            Position = 2
        )]
        [switch]$remind
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {
        if ($remind) {
            $uri = [System.UriBuilder]('{0}/tickets/{1}/approvals/{2}/remind' -f $PrivateData['FreshserviceBaseUri'], $display_id, $id)
        }
        else {
            $uri = [System.UriBuilder]('{0}/tickets/{1}/approvals/{2}' -f $PrivateData['FreshserviceBaseUri'], $display_id, $id)
        }

        if ($display_id) {
            [void]$PSBoundParameters.Remove('display_id')
        }

        if ($Id) {
            [void]$PSBoundParameters.Remove('id')
        }

        if ($cancel) {
            [void]$PSBoundParameters.Remove('cancel')
            $PSBoundParameters.Add('approval_status',@{'id'=3})
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

                if (!$remind) {
                    $content = $result.Content |
                                    ConvertFrom-Json

                    if ($content) {
                        #API returns singluar or plural property based on the number of records, parse to get property returned.
                        $objProperty = $content[0].PSObject.Properties.Name
                        Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                        $content."$($objProperty)"
                    }
                }
                else {
                    [PSCustomObject]@{
                        id         = $id
                        display_id = $display_id
                        status     = "success {0}" -f $results.StatusCode
                    }
                }
            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
