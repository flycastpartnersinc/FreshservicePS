<#
.SYNOPSIS
    Creates new Freshservice Service Request.

.DESCRIPTION
    Creates new Freshservice Service Request via REST API.

    The service requested will be created with the requester specified in "email" attribute. If no email is provided, the request is created on behalf of the agent

    Fields in the API behave like the agent portal's new service request page. If a field is not visible in self service portal, you can still provide a value for
    that field using the api. If a field is marked mandatory but not visible in portal in service item, you must provide a value for it in the api.

    https://api.freshservice.com/#create_service_request

.PARAMETER display_id
    The Display Id of the Service Request to be requested.

.PARAMETER quantity
    Quantity needed by the requested

.PARAMETER requested_for
    Email id of the requester on whose behalf the service request is created

.PARAMETER email
    Email id of the requester

.PARAMETER child_items
    Service items that are included as child items. Provide the display id as service_item_id for each child item.

.PARAMETER custom_fields
    Values of custom fields present in the service item form

.PARAMETER quantity
    Quantity needed by the requested

.PARAMETER requested_for
    Email id of the requester on whose behalf the service request is created

.PARAMETER email
    Email id of the requester

.PARAMETER child_items
    Service items that are included as child items. Provide the display id as service_item_id for each child item.

.PARAMETER custom_fields
    Values of custom fields present in the service item form

.PARAMETER quantity
    Quantity needed by the requested

.PARAMETER parent_ticket_id
    Create as a child request. Display ID of the parent Service Request

    Note 1:
        Association of child Service Requests to an Incident is not possible

    Note 2:
        Association of child Service Request to a deleted or a spammed ticket is not allowed.

    Note 3:
        Nesting of a child Service Request under another child Service Request is not supported.

.EXAMPLE
    New-FreshServiceRequest -display_id 2 -email 'alex@example.com'

    subject              : Request for Alex : Windows Laptop
    group_id             :
    department_id        :
    category             :
    sub_category         :
    item_category        :
    requester_id         : 21000418005
    responder_id         :
    due_by               : 1/10/2023 12:14:43 PM
    fr_escalated         : False
    deleted              : False
    spam                 : False
    email_config_id      :
    fwd_emails           : {}
    reply_cc_emails      : {}
    cc_emails            : {}
    is_escalated         : False
    fr_due_by            : 1/6/2023 2:14:43 PM
    created_at           : 1/5/2023 8:14:43 PM
    updated_at           : 1/5/2023 8:14:43 PM
    status               : 2
    source               : 2
    priority             : 2
    urgency              : 1
    impact               : 1
    sla_policy_id        : 21000057781
    id                   : 12
    type                 : Service Request
    description          :
    description_text     :
    to_emails            :
    approval_status      : not_requested
    approval_status_name : Not Requested
    custom_fields        : @{my_custom_dropdown=}
    attachments          : {}

    Creates a new Freshservice Service Request.

.EXAMPLE
    New-FreshServiceRequest -parent_ticket_id 221 -display_id 3 -quantity 2 -email 'alex@example.com'

    subject              : Request for Alex : Microsoft Office 2013
    group_id             :
    department_id        :
    category             :
    sub_category         :
    item_category        :
    requester_id         : 21000418005
    responder_id         :
    due_by               : 4/27/2023 3:40:04 PM
    fr_escalated         : False
    deleted              : False
    spam                 : False
    email_config_id      :
    fwd_emails           : {}
    reply_cc_emails      : {}
    cc_emails            : {}
    is_escalated         : False
    fr_due_by            : 4/25/2023 5:40:04 PM
    created_at           : 4/24/2023 6:40:04 PM
    updated_at           : 4/24/2023 6:40:04 PM
    status               : 2
    source               : 2
    priority             : 2
    urgency              : 1
    impact               : 1
    sla_policy_id        : 21000057781
    id                   : 227
    type                 : Service Request
    description          :
    description_text     :
    to_emails            :
    approval_status      : not_requested
    approval_status_name : Not Requested
    custom_fields        : @{weather_server=}
    attachments          : {}

    Create a Freshservice child ticket for a parent ticket.

    Note 1:
        Association of child Service Requests to an Incident is not possible

    Note 2:
        Association of child Service Request to a deleted or a spammed ticket is not allowed.

    Note 3:
        Nesting of a child Service Request under another child Service Request is not supported.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceRequest {
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
            Mandatory = $false,
            HelpMessage = 'Quantity needed by the requested',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$quantity,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email id of the requester on whose behalf the service request is created',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$requested_for,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email id of the requester',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Service items that are included as child items. Provide the display id as service_item_id for each child item.',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$child_items,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Values of custom fields present in the service item form',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Create as a child request. Display Id of the Service Request.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('parent_id')]
        [long]$parent_ticket_id
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {
        $uri = [System.UriBuilder]('{0}/service_catalog/items/{1}/place_request' -f $PrivateData['FreshserviceBaseUri'], $display_id)

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
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

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
