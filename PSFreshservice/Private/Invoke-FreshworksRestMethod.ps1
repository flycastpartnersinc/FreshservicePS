function Invoke-FreshworksRestMethod {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    <#
        .SYNOPSIS
            Invoke a REST API call on Freshworks.

        .DESCRIPTION
            Invoke a REST API call on Freshworks. This is wrapper function for Invoke-WebRequest to
            define the authorization and perform other requirements (e.g. TLS) in a single function
            versus definition in each function.

        .PARAMETER AuthorizationToken
            The encoded Authorization Token provided by Freshworks.

        .PARAMETER Url
            The REST API URL that is being called.

        .PARAMETER Method
            The HTTP Method that is being used in the API call e.g. (HEAD, GET, POST, PATCH, or DELETE).

        .PARAMETER Body
            SOAP, JSON, XML or formatted body for passed in the API call.

        .PARAMETER ContentType
            Specified ContentType of the Body that is being passed (e.g. application\json).

        .EXAMPLE
            $params = @{
                Uri         = $uri
                Method      = 'GET'
                ErrorAction = 'Stop'
            }

            $result = Invoke-FreshworksRestMethod @params

            Performs a GET on a function defined URI.

        .NOTES
            This is where the Invoke-RestMethod is called for all PSFreshService cmdlets.  This is the only
            cmdlet that requires authentication data such as AuthorizationToken and settings
            to manipulate certificate security and TLS. This is a internal private function
    #>

        param (
            [Parameter(Mandatory = $False,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'Api Token for authenication with Freshworks REST API',
                       ParameterSetName = 'default',
                       Position = 0
            )]
            [Parameter(Mandatory = $False,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'Api Token for authenication with Freshworks REST API',
                       ParameterSetName = 'Form',
                       Position = 0
            )]
            [string]$AuthorizationToken = $MyInvocation.MyCommand.Module.PrivateData['FreshserviceApiToken'],
            [Parameter(Mandatory = $False,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'REST API Headers',
                       ParameterSetName = 'default',
                       Position = 1
            )]
            [Parameter(Mandatory = $False,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'REST API Headers',
                       ParameterSetName = 'Form',
                       Position = 1
            )]
            [hashtable]$Headers,
            [Parameter(Mandatory = $True,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'REST API Uri that is being requested',
                       ParameterSetName = 'default',
                       Position = 2
            )]
            [Parameter(Mandatory = $True,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'REST API Uri that is being requested',
                       ParameterSetName = 'Form',
                       Position = 2
            )]
            [string]$Uri,
            [Parameter(Mandatory = $True,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'REST Method being called',
                       ParameterSetName = 'default',
                       Position = 3
            )]
            [Parameter(Mandatory = $True,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'REST Method being called',
                       ParameterSetName = 'Form',
                       Position = 3
            )]
            [ValidateSet('DELETE', 'GET', 'PUT', 'POST','PATCH')]
            [string]$Method,
            [Parameter(Mandatory = $False,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'Message body',
                       ParameterSetName = 'default',
                       Position = 4
            )]
            [object[]]$Body,
            [Parameter(Mandatory = $False,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'ContentType of passed Body for REST header',
                       ParameterSetName = 'default',
                       Position = 5
            )]
            [Parameter(Mandatory = $False,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'ContentType of passed Body for REST header',
                       ParameterSetName = 'Form',
                       Position = 5
            )]
            [string]$ContentType = 'application/json',
            [Parameter(Mandatory = $False,
                       ValueFromPipelineByPropertyName = $True,
                       HelpMessage = 'Converts a dictionary to a multipart/form-data submission. Form may not be used with Body. If ContentType is used, it is ignored.',
                       ParameterSetName = 'Form',
                       Position = 6
            )]
            [Collections.IDictionary]$Form

        )
        begin {
            $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

            if ( $MyInvocation.MyCommand.Module.PrivateData['FreshserviceApiToken'] ) {
                Write-Verbose 'Appending Authorization header'
                if ($Headers) {
                    $Headers.Add( "Authorization", ("Basic {0}" -f $AuthorizationToken) )
                }
                else {
                    $Headers = @{"Authorization" = ("Basic {0}" -f $AuthorizationToken)}
                }
            }
            else {
                Write-Warning -Message ('Connection settings must be set with Set-FreshWorksConnectionSettings before making Freshworks API calls')
                break
            }

        } #begin
        process {
            Write-Verbose -Message ('{0} - Initiating REST API call to {1} with API key:  {2}' -f $MyInvocation.MyCommand.Name, $Uri, $AuthorizationToken)

            $restParams = @{
                Uri         = $Uri
                Method      = $Method
                Headers     = $Headers
                ErrorAction = 'Stop'
            }

            if ( $Body ) {
                $restParams.Add( 'Body', $Body )
            }

            if ($Form) {
                $restParams.Add('ContentType', 'multipart/form-data')
                $restParams.Add( 'Form', $Form )
            }
            else {
                $restParams.Add('ContentType', $ContentType)
            }

            Write-Verbose -Message ('{0} - REST call parameters:' -f $MyInvocation.MyCommand.Name)
            foreach ($param in $restParams.GetEnumerator()) {
                if ($param.Key -eq 'Headers') {
                    Write-Verbose -Message ('{0} - Headers:' -f $MyInvocation.MyCommand.Name)
                    foreach ($header in $param.Value.GetEnumerator()) {
                        Write-Verbose -Message ('{2} - {0}:  {1}' -f $header.Key, $header.Value, $MyInvocation.MyCommand.Name)
                    }
                }
                else {
                    #Skip the Body because we handled obfusfication above
                    Write-Verbose -Message ('{2} - {0}:  {1}' -f $param.Key, $param.Value, $MyInvocation.MyCommand.Name)
                }
            }

            Write-Verbose -Message ('{0} - Invoking REST {1} Method on {2}...' -f $MyInvocation.MyCommand.Name, $Method, $apiUri)
            try {
                # Force TLS 1.2 protocol. Invoke-RestMethod uses 1.0 by default
                Write-Verbose -Message ('{0} - Forcing TLS 1.2 protocol for invoking REST method.' -f $MyInvocation.MyCommand.Name)
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

                $results = Invoke-WebRequest @restParams
                Write-Verbose -Message ('Returned status {0} with code {1}.' -f $results.StatusDescription, $results.StatusCode)
                Write-Verbose -Message ('Current FreshService minute rate limit is {0} with {1} calls remaining.' -f ($results.Headers['X-Ratelimit-Total'][0]),($results.Headers['X-Ratelimit-Remaining'][0]))
            }
            catch [System.Net.WebException] {
                Write-Verbose -Message ("Catching System.Net.WebException of with status code {0}" -f $_.Exception.Response.StatusCode)
                switch ($_.Exception.Response.StatusCode) {
                    429 {
                        $sleepInSecs = $_.Exception.Response.Headers.GetValues('Retry-After')[0]
                        Write-Warning -Message ('Throttle Limit reached [ 429 ] Sleeping for [ {0} ] seconds.' -f $sleepInSecs)
                        Write-Verbose -Message ('Throttle Limit reached [ 429 ] Sleeping for [ {0} ] seconds.' -f $sleepInSecs)
                        Start-Sleep -Seconds $sleepInSecs
                    }
                    default {
                        Write-Verbose -Message ("Default System.Net.Exception with status code {0}" -f $_.Exception.Response.StatusCode)
                        Throw $_
                    }
                }

            }
            catch {
                Write-Verbose -Message ("Throwing Default exception of type {0}" -f $_.Exception.GetType().Name)
                $ex = $_

                Throw $ex

            }
        } #process
        end {
            Write-Verbose -Message ('{0} - Completed REST {1} Method on {2} in {3:c}.' -f $MyInvocation.MyCommand.Name, $Method, $apiUri, $stopwatch.Elapsed)
            $results
        } #end
    } #Invoke-FreshworksRestMethod
