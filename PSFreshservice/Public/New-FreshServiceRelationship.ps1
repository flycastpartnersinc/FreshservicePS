<#
.SYNOPSIS
    Creates Freshservice Relationship.

.DESCRIPTION
    Creates Freshservice Relationship via REST API..

    https://api.freshservice.com/#create_relationships

.PARAMETER relationship_item
    Object containing the relationship items to process. Helper function New-FreshServiceRelationshipItem
    can be used to create records based on documentation here: https://api.freshservice.com/#create_relationships

.EXAMPLE
    Create a new FreshService Relationship.

    PS C:\PSFreshservice>

    $newFreshServiceRelationshipItemSplat = @{
        relationship_type_id = 21000356921 #Get-FreshServiceRelationshipType
        primary_id           = 42
        primary_type         = 'asset'
        secondary_id         = 41
        secondary_type       = 'asset'
    }

    $relationship_item = New-FreshServiceRelationshipItem @newFreshServiceRelationshipItemSplat

    $newFreshServiceRelationship = New-FreshServiceRelationship -relationship_item $relationship_item

    $newFreshServiceRelationship

    job_id                               href                                                                               relationship_items
    ------                               ----                                                                               ------------------
    bce1461a-617d-938a-bb73-87d46525e2fc https://its-fine.freshservice.com/api/v2/jobs/bce1461a-617d-938a-bb73-87d46525e2fc @{secondary_type=asset; secondary_id=41;...

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceRelationship {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Object containing the relationship items'
        )]
        [Alias('ri')]
        [object[]]$relationship_item
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/relationships/bulk-create' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $body = ([pscustomobject]@{'relationships' = @($relationship_item)})

        try {

            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
                    Body        = ($body | ConvertTo-Json)
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json -Depth 5

            }

        }
        catch {
            Throw $_
        }

    }
    end {
        if ($content) {

            $content |
                Select-Object -Property *,
                                        @{Name='relationship_items';Expression={$relationship_item}}

        }

    }
}
