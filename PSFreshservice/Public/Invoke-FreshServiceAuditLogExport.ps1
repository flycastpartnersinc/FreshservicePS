<#
.SYNOPSIS
    Invokes an export of the Freshservice Audit Log.

.DESCRIPTION
    Invokes an export of the Freshservice Audit Log via REST API.

    https://api.freshservice.com/#audit-logs

.PARAMETER since
    Timestamp from which the logs are needed.

.PARAMETER before
    Timestamp to which the logs are needed.

.PARAMETER type
    Denotes the type of module:

    account
    agent
    group
    change_field
    change_lifecycle
    sandbox_job
    sla_policy
    workflow
    plans & billing

.PARAMETER actor
    Id of the agent who performed the changes.

.PARAMETER workflow_id
    Id of the workflow.

.PARAMETER sla_policy_id
    Id of the sla policy.

.PARAMETER change_lifecycle_id
    Id of the change lifecycle.

.PARAMETER group_id
    Id of the Group.

.PARAMETER agent_id
    Id of the Agent.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Invoke-FreshServiceAuditLogExport -since (Get-Date -Date (Get-Date).AddDays(-5)) -before (Get-Date)

    Your export is on its way. It will be in rob.simmers@flycastpartners.com's inbox soon

    Request audit log email export for last 5 days.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Invoke-FreshServiceAuditLogExport {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Timestamp from which the logs are needed.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [datetime]$since,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Timestamp to which the logs are needed.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [datetime]$before,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Type of module.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [ValidateSet('account','agent','group','change_field','change_lifecycle','sandbox_job','sla_policy','workflow','plans & billing')]
        [string[]]$type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the agent who performed the changes.',
            ParameterSetName = 'default',
            Position = 3
        )]
        [long]$actor,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the workflow.',
            ParameterSetName = 'default',
            Position = 4
        )]
        [long]$workflow_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the sla policy.',
            ParameterSetName = 'default',
            Position = 5
        )]
        [long]$sla_policy_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the change lifecycle.',
            ParameterSetName = 'default',
            Position = 6
        )]
        [long]$change_lifecycle_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the group.',
            ParameterSetName = 'default',
            Position = 7
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the agent.',
            ParameterSetName = 'default',
            Position = 8
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/audit_log/export' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $filters = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
             if ($PSBoundParameters[$PSItem] -is [datetime]) {
                $jsonBody[$PSItem.ToLower()] = Get-Date -Date $PSBoundParameters[$PSItem] -Format 'yyyy-MM-ddTH:mm:ssZ'
             }
             else {
                #Build the filter criteria
                $theKey = $PSItem.ToLower()
                switch ($theKey) {
                    'type' {
                        $filters.Add($PSItem.ToLower(),@($PSBoundParameters[$PSItem]))
                    }
                    default {
                        $filters.Add($PSItem.ToLower(),$PSBoundParameters[$PSItem])
                    }
                }
             }
        }

        $jsonBody.Add('filters', $filters)

        try {
            $params = @{
                Uri         = $uri.Uri.AbsoluteUri
                Method      = 'POST'
                Body        = $jsonBody | ConvertTo-Json
                Headers     = @{'Accept'='application/json'}
                ErrorAction = 'Stop'
            }

            $result = Invoke-FreshworksRestMethod @params

            $content = $result.Content |
                             ConvertFrom-Json

            #  if ($content) {
            #      #API returns singluar or plural property based on the number of records, parse to get property returned.
            #      $objProperty = $content[0].PSObject.Properties.Name
            #      Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
            #      $content."$($objProperty)"
            #  }

            $content
        }
        catch {
            Throw $_
        }
    }
    end {}
}
