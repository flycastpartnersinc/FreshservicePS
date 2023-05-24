
Describe "Audit Logs" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:audit_log_test_guid = New-Guid

            $invokeFreshServiceAuditLogExportSplat = @{
                since   = Get-Date -Date (Get-Date).AddDays(-5)
                before  = Get-Date -Date (Get-Date).AddDays(-1)
            }

            $Script:newFSAuditLogExp = Invoke-FreshServiceAuditLogExport @invokeFreshServiceAuditLogExportSplat
        }
        Context "Invoke Export" {
            It "Invoke-FreshServiceAuditLogExport should return success" -Tag "Audit Logs" {
                $newFSAuditLogExp |
                    Select-Object -ExpandProperty message |
                        Should -BeLike 'Your export is on its way.*'
            }
        }
    }
}
