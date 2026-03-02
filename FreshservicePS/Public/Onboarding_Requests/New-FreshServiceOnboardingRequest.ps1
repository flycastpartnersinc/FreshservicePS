<#
.SYNOPSIS
    Creates Freshservice Onboarding Request and returns the parent ticket id.

.DESCRIPTION
    Creates Freshservice Onboarding Request via REST API.
    https://api.freshservice.com/#create_onboarding_request

.PARAMETER EmployeeType
    String value of the Employee Type.
.PARAMETER FirstName
    String value of the First Name.
.PARAMETER LastName
    String value of the Last Name.
.PARAMETER StartDate
    Datetime value of the Start Date
.PARAMETER OtherValues
    Hashtable containing any additional Onboarding Request custom fields.

.EXAMPLE
    $otherValues = @{
        cf_job_title            = "Test Job Title"
        cf_department_code      = "100"
        cf_product_code         = "1001"
    }

    New-FreshServiceOnboardingRequest -FirstName $FirstName -LastName $LastName -EmployeeType $EmployeeType -StartDate -otherValues $OtherValues

    id            : 9
    created_at    : 2025-02-06T22:04:05Z
    updated_at    : 2025-02-06T22:04:05Z
    status        : 1
    requester_id  : 20002716282
    subject       : Employee Onboarding Request
    ticket_id     :
    actors        : @{HR Manager=}
    fields        : @{cf_employee_type=Employee; cf_first_name=TestFirstname; cf_new_hire_first_and_last_name=TestLastName; cf_date_of_joining=06-02-2025; cf_job_title=Test Job Title; cf_department_code=100; cf_product_code=1001;}
    lookup_values :

    Create a new Freshservice Onboarding Request.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceOnboardingRequest {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory = $true)][string]$EmployeeType,
        [Parameter(Mandatory = $true)][string]$FirstName,
        [Parameter(Mandatory = $true)][string]$LastName,
        [Parameter(Mandatory = $true)][string]$StartDate,
        [Parameter(Mandatory = $false)][string]$RequesterId,
        [Parameter(Mandatory = $false)][hashtable]$OtherValues
    )
    $PrivateData = $MyInvocation.MyCommand.Module.PrivateData
    if (!$PrivateData.FreshserviceBaseUri) {
        throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
    }

    $uri = [System.UriBuilder]('{0}/onboarding_requests' -f $PrivateData['FreshserviceBaseUri'])
    $requestBody = @{
        fields = @{
            cf_employee_type                = $EmployeeType
            cf_first_name                   = $FirstName
            cf_new_hire_first_and_last_name = $LastName
            cf_date_of_joining              = $StartDate
        }
    }

    if ($OtherValues) { $OtherValues.GetEnumerator() | ForEach-Object { $requestBody.fields.Add($_.Key, $_.Value) } }
    if ($RequesterId) { $requestBody.Add("requester_id", $RequesterId) }
    $requestBodyJSON = $requestBody | ConvertTo-Json -Depth 10
    if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {
        try {
            $params = @{
                Uri         = $uri.Uri.AbsoluteUri
                Method      = 'POST'
                ErrorAction = 'Stop'
                Body        = $requestBodyJSON
            }

            $result = Invoke-FreshworksRestMethod @params -AuthorizationToken $PrivateData.FreshserviceApiToken

            if ($result.Content) {
                $content = $result.Content | ConvertFrom-Json

                #API returns singluar or plural property based on the number of records, parse to get property returned.
                #When using Filter, the API also returns a Total property, so we are filtering here to only return ticket or tickets property
                $objProperty = $content[0].PSObject.Properties.Name
                Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                $OnboardRequest = $content."$($objProperty)"
                Write-Verbose -Message ("Created Onboarding Request with ID {0}" -f $OnboardRequest.id)
                Write-Verbose -Message ("Getting Onboarding Request {0} Parent Ticket" -f $OnboardRequest.id)
                $timer = [system.Diagnostics.stopwatch]::StartNew()
                do {
                    Start-Sleep 1 #loop for 30 seconds here while we wait for FS to create any child tickets
                    $OnboardingTickets = get-freshserviceonboardingrequest -id $OnboardRequest.id -tickets -ErrorAction Stop
                } while (!$OnboardingTickets -and $timer.Elapsed.Seconds -lt 30)

                if ($OnboardingTickets) {
                    $ParentTicket = $OnboardingTickets | Where-Object parent -EQ $true
                    Write-Verbose -Message ("Found Parent Ticket {0}" -f $ParentTicket.id)
                    $ParentTicket.id
                } else {
                    throw "Onboarding request $($OnboardRequest.id) created; Unable to retrieve parent ticket"
                }
            }
        } catch {
            throw $_
        }
    } else {
        $requestBody.fields | Out-String
    }
}
