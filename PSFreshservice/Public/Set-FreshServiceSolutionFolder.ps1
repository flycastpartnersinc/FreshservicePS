<#
.SYNOPSIS
    Creates Freshservice solution folder.

.DESCRIPTION
    Creates Freshservice solution folder via REST API.

    https://api.freshservice.com/#solution-folder

.PARAMETER id
    Unique ID of the folder.

.PARAMETER name
    Name of the solution folder. The maximum number of characters allowed is 255.

.PARAMETER description
    Description of the solution folder in plain text or HTML format.

.PARAMETER category_id
    Unique id of the category under which the folder is listed.

.PARAMETER visibility
    Accessibility of this folder

    'All'             =    1
    'Logged_in_Users' = 2
    'Agents_Only'     = 3
    'Departments'     =    4
    'Agent_groups'    = 5
    'Contact_groups'  = 6

.PARAMETER approval_settings
    Approval settings that have been associated with the folder. Key-value pair containing the approval_type, approval_ids and its values.

.PARAMETER department_ids
    Unique id of the department to which this solution folder is visible. ( Mandatory if visibility is set to '4')

.PARAMETER group_ids
    Unique id of the Agent Groups to which this solution folder is visible. ( Mandatory if visibility is set to '5')

.PARAMETER requester_group_ids
    Unique id of the Contact Groups to which this solution folder is visible. ( Mandatory if visibility is set to '6')

.PARAMETER manage_by_group_ids
    Unique ID of the Groups to which this solution folder is managed by.

.EXAMPLE
    Set-FreshServiceSolutionFolder -id 18000066002 -description "Shiny new folder"

    description         : Shiny new folder
    id                  : 18000066002
    created_at          : 9/30/2022 2:16:32 AM
    updated_at          : 9/30/2022 2:19:18 AM
    name                : MyNewSolutionFolder
    category_id         : 18000018546
    position            : 4
    visibility          : 1
    approval_settings   :
    default_folder      : False
    manage_by_group_ids : {}

    Updates a description on a Freshservice Solution folder.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceSolutionFolder {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
         [Parameter(
             Mandatory = $true,
             HelpMessage = 'Unique identifier of the solution folder.',
             ValueFromPipelineByPropertyName = $true
         )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the solution folder. The maximum number of characters allowed is 255.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the solution folder in plain text.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the category under which the folder is listed.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$category_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Accessibility of this folder.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,6)]
        [int]$visibility,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Approval settings that have been associated with the folder. Key-value pair containing the approval_type, approval_ids and its values.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$approval_settings,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the department to which this solution folder is visible. ( Mandatory if visibility is set to 4).',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$department_ids,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Agent Groups to which this solution folder is visible. ( Mandatory if visibility is set to 5)',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$group_ids,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Contact Groups to which this solution folder is visible. ( Mandatory if visibility is set to 6).',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$requester_group_ids,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the Groups to which this solution folder is managed by.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$manage_by_group_ids
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/solutions/folders' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
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
