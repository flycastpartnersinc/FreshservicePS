<#
.SYNOPSIS
    Helper function to create item cost detail (e.g. item_cost_details) for New-FreshServiceContract and Set-FreshServiceContract.

.DESCRIPTION
    Helper function to create item cost detail (e.g. item_cost_details) for New-FreshServiceContract and Set-FreshServiceContract.

.PARAMETER item_name
    Name of the particular line item.

.PARAMETER pricing_model
    Represents the pricing unit of a particular line item. Values are per_unit, fixed, one_time. The default value is "per_unit".

.PARAMETER cost
    Represents the cost of a particular line item.

.PARAMETER count
    Represents the number of units of a particular line item

.PARAMETER comments
    To add any additional comments for a particular line item.

.EXAMPLE
    New-FreshServiceContractItem -item_name License -pricing_model per_unit -cost 18.44 -count 350 -comments 'Per user licensing costs'

    item_name     : License
    comments      : Per user licensing costs
    pricing_model : per_unit
    count         : 350
    cost          : 18.44

    Creates a Freshservice Contract Item.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceContractItem {
    [OutputType('System.Object[]')]
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the particular line item.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('Name')]
        [string]$item_name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Represents the pricing unit of a particular line item. Values are per_unit, fixed, one_time. The default value is "per_unit".',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('per_unit','fixed','one_time')]
        [string]$pricing_model,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Represents the cost of a particular line item.',
            ValueFromPipelineByPropertyName = $true
        )]
        [decimal]$cost,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Represents the number of units of a particular line item.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$count,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'To add any additional comments for a particular line item.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$comments
    )
    begin {

    }
    process {
        if ($PSCmdlet.ShouldProcess($item_name)) {

            $jsonBody = @{}
            $PSBoundParameters.keys.where{
                $PSItem -notin $PrivateData.FreshserviceBodyExclusions
            }.foreach{
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }

            [pscustomobject[]]$jsonBody

        }
    }
    end {}
}
