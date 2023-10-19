<#
.SYNOPSIS
    Updates a Freshservice connection.

.DESCRIPTION
    Updates a Freshservice connection and stores it in a configuration file %APPDATA%\FreshservicePS\FreshservicePS.config. Freshservice is a session-less API, the settings created with this cmdlet are used as
    global variables for function\cmdlet execution in the module.

    Note: The API Key is encrypted using Powershell encyption, which requires decryption by the same user and machine the encryption occured with.  This configuration will only work on the same machine\same user.

.PARAMETER Name
    Friendly name of the configuration being saved.  This is what will be referenced with the Connect-FreshService cmdlet.  For instance,
    if this was the configuration for the production service account for Acme, you could do Acme_Prod.

.PARAMETER NewName
    The new name to rename the friendly name of this configuration.

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
    Set-FreshServiceConnection -Name acme -ApiKey 'goiureU89h98hhn9i8un'

    Name         : acme
    ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000007d6b0edd48041f1e0f8fb47cb760a57bbbc9479a686928278e8044c09cca5a13000000000e8000000002000020000000bb98d9971951f36853d81a4aab84e6cf2c8d0d34789d834fc1fe373870a4764930000
                000951d09207552e120eb4e64b3edb263d7988d67533d64137c85645ce3a9e99b4a204c9b434c68823b2eea1f99f662bb1c400000004e3cd039c10be12adbdee7a8bd683575df2dcd70c98e60751366cf0332c9e69eecc29db7bbfc0e6e9a135fb8d0c155c2f96364bfbadda7dd7f29283d42322f2d
    Tenant       : acme-corp
    BaseUri      : https://acme-corp.freshservice.com/api/v2
    EmailAddress : john.smith@acme-corp.com
    Environment  : Production
    Default      : True

    Update a Freshservice connection configuration with a new API key.

.EXAMPLE
    Set-FreshServiceConnection -Name acme -NewName acme_prod

    Name         : acme_prod
    ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000007d6b0edd48041f1e0f8fb47cb760a57bbbc9479a686928278e8044c09cca5a13000000000e8000000002000020000000bb98d9971951f36853d81a4aab84e6cf2c8d0d34789d834fc1fe373870a4764930000
                000951d09207552e120eb4e64b3edb263d7988d67533d64137c85645ce3a9e99b4a204c9b434c68823b2eea1f99f662bb1c400000004e3cd039c10be12adbdee7a8bd683575df2dcd70c98e60751366cf0332c9e69eecc29db7bbfc0e6e9a135fb8d0c155c2f96364bfbadda7dd7f29283d42322f2d
    Tenant       : acme-corp
    BaseUri      : https://acme-corp.freshservice.com/api/v2
    EmailAddress : john.smith@acme-corp.com
    Environment  : Production
    Default      : True

    Update a Freshservice connection configuration with a new friendly name. Then connecting to the environment would be Connect-Freshservice -Name acme_prod

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceConnection {
    [OutputType('System.Object[]')]
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Friendly name of the environment',
            ValueFromPipelineByPropertyName = $true,
            Position = 0
        )]
        [ArgumentCompleter({
            param ($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)
            if (Test-Path -Path $FreshServiceConfigPath) {
                Get-FreshServiceConnection |
                    Where-Object -FilterScript { $_.Name -like "*$WordToComplete*" } |
                        Select-Object -ExpandProperty Name
            }
        })]
        [ValidatePattern('^[A-Za-z0-9_@.-]*$')]
        [string]$Name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'New Friendly name of the environment',
            ValueFromPipelineByPropertyName = $true,
            Position = 1
        )]
        [ValidatePattern('^[A-Za-z0-9_@.-]*$')]
        [string]$NewName,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'API Key of the environment',
            ValueFromPipelineByPropertyName = $true,
            Position = 2
        )]
        [string]$ApiKey,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Tenant name. Example https://acmecorp.freshservice.com would be tenant acmecorp',
            ValueFromPipelineByPropertyName = $true,
            Position = 3
        )]
        [Alias('ComputerName','Instance')]
        [string]$Tenant,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email Address of the API Key user',
            ValueFromPipelineByPropertyName = $true,
            Position = 4
        )]
        [string]$EmailAddress,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Type of environment. Sandbox or Production. Used to generate base uri.',
            ValueFromPipelineByPropertyName = $true,
            Position = 5
        )]
        [ValidateSet('Production','Sandbox')]
        [string]$Environment,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Connect to this environment as default',
            Position = 6
        )]
        [switch]$Default
    )
    begin{
        $environments = @()
    }
    process {

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $environments += Get-FreshServiceConnection
                Write-Verbose ('Found {0} environments' -f $environments.Count)
                $envToUpdate = $environments |
                                    Where-Object -FilterScript {$_.Name -eq $Name}

                if ($envToUpdate) {

                    if (!$Tenant) {
                       Write-Verbose ('Use existing tenant definition in configuration file: {0}' -f $envToUpdate.Tenant)
                        $Tenant = $envToUpdate.Tenant
                    }

                    $environmentLookup = @{
                        'Production' =  ('https://{0}.freshservice.com/api/v2' -f $Tenant)
                        'Sandbox'    =  ('https://{0}-fs-sandbox.freshservice.com/api/v2' -f $Tenant )
                    }

                    foreach ($param in $PSBoundParameters.GetEnumerator()) {
                        switch ($param.key) {
                            'NewName' {
                                Write-Verbose ('Renaming environment {0} to {1}' -f $Name, $NewName)
                                $envToUpdate.Name = $NewName
                            }
                            'ApiKey' {
                                Write-Verbose ('Updating API Key to {0}' -f $ApiKey)
                                $envToUpdate.ApiKey = $ApiKey | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
                            }
                            'Tenant' {
                                Write-Verbose ('Updating Tenant to {0}' -f $Tenant)
                                $envToUpdate.Tenant = $Tenant
                                $envToUpdate.BaseUri = $environmentLookup[$envToUpdate.Environment]
                            }
                            'EmailAddress' {
                                Write-Verbose ('Updating EmailAddress to {0}' -f $EmailAddress)
                                $envToUpdate.EmailAddress = $EmailAddress
                            }
                            'Environment' {
                                Write-Verbose ('Updating Environment to {0}' -f $Environment)
                                $envToUpdate.Environment = $Environment
                                $envToUpdate.BaseUri = $environmentLookup[$Environment]
                            }
                            'Default' {
                                Write-Verbose ('Setting {0} ({1}) as Default connection' -f $envToUpdate.Name, $envToUpdate.Tenant)
                                if ($PSBoundParameters.ContainsKey('Default')) {
                                    ForEach ($envt in $environments) {
                                        Write-Verbose ('Setting {0} to Default = $false' -f $envt.Name)
                                        $envt.Default = $false
                                    }
                                }
                                $envToUpdate.Default = $Default
                            }

                        }
                    }

                    $environments | Export-Clixml -Path $FreshServiceConfigPath

                }
                else {
                    Throw 'Configuration not found. Check the spelling of the Name "{0}" or use New-FreshServiceConnection to create and save a configuration.' -f $Name
                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {

        $envToUpdate
    }
}
