<#
.SYNOPSIS
    Adds a Freshservice Requester to a Requester Group.

.DESCRIPTION
    Adds a Freshservice Requester to a Requester Group via REST API.

    https://api.freshservice.com/#add_member_to_requester_group

.PARAMETER id
    Unique Id of the requester group.

.PARAMETER requester_id
    Unique Id of the requester.

.EXAMPLE
    Add-FSRequesterGroupMember -id 21000137988 -requester_id 21001799737

    id status
    -- ------
    21000137988 success 200

    Adds a Freshservice Requester to a Requester Group.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Add-FreshServiceRequesterGroupMember {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('requester_group_id')]
        [long]$id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$requester_id
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/requester_groups' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        if ($id) {
            Write-Verbose ("Processing Id")
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('id')
        }

        if ($requester_id) {
            Write-Verbose ("Processing Requester Id")
            $uri.Path = "{0}/members/{1}" -f $uri.Path, $requester_id
            [void]$PSBoundParameters.Remove('requester_id')
        }

        try {
            $params = @{
                Uri         = $uri.Uri.AbsoluteUri
                Method      = 'POST'
                ErrorAction = 'Stop'
            }

            $result = Invoke-FreshworksRestMethod @params

            [PSCustomObject]@{
                id     = $id
                status = "success {0}" -f $result.StatusCode
            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
