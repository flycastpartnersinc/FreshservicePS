Add-Type -AssemblyName System.Web

$Global:FreshServiceModuleName = $MyInvocation.MyCommand.Name -replace '.psm1'
if ($IsWindows) {
    $Global:FreshServiceConfigPath = ('{0}\{1}\{1}.config' -f $env:APPDATA,$FreshServiceModuleName)
}
else {
    $Global:FreshServiceConfigPath = ('{0}/{1}/{1}.config' -f $env:HOME,$FreshServiceModuleName)
}

# Dot source public/private functions
$public  = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Public/*.ps1')  -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Private/*.ps1') -Recurse -ErrorAction Stop)
foreach ($import in @($public + $private)) {
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
        Write-Warning -Message ('*** Automatically connecting to default Freshservice tenant {0}. ***' -f $defaultConnection.Tenant)
        Connect-Freshservice -Name $defaultConnection.Name -NoBanner
    }
}
