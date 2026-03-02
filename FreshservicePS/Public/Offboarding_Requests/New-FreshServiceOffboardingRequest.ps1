<#
.SYNOPSIS
    Creates Freshservice Offboarding Request and returns the parent ticket id.

.DESCRIPTION
    Creates Freshservice Offboarding Request via REST API.
    https://api.freshservice.com/#create_offboarding_request

.PARAMETER EmployeeName
    String value of the Employee Name for populating in the resulting Offboarding Request title & Preferred Name fiel.
.PARAMETER EmployeeEmail
    String value of the Employee Email address.
.PARAMETER ManagerEmail
    String value of the Manager Email address.
.PARAMETER LastWorkingDate
    Datetime value of the last working date & time for the offboard. Will be converted to UTC.
.PARAMETER OtherValues
    Hashtable containing any additional Offboarding Request custom fields.

.EXAMPLE
    $otherValues = @{
        cf_job_title            = "Test Job Title"
        cf_department_code      = "100"
        cf_product_code         = "1001"
    }

    New-FreshServiceOffboardingRequest -EmployeeEmail employee@test.com -ManagerEmail Manager@test.com -otherValues $OtherValues

    id            : 9
    created_at    : 2025-02-06T22:04:05Z
    updated_at    : 2025-02-06T22:04:05Z
    status        : 1
    requester_id  : 20002716282
    subject       : Employee Offboarding Request
    ticket_id     :
    actors        : @{HR Manager=}
    fields        : @{cf_employee_type=Employee; cf_first_name=TestFirstname; cf_new_hire_first_and_last_name=TestLastName; cf_date_of_joining=06-02-2025; cf_job_title=Test Job Title; cf_department_code=100; cf_product_code=1001;}
    lookup_values :

    Create a new Freshservice Offboarding Request.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceOffboardingRequest {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory = $true)][string]$EmployeeName,
        [Parameter(Mandatory = $true)][string]$EmployeeEmail,
        [Parameter(Mandatory = $true)][string]$ManagerEmail,
        [Parameter(Mandatory = $true)][datetime]$LastWorkingDate,
        [Parameter(Mandatory = $false)][hashtable]$OtherValues
    )
    $PrivateData = $MyInvocation.MyCommand.Module.PrivateData
    if (!$PrivateData.FreshserviceBaseUri) {
        throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
    }

    $uri = [System.UriBuilder]('{0}/offboarding_requests' -f $PrivateData['FreshserviceBaseUri'])
    $requestBody = @{
        fields = @{
            cf_employee_name                                                = $EmployeeName
            cf_employee_preferred_name                                      = $EmployeeName
            cf_employee_email                                               = $EmployeeEmail
            cf_direct_manager                                               = $ManagerEmail
            cf_last_working_date_and_time_day_time_for_account_deactivation = (Get-Date $LastWorkingDate).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssK')
        }
    }

    if ($OtherValues) { $OtherValues.GetEnumerator() | ForEach-Object { $requestBody.fields.Add($_.Key, $_.Value) } }
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
                $OffboardRequest = $content."$($objProperty)"
                Write-Verbose -Message ("Created Offboarding Request with ID {0}" -f $OffboardRequest.id)
                Write-Verbose -Message ("Getting Offboarding Request {0} Parent Ticket" -f $OffboardRequest.id)
                $timer = [system.Diagnostics.stopwatch]::StartNew()
                do {
                    Start-Sleep 1 #loop for 30 seconds here while we wait for FS to create any child tickets
                    $OffboardingTickets = Get-FreshServiceOffboardingRequest -id $OffboardRequest.id -tickets -ErrorAction Stop
                } while (!$OffboardingTickets -and $timer.Elapsed.Seconds -lt 30)

                if ($OffboardingTickets) {
                    $ParentTicket = $OffboardingTickets | Where-Object parent -EQ $true
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
