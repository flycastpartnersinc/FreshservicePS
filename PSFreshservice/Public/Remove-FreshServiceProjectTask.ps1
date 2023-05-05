<#
.SYNOPSIS
    Delete a Freshservice Project Task.

.DESCRIPTION
    Delete a Freshservice Project Task via REST API.

    https://api.freshservice.com/#delete_a_project_task_newgen

.PARAMETER id
    Unique id of the Freshservice Project.

.PARAMETER project_id
    Unique id of the Project Task.

.EXAMPLE
    Remove-FreshServiceProjectTask -Id 1004523593 -project_id 1000320954

            id project_id status
            -- ---------- ------
    1004523593 1000320954 success 204

    Delete a Freshservice Project Task. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceProjectTask {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Project',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [long]$project_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Project Task.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [Alias('task_id')]
        [long]$Id
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/pm/projects' -f $PrivateData['FreshserviceBaseUri'])

        if ($PSBoundParameters.ContainsKey('project_id')) {
            $uri.Path = "{0}/{1}/tasks" -f $uri.Path, $project_id
            [void]$PSBoundParameters.Remove('Project_id')
        }

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'DELETE'
                    ErrorAction = 'Stop'
                }

                $results = Invoke-FreshworksRestMethod @params

                [PSCustomObject]@{
                    id         = $id
                    project_id = $project_id
                    status     = "success {0}" -f $results.StatusCode
                }

            }

        }
        catch {
            Throw $_
        }

    }
    end {}
}
