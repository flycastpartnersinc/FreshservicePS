<#
.SYNOPSIS
    Delete a Freshservice Connection.

.DESCRIPTION
    Delete a named Freshservice Connection stored in the configuration file %APPDATA%\PSFreshservice\PSFreshservice.config.

.PARAMETER Name
    Friendly name of the configuration being saved.  This is what will be referenced with the Connect-FreshService cmdlet.  For instance,
    if this was the configuration for the production service account for Acme, you could do Acme_Prod.

.EXAMPLE
    Remove-FreshServiceConnection -Name acme_sandbox

    Name         : acme_prod
    ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000007d6b0edd48041f1e0f8fb47cb760a57bbbc9479a686928278e8044c09cca5a13000000000e8000000002000020000000bb98d9971951f36853d81a4aab84e6cf2c8d0d34789d834fc1fe373870a4764930000
                000951d09207552e120eb4e64b3edb263d7988d67533d64137c85645ce3a9e99b4a204c9b434c68823b2eea1f99f662bb1c400000004e3cd039c10be12adbdee7a8bd683575df2dcd70c98e60751366cf0332c9e69eecc29db7bbfc0e6e9a135fb8d0c155c2f96364bfbadda7dd7f29283d42322f2d
    Tenant       : acme-corp
    BaseUri      : https://acme-corp.freshservice.com/api/v2
    EmailAddress : john.smith@acme-corp.com
    Environment  : Production
    Default      : True

    Remove a Freshservice Connection.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceConnection {
    [OutputType('System.Object[]')]
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Friendly name of the environment',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidatePattern('^[A-Za-z0-9_@.-]*$')]
        [string]$Name
    )
    begin {

        $environments = @()

    }
    process {
        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                Write-Verbose -Message ('Connecting to configuration file {0}.' -f $FreshServiceConfigPath)

                $environments += Get-FreshServiceConnection

                $envToRemove = $environments |
                                    Where-Object -FilterScript {$_.Name -eq $Name}

                if (!$envToRemove) {
                    Throw 'Configuration not found. Check the spelling of the Name "{0}" or use New-FreshServiceConnection to create and save a configuration.' -f $Name            }
                else {
                    $environments = $environments |
                                        Where-Object -FilterScript {$_.Name -ne $Name}
                }

                if ($environments.Count -gt 0) {
                    $environments | Export-Clixml -Path $FreshServiceConfigPath -ErrorAction Stop
                }
                else {
                    Remove-Item -Path $FreshServiceConfigPath -Force -ErrorAction Stop
                }

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
        $environments
    }
}
