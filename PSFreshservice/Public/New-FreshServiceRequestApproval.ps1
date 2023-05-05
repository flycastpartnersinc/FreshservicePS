<#
.SYNOPSIS
    Creates new Freshservice Service Request Approval.

.DESCRIPTION
    Creates new Freshservice Service Request Approval via REST API.

    https://api.freshservice.com/#create_ticket_approval

.PARAMETER display_id
    Display Id of the Service Request.

.PARAMETER approver_id
    User ID of the approver.

.PARAMETER approval_type
    Helps define the type of approval in case there are more than one approvers:

    1 = To be approved by Everyone
    2 = To be approved by Anyone
    3 = To be approved by Majority
    4 = To be approved by First Responder

.PARAMETER email_content
    HTML content of the approval email. Overrides the default approval notification will be sent to approvers.

.EXAMPLE
    New-FreshServiceRequestApproval -display_id 221 -approver_id 21001931878 -approval_type 2

    id              : 21000143868
    created_at      : 4/24/2023 7:29:38 PM
    updated_at      : 4/24/2023 7:29:38 PM
    approver_id     : 21001931878
    approver_name   : Rob Simmers
    approval_type   : 2
    user_id         : 21000418005
    level           : 1
    user_name       : Rob Simmers
    approval_status : @{id=0; name=requested}
    delegatee       :
    latest_remark   :

    Create a new Freshservice Service Request Approval.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceRequestApproval {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Display Id of the Service Request.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('SRID','DisplayId')]
        [long]$display_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'User ID of the approver.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$approver_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Quantity needed by the requested',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,4)]
        [int]$approval_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email id of the requester on whose behalf the service request is created',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$email_content
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {
        $uri = [System.UriBuilder]('{0}/tickets/{1}/approvals' -f $PrivateData['FreshserviceBaseUri'], $display_id)

        [void]$PSBoundParameters.Remove('display_id')

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            # if ( 'service request_type','status' -contains $PSItem ) {
                # $jsonBody[$PSItem.ToLower()] = ($PSBoundParameters[$PSItem]).ToLower()
            # }
            # else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            # }
        }

        try {
            if ($PSCmdlet.ShouldProcess($display_id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
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
