<#
.SYNOPSIS
    Helper function to create item relationship types for New-FreshServiceRelationship.

.DESCRIPTION
    Helper function to create item relationship types for New-FreshServiceRelationship. Relationships can be created between
    Asset, Requester, Agent, Department or Software. This helper function assists with generation of the PSObject within the confines
    of the documentation for the -relationship_item parameter.

.PARAMETER relationship_type_id
    Unique id of the relationship type. See Get-FreshserviceRelationshipType.

.PARAMETER primary_id
    Display ID of the entity from which the relationship will be created.

.PARAMETER primary_type
    Type of the entity from which the relationship will be created. Supported values are asset, requester, agent, department or software.

.PARAMETER secondary_id
    Display ID of the entity from which the relationship will be created.

.PARAMETER secondary_type
    Type of the entity from which the relationship will be created. Supported values are asset, requester, agent, department or software.

.EXAMPLE
    $newFreshServiceRelationshipItemSplat = @{
        relationship_type_id = 21000356921 #Get-FreshServiceRelationshipType
        primary_id           = 42
        primary_type         = 'asset'
        secondary_id         = 41
        secondary_type       = 'asset'
    }

    New-FreshServiceRelationshipItem @newFreshServiceRelationshipItemSplat

    secondary_type       : asset
    secondary_id         : 41
    relationship_type_id : 21000356921
    primary_type         : asset
    primary_id           : 42

    Create a relationship item.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceRelationshipItem {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the relationship type.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$relationship_type_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Display ID of the entity from which the relationship will be created.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$primary_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'v',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('asset', 'requester', 'agent', 'department', 'software')]
        [string]$primary_type,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Display ID of the entity from which the relationship will be created.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$secondary_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Type of the entity from which the relationship will be created.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('asset', 'requester', 'agent', 'department', 'software')]
        [string]$secondary_type
      )
    begin {

    }
    process {
        if ($PSCmdlet.ShouldProcess($relationship_type_id)) {
            $jsonBody = @{}
            $PSBoundParameters.keys.where{
                $PSItem -notin $PrivateData.FreshserviceBodyExclusions
            }.foreach{
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }

            [pscustomobject]$jsonBody
        }
    }
    end {}
}
