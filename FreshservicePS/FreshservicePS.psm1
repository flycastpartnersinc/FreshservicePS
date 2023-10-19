[CmdletBinding()]
param()

Add-Type -AssemblyName System.Web

$Global:FreshServiceModuleName = $MyInvocation.MyCommand.Name -replace '.psm1'
if ($IsWindows) {
    $Global:FreshServiceConfigPath = ('{0}\{1}\{1}.config' -f $env:APPDATA,$FreshServiceModuleName)
}
else {
    $Global:FreshServiceConfigPath = ('{0}/{1}/{1}.config' -f $env:HOME,$FreshServiceModuleName)
}

$FunctionFiles = $("$PSScriptRoot\Public\","$PSScriptRoot\Private\") |
                        Get-Childitem -File -Recurse -Include "*.ps1" -ErrorAction SilentlyContinue

foreach ($import in $FunctionFiles) {
    try {
        . $import.FullName
        if ($import.BaseName -like '*FreshService*') {
            New-Alias -Name ($import.BaseName).Replace('FreshService','FS') -Value $import.BaseName -Force
        }
    } catch {
        throw "Unable to dot source [$($import.FullName)]"
    }
}

New-Alias -Name 'whofs' -Value 'Get-FreshserviceInfo' -Force

Export-ModuleMember -Function $($Public | Select-Object -ExpandProperty BaseName) -Alias *

if (Test-Path -Path $FreshServiceConfigPath) {
    $defaultConnection = Get-FreshServiceConnection |
                            Where-Object -FilterScript {$_.Default -eq $true}

    if ($defaultConnection) {
        Write-Warning -Message ('*** Automatically connecting to default Freshservice tenant {0}. ***' -f ($defaultConnection | Select-Object -First 1 -ExpandProperty Tenant))
        Connect-Freshservice -Name ($defaultConnection | Select-Object -First 1 -ExpandProperty Name) -NoBanner
    }
}
else {
    Write-Warning -Message 'Create a new connection profile with New-FreshServiceConnection to get started! Use " Get-Help -Name New-FSConnection -Examples " for examples.'
}
