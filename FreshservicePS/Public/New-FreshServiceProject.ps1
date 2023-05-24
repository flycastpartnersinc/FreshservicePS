<#
.SYNOPSIS
    Creates Freshservice project.

.DESCRIPTION
    Creates Freshservice project via REST API.

    https://api.freshservice.com/#create_a_project_newgen

    Note: Only users with "View or Manage Projects" privilege can access this API endpoint.

.PARAMETER name
    Name of the project. The maximum number of characters allowed is 255.

.PARAMETER description
    Description of the project in plain text or HTML format.

.PARAMETER key
    Project Key. The key should start with a letter followed by a combination of letters, numbers or both. The maximum length is 10 characters.

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
    User ID of the project manager. The default value is of the person creating the project.

.PARAMETER start_date
    Start date of the project. The acceptable format is yyyy-mm-dd. The default value is the project creation date.

.PARAMETER end_date
    End date of the project. The acceptable format is yyyy-mm-dd. The default value is the project creation date + 10 days.

.PARAMETER visibility
    Visibility of the project. Default is Public (1).

    0 = Private
    1 = Public

.PARAMETER sprint_duration
    Sprint duration in days for the project. Default is 14.

.PARAMETER custom_fields
    Key value pairs containing the names and values of custom fields. Read more here.

.EXAMPLE
    New-FreshServiceProject -name 'My New Project' -description 'New project to fix stuff' -project_type 1 -start_date (Get-Date)

    id              : 1000320978
    name            : My New Project
    key             : MNP
    description     : New project to fix stuff
    status_id       : 1
    priority_id     : 2
    sprint_duration : 14
    project_type    : 1
    start_date      : 2023-04-23
    end_date        : 2023-05-03
    archived        : False
    visibility      : 1
    manager_id      : 21000418005
    created_at      : 4/24/2023 4:27:39 PM
    updated_at      : 4/24/2023 4:27:39 PM
    custom_fields   :

    Creates a new Freshservice Project.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceProject {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the project. The maximum number of characters allowed is 255.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the project in plain text or HTML format.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Project Key. The key should start with a letter followed by a combination of letters, numbers or both. The maximum length is 10 characters.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$key,
        # [Parameter(
        #     Mandatory = $false,
        #     HelpMessage = 'Priority of the project. The default priority is 2 (Medium).',
        #     ValueFromPipelineByPropertyName = $true
        # )]
        # [ValidateRange(1,3)]
        # [int]$status_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Priority of the project. The default priority is 2 (Medium).',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,4)]
        [int]$priority_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Type of the Project - 1 (Business) or 2 (Software).',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0,1)]
        [int]$project_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the project manager. The default value is of the person creating the project.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$manager_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Start date of the project. The acceptable format is yyyy-mm-dd. The default value is the project creation date',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$start_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'End date of the project. The acceptable format is yyyy-mm-dd. The default value is the project creation date + 10 days.',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$end_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Visibility of the project - Public / Private. Default is Public.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0,1)]
        [int]$visibility,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Sprint duration in days for the project. The default value is 14.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$sprint_duration,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$custom_fields

    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/pm/projects' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

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
