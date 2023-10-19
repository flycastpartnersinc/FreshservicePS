<#
.SYNOPSIS
    Creates a new Freshservice connection.

.DESCRIPTION
    Creates a new Freshservice connection and stores it in a configuration file %APPDATA%\FreshservicePS\FreshservicePS.config. Freshservice is a session-less API, the settings created with this cmdlet are used as
    global variables for function\cmdlet execution in the module.

    Note: The API Key is encrypted using Powershell encyption, which requires decryption by the same user and machine the encryption occured with.  This configuration will only work on the same machine\same user.

.PARAMETER Name
    Friendly name of the configuration being saved.  This is what will be referenced with the Connect-FreshService cmdlet.  For instance,
    if this was the configuration for the production service account for Acme, you could do Acme_Prod.  If no name is provided, default is the tenant name.

.PARAMETER ApiKey
    API Key name of the environment.  This value is stored encypted in the configuration file. The API Key is encrypted using Powershell encyption, which requires decryption by the same user and machine the encryption occured with.
    This configuration will only work on the same machine\same user.

.PARAMETER Tenant
    The name of the Freshservice tenant. For example, if the url was https://acmecorp.freshservice.com would be tenant "acmecorp".

.PARAMETER EmailAddress
    Email address of the user for the API key. This is not mandatory, but is simply for reference to know who the API key is linked to.

.PARAMETER Environment
    The type of environment this configuration will connect to, Production or Sandbox. This builds the url for the Freshservice tenant:

    Production =  https://TENANT.freshservice.com/api/v2
    Sandbox    =  https://TENANT-fs-sandbox.freshservice.com/api/v2

.PARAMETER Default
    Setting Default to $true will automatically connect to this tenant during module import. If no default is set, Connect-FreshService will need to be executed after module import to establish variables.

.EXAMPLE
    New-FreshServiceConnection -Tenant 'acme-corp' -ApiKey 'd8werre9whw9fhwe9we'

    Name         : acme
    ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000008d165ed92b4f54b17914ff7a7b310584a63f994655b4902a43acc5923ba7ce8d000000000e8000000002000020000000d2f87099660baffe819ba17f9376db4072427dd6a7ae8adc05ac916c0d38be3c30000
                0004a2510e4b9c34b47c44e1e23d187e92897c1880d3979e1b08d115a7e438a79b11b905166ecd165cc3247a2ea8762f1d440000000531a8820dbd5df4424f33761db4e743590b872fb34917cde887136dde71aec21f49dd5ede02259770e726030ff6647b70b69730e5dd1fdcaba4c86f640cf2076
    Tenant       : acme-corp
    BaseUri      : https://acme-corp.freshservice.com/api/v2
    EmailAddress : john.smith@acme-corp.com
    Environment  : Production
    Default      : True

    Create a new basic Freshservice connection configuration.  Initial configuration will be set as the default instance to connect when the module.

.EXAMPLE
    New-FreshServiceConnection -Name acme -ApiKey 'd8werre9whw9fhwe9we' -Tenant 'acme-corp' -Environment Production -Email 'john.smith@acme-corp.com' -Default

    Name         : acme
    ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000008d165ed92b4f54b17914ff7a7b310584a63f994655b4902a43acc5923ba7ce8d000000000e8000000002000020000000d2f87099660baffe819ba17f9376db4072427dd6a7ae8adc05ac916c0d38be3c30000
                0004a2510e4b9c34b47c44e1e23d187e92897c1880d3979e1b08d115a7e438a79b11b905166ecd165cc3247a2ea8762f1d440000000531a8820dbd5df4424f33761db4e743590b872fb34917cde887136dde71aec21f49dd5ede02259770e726030ff6647b70b69730e5dd1fdcaba4c86f640cf2076
    Tenant       : acme-corp
    BaseUri      : https://acme-corp.freshservice.com/api/v2
    EmailAddress : john.smith@acme-corp.com
    Environment  : Production
    Default      : True

    Create a new Freshservice connection configuration.  Default will automatically connect with these settings during module import.

.EXAMPLE
    New-FreshServiceConnection -Name acme_sbx -ApiKey 'd8werre9whw9fhwe9we' -Tenant 'acme-corp' -Environment Sandbox -Email 'john.smith@acme-corp.com'

    Name         : acme_sbx
    ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000008d165ed92b4f54b17914ff7a7b310584a63f994655b4902a43acc5923ba7ce8d000000000e8000000002000020000000d2f87099660baffe819ba17f9376db4072427dd6a7ae8adc05ac916c0d38be3c30000
                0004a2510e4b9c34b47c44e1e23d187e92897c1880d3979e1b08d115a7e438a79b11b905166ecd165cc3247a2ea8762f1d440000000531a8820dbd5df4424f33761db4e743590b872fb34917cde887136dde71aec21f49dd5ede02259770e726030ff6647b70b69730e5dd1fdcaba4c86f640cf2076
    Tenant       : acme-corp
    BaseUri      : https://acme-corp-fs-sandbox.freshservice.com/api/v2
    EmailAddress : john.smith@acme-corp.com
    Environment  : Sandbox
    Default      : False

    Create a Freshservice connection configuration for a Sandbox environment.  Use Connect-Freshservice to switch connections from Prod to Sandbox (e.g. Connect-FS -Name acme vs Connect-FS -Name acme_sbx).

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceConnection {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Friendly name of the environment. For example, if tenant was https://acmecorp.freshservice.com, could be "acmecorp_prod" or if creating a Sandbox config "acmecorp_sandbox". Default is tenant name.'
        )]
        [ValidatePattern('^[A-Za-z0-9_@.-]*$')]
        [string]$Name,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'The users API Key for the Freshservice instance.'
        )]
        [string]$ApiKey,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Tenant name. For example https://acmecorp.freshservice.com would be tenant "acmecorp".'
        )]
        [Alias('ComputerName','Instance')]
        [string]$Tenant,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email address of the user for the API key. This is not mandatory, but is simply for reference to know who the API key is linked to.'
        )]
        [string]$EmailAddress,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The type of environment this configuration will connect to, Production or Sandbox.'
        )]
        [ValidateSet('Production','Sandbox')]
        [string]$Environment = 'Production',
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Connect to this environment as default.  There can be only one.'
        )]
        [switch]$Default
    )
    begin {

        #Lookup to build api path for Sandbox or Production
        $environmentLookup = @{
            'Production' =  ('https://{0}.freshservice.com/api/v2' -f $Tenant)
            'Sandbox'    =  ('https://{0}-fs-sandbox.freshservice.com/api/v2' -f $Tenant )
        }

    }
    process {
        if (!$PSBoundParameters['Name']) {$PSBoundParameters['Name'] = $PSBoundParameters['Tenant']}
        Write-Verbose -Message ('Working on configuration for {0}.' -f $PSBoundParameters['Name'])

        try {
            $environments = @()

            $newEnvironment = [PSCustomObject]@{
                Name         = $PSBoundParameters['Name']
                ApiKey       = ($PSBoundParameters['ApiKey'] | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString)
                Tenant       = $PSBoundParameters['Tenant']
                BaseUri      = $environmentLookup[$Environment]
                EmailAddress = $PSBoundParameters['EmailAddress']
                Environment  = $Environment
                Default      = if ($PSBoundParameters.ContainsKey('Default')) {$true} else {$false}
            }

            if ($PSCmdlet.ShouldProcess($PSBoundParameters['Name'])) {
                if ( Test-Path -Path $FreshServiceConfigPath ) {

                    $environments += Get-FreshServiceConnection -ErrorAction Stop
                    Write-Verbose -Message ('Importing {0} existing environments in {1}.' -f $environments.Count,$FreshServiceConfigPath)

                    if ($environments | Where-Object -FilterScript {$_.Name -eq $Name}) {
                        Write-Warning -Message ("Configuration named {0} already exists.  Use Set-FreshServiceConnection to update an existing configuration!" -f $PSBoundParameters['Name'])
                        throw ("Configuration named {0} already exists.  Use Set-FreshServiceConnection to update an existing configuration!" -f $PSBoundParameters['Name'])
                    }

                }
                else {
                    #Create Config File and Path
                    $null = New-Item -Path $FreshServiceConfigPath -ItemType File -Force -ErrorAction Stop
                }

                Write-Verbose -Message ('No configuration name {0} exists, adding new configuration.' -f $PSBoundParameters['Name'])
                #There can be only one...default
                if ($environments.Count -gt 0 -and ($Default -eq $true)) {
                    ForEach ($envt in $environments) {
                        Write-Verbose ('Setting {0} to Default = $false' -f $envt.Name)
                        $envt.Default = $false
                    }
                }

                if ($newEnvironment) {
                    if ($environments.Count -eq 0) {
                        Write-Verbose -Message ('{0} is detected as the initial profile.' -f $newEnvironment.Name)
                        $initialProfile = $true
                        $newEnvironment.Default = $true
                    }

                    Write-Verbose -Message ('Adding new environment to object {0}.' -f $FreshServiceConfigPath)
                    #Add the new config to the object
                    $environments += $newEnvironment

                    #Save the config
                    $environments |
                        Export-Clixml -LiteralPath $FreshServiceConfigPath -ErrorAction Stop -Force

                    Write-Verbose -Message ('Successfully updated configuration in {0} with {1} configurations.' -f $FreshServiceConfigPath, $environments.Count)
                }
            }
        }
        catch {
            Throw 'Unable to create configuration file {0}. {1}' -f $FreshServiceConfigPath, $_
        }

    }
    end {

        $newEnvironment

        if ($initialProfile -eq $true) {
            Connect-Freshservice -Name $newEnvironment.Name
        }

    }
}
