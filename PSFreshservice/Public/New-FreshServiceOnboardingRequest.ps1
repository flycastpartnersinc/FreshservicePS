<#
.SYNOPSIS
    Creates Freshservice Onboarding Request.

.DESCRIPTION
    Creates Freshservice Onboarding Request via REST API.

    https://api.freshservice.com/#create_onboarding_request

.PARAMETER fields
    Hashtable containing the Onboarding Request fields.

.EXAMPLE
    New-FreshServiceOnboardingRequest -fields $fields

    id            : 10
    created_at    : 4/12/2023 3:02:11 AM
    updated_at    : 4/12/2023 3:02:11 AM
    status        : 1
    requester_id  : 21001931878
    subject       : Employee Onboarding Request
    ticket_id     :
    actors        : @{Employee=}
    fields        : @{cf_employee_name=Frank Johnson; cf_job_title=Analyst I; cf_date_of_joining=11-04-2023;
                    cf_department=21000097763; cf_location=21000159890}
    lookup_values : @{cf_department=; cf_location=}

    Create a new Freshservice Onboarding Request.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceOnboardingRequest {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the software.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$fields
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/onboarding_requests' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

    }
    end {
        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
                    Body        =  $jsonBody | ConvertTo-Json #[PSCustomObject]@{application_users = $newRecords} | ConvertTo-Json
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
}
