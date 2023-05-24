<#
.SYNOPSIS
    Updates a Freshservice Project.

.DESCRIPTION
    Updates a Freshservice Project via REST API.

    https://api.freshservice.com/#create_a_project_newgen

    Only users with "View or Manage Projects" privilege can access this API endpoint.

.PARAMETER id
    Unique identifier of the project.

.PARAMETER name
    Name of the project. The maximum number of characters allowed is 255.

.PARAMETER description
    Description of the project in plain text or HTML format.

.PARAMETER key
    Project Key. The key should start with a letter followed by a combination
    of letters, numbers or both. The maximum length is 10 characters.

.PARAMETER status_id
    Status of the project.

    1 = Yet to Start
    2 = In Progress
    3 = Completed

.PARAMETER priority_id
    Priority of the project. Default is Medium (2).

    1 = Low
    2 = Medium
    3 = High
    4 = Urgent

.PARAMETER project_type
    Type of the Project.

    0 = Software
    1 = Business

.PARAMETER manager_id
    User ID of the project manager.

.PARAMETER start_date
    Start date of the project. The acceptable format is yyyy-mm-dd.

.PARAMETER end_date
    End date of the project. The acceptable format is yyyy-mm-dd.

.PARAMETER visibility
    Visibility of the project. Default is Public (1).

    0 = Private
    1 = Public

.PARAMETER sprint_duration
    Sprint duration in days for the project. Default is 14.

.PARAMETER custom_fields
    Key value pairs containing the names and values of custom fields.


.PARAMETER Archive
    Archive the project.

.EXAMPLE
    Set-FreshServiceProject -id 1000320954 -priority 3

    id              : 1000320954
    name            : Project 1e49df30-7850-4a5b-a9b0-aefafdac192b
    key             : P667977
    description     : Project 1e49df30-7850-4a5b-a9b0-aefafdac192b
    status_id       : 2
    priority_id     : 3
    sprint_duration : 14
    project_type    : 1
    start_date      : 2023-04-23
    end_date        : 2023-05-03
    archived        : False
    visibility      : 1
    manager_id      : 21000418005
    created_at      : 4/24/2023 3:47:13 PM
    updated_at      : 4/24/2023 3:47:16 PM
    custom_fields   :

    Update a Freshservice Project status.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceProject {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique identifier of the project.',
            ValueFromPipelineByPropertyName = $true,
            Position = 0
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the project. The maximum number of characters allowed is 255.',
            ParameterSetName = 'default',
            ValueFromPipelineByPropertyName = $true,
            Position = 1
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the project in plain text or HTML format.',
            ParameterSetName = 'default',
            ValueFromPipelineByPropertyName = $true,
            Position = 2
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Project Key. The key should start with a letter followed by a combination of letters, numbers or both. The maximum length is 10 characters.',
            ParameterSetName = 'default',
            ValueFromPipelineByPropertyName = $true,
            Position = 3
        )]
        [string]$key,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the project.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [ValidateRange(1,3)]
        [int]$status_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Priority of the project. Default is Medium.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [ValidateRange(1,4)]
        [int]$priority_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the project manager.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [long]$manager_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Start date of the project. The acceptable format is yyyy-mm-dd.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7
        )]
        [datetime]$start_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'End date of the project. The acceptable format is yyyy-mm-dd.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [datetime]$end_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Visibility of the project - Public / Private. Default is Public.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 9
        )]
        [ValidateRange(0,1)]
        [int]$visibility,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Sprint duration in days for the project.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 10
        )]
        [int]$sprint_duration,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields. Read more here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 11
        )]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Archive a project.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Archive',
            Position = 1
        )]
        [switch]$Archive
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $Method = 'PUT'
        $uri = [System.UriBuilder]('{0}/pm/projects' -f $PrivateData['FreshserviceBaseUri'])

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
        }

        if ($PSBoundParameters.ContainsKey('archive')) {
            $uri.Path = "{0}/archive" -f $uri.Path
            $Method = 'POST'
            [void]$PSBoundParameters.Remove('archive')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ($PSBoundParameters[$PSItem] -is [datetime]) {
                $jsonBody[$PSItem.ToLower()] = Get-Date -Date $PSBoundParameters[$PSItem] -Format "yyyy-MM-dd"
            }
            else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = $Method
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                if ($Archive) {

                    [PSCustomObject]@{
                        id = $id
                        status = "success {0}" -f $result.StatusCode
                    }

                }
                else {

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
        }
        catch {
            Throw $_
        }

    }
    end {}
}
