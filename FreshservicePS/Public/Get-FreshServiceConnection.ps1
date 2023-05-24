<#
.SYNOPSIS
    Gets a Freshservice connection stored in a configuration file.

.DESCRIPTION
    Gets a Freshservice connection(s) stored in the configuration file %APPDATA%\FreshservicePS\FreshservicePS.config. Freshservice is a session-less API, the settings created with this cmdlet are used as
    global variables for function\cmdlet execution in the module.

.PARAMETER Name
    Friendly name of the configuration being saved.  This is what will be referenced with the Connect-FreshService cmdlet.  For instance,
    if this was the configuration for the production service account for Acme, you could do Acme_Prod.

.PARAMETER Decrypt
    The API key is stored encypted.  This will decrpyt the key if it needs to be validated.

.EXAMPLE
    Get-FreshserviceConnection

    Name         : acme_prod
    ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000007d6b0edd48041f1e0f8fb47cb760a57bbbc9479a686928278e8044c09cca5a13000000000e8000000002000020000000bb98d9971951f36853d81a4aab84e6cf2c8d0d34789d834fc1fe373870a4764930000
                000951d09207552e120eb4e64b3edb263d7988d67533d64137c85645ce3a9e99b4a204c9b434c68823b2eea1f99f662bb1c400000004e3cd039c10be12adbdee7a8bd683575df2dcd70c98e60751366cf0332c9e69eecc29db7bbfc0e6e9a135fb8d0c155c2f96364bfbadda7dd7f29283d42322f2d
    Tenant       : acme-corp
    BaseUri      : https://acme-corp.freshservice.com/api/v2
    EmailAddress : john.smith@acme-corp.com
    Environment  : Production
    Default      : True

    Name         : acme_sandbox
    ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c00000000020000000000106600000001000020000000203a0fc84bd0c147f32d1c3f70f4352fdb215509447c0784ae9775075ed31e95000000000e80000000020000200000006bad8209dd249fc694bddfc37ff241e7537d8232b0e0c7aa5614025becd1ad3330000
                000b72b9f41625dabd5242d7e5a7a43f54be6fe5c8b07040a97d0c468c8f9200aa98490f99305152d961ecb1d545273364840000000e12a4185d1c55d5fdca124c70adf849503578a4b6e73073e548fc45b476df911b4dfdc570606dd8932c7f8960f858baedaf720ad2ea28dc35156ac6ab771d469
    Tenant       : acme-corp
    BaseUri      : https://acme-corp-fs-sandbox.freshservice.com/api/v2
    EmailAddress : john.smith@acme-corp.com
    Environment  : Sandbox
    Default      : False

    Returns all stored configurations in %APPDATA%\FreshservicePS\FreshservicePS.config.

.EXAMPLE
    Get-FreshServiceConnection -Name acme_sandbox -Decrypt

    Name         : acme_sandbox
    ApiKey       : d8werre9whw9fhwe9we
    Tenant       : acme-corp
    BaseUri      : https://acme-corp-fs-sandbox.freshservice.com/api/v2
    EmailAddress : john.smith@acme-corp.com
    Environment  : Sandbox
    Default      : False

    Get a specific named connection and decrypt the API key.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceConnection {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Friendly name of the environment.'
        )]
        [ValidatePattern('^[A-Za-z0-9_@.-]*$')]
        [string]$Name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Decrypt the API key.'
        )]
        [switch]$Decrypt
    )
    begin {

    }
    process {

        try {
            $environments = Import-Clixml -Path $FreshServiceConfigPath

            if ( $PSBoundParameters.ContainsKey('Name') ) {

                $results = $environments |
                                Where-Object -FilterScript {$_.Name -eq $Name}

                if ( !$results ) {
                    Throw 'Configuration not found. Check the spelling of the Name "{0}" or use New-FreshServiceConnection to create and save a configuration.' -f $Name
                }
                else {
                    If ($Decrypt) {
                        $ApiKey = [Net.NetworkCredential]::new('',$($results.ApiKey | ConvertTo-SecureString)).password
                        Write-Verbose ('Decrypted API Key: {0}' -f $ApiKey)
                        $results.'ApiKey' = $APIKey
                    }
                }
            }
            else {
                $results = $environments
            }

        }
        catch [System.IO.FileNotFoundException] {
            Throw 'Configuration file {0} does not exist. Use New-FreshServiceConnection to create and save a configuration.' -f $FreshServiceConfigPath
        }
        catch {
            Throw $_
        }

    }
    end {
        $results
    }
}
