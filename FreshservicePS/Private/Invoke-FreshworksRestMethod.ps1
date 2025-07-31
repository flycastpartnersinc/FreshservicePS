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
            This is where the Invoke-RestMethod is called for all FreshservicePS cmdlets.  This is the only
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
            $Body,
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
            [string]$ContentType = 'application/json; charset=utf-8',
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
            $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

            if ( $MyInvocation.MyCommand.Module.PrivateData['FreshserviceApiToken'] ) {
                Write-Verbose 'Appending Authorization header'
                if (!$Headers){$Headers = @{}}
                # if ($Headers) {
                    $Headers.Add( "Accept-Charset" , "utf-8" )
                    $Headers.Add( "Authorization", ("Basic {0}" -f $AuthorizationToken) )
                # }
                # else {
                # $Headers = @{"Authorization" = ("Basic {0}" -f $AuthorizationToken)}
                # }
            }
            else {
                Write-Warning -Message ('Connection settings must be set with Set-FreshWorksConnectionSettings before making Freshworks API calls')
                break
            }

        } #begin
        process {
            Write-Verbose -Message ('{0} - Initiating REST API call to {1} with API key:  {2}' -f $MyInvocation.MyCommand.Name, $Uri, $AuthorizationToken)

            $restParams = @{
                Uri             = $Uri
                Method          = $Method
                Headers         = $Headers
                UseBasicParsing = $true #Backwards compatibility for versions before PS 6.0. Github Issue #5
                ErrorAction     = 'Stop'
            }


            #Support for ServerCore, requires BasicParsing. Get-ComputerInfo is avoided due to performance each time the cmdlet is called.
            if((Get-ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion" InstallationType).InstallationType -eq "Server Core"){
                $restParams.Add('UseBasicParsing', $true)
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

            Write-Verbose -Message ('{0} - Invoking REST {1} Method on {2}...' -f $MyInvocation.MyCommand.Name, $Method, $Uri)
            try {
                # Force TLS 1.2 protocol. Invoke-RestMethod uses 1.0 by default
                Write-Verbose -Message ('{0} - Forcing TLS 1.2 protocol for invoking REST method.' -f $MyInvocation.MyCommand.Name)
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

                $results = Invoke-WebRequest @restParams
                Write-Verbose -Message ('Returned status {0} with code {1}.' -f $results.StatusDescription, $results.StatusCode)
                $rateTotal = $results.Headers['X-Ratelimit-Total'][0]
                $rateRemaining = $results.Headers['X-Ratelimit-Remaining'][0]

                If ($rateTotal -gt 0 -and $rateRemaining -gt 0) {
                    $pctRateUsed = [math]::Round(($rateTotal-$rateRemaining)/$rateTotal * 100, 2)
                    Write-Verbose -Message ('Current FreshService minute rate limit is {0} with {1} calls remaining ({2}% used) .' -f $rateTotal, $rateRemaining,$pctRateUsed)

                    if ($PrivateData.FreshserviceThrottling -eq $true) {
                        # The API rate limit is applied on an account wide basis irrespective of factors such as
                        # the number of agents or IP addresses used to make the calls.  There are numerous API calls that can consume multiple API calls
                        # for single get operations (e.g. Get-FSAsset -IncludeTypeFields = 3 API credits for each call). Throttling will slow
                        # the API calls down ggadually the closer the query gets to consuming all calls forcing a 429 Retry-After which affects all API
                        # calls to the account.

                        if ($pctRateUsed -ge 70.00) {
                            switch ($pctRateUsed) {
                                {$PSItem -ge 70.00} {$sleepInSecs = 5}
                                {$PSItem -ge 80.00} {$sleepInSecs = 15}
                                {$PSItem -ge 90.00} {$sleepInSecs = 30}
                            }

                            Write-Warning -Message ('Executing {0}. FreshService API minute rate limit above 70% threshold with {1} total calls available and {2} calls remaining ({3}% used). Artificially slowing calls by {4} second. See Connect-Freshservice for options.' -f $uri, $rateTotal, $rateRemaining,$pctRateUsed,$sleepInSecs)
                            Start-Sleep -Seconds $sleepInSecs
                        }
                    }
                }

            }
            catch {
                $ex = $_
                Write-Verbose -Message ("Catching exception {0} with status code {1}" -f $ex.Exception.GetType().FullName, $ex.Exception.Response.value__)
                switch ($ex.Exception.Response.StatusCode.value__) {
                    '429' {
                        [int]$sleepInSecs = $ex.Exception.Response.Headers.GetValues('Retry-After')[0]
                        Write-Warning -Message ('API rate limit reached. Automatically sleeping for {0} seconds.' -f $sleepInSecs)
                        Write-Verbose -Message ('API rate limit reached. Automatically sleeping for {0} seconds.' -f $sleepInSecs)
                        Start-Sleep -Seconds $sleepInSecs
                        # Create object schema to resend the header link to re-run last API call that terminated with 429
                        $results = [PSCustomObject]@{
                            Content = $null
                            Headers = @{
                                Link = '<{0}>' -f $uri
                            }
                        }

                    }
                    default {
                        Write-Verbose -Message ("Throwing Default exception of type {0}" -f $ex.Exception.GetType().FullName)
                        Throw $ex
                    }
                }

            }
        } #process
        end {
            Write-Verbose -Message ('{0} - Completed REST {1} Method on {2} in {3:c}.' -f $MyInvocation.MyCommand.Name, $Method, $uri, $stopwatch.Elapsed)
            $results
        } #end
    } #Invoke-FreshworksRestMethod
