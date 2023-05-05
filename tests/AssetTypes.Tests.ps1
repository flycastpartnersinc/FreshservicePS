
Describe "Asset Types" {
    Get-Module PSFreshservice | Remove-Module -Force
    Import-Module "$PSScriptRoot/../PSFreshservice" -Force -ErrorAction Stop

    InModuleScope PSFreshservice {

        Connect-Freshservice -Name ItsFine_Prod -NoBanner

        BeforeDiscovery {
            $Script:guid = New-Guid

            $newFreshServiceAssetTypeSplat = @{
                name        = ('Pester Test {0}' -f $guid)
                description = ('Pester Test {0}' -f $guid)
            }

            $Script:newFSAssetType = New-FreshServiceAssetType @newFreshServiceAssetTypeSplat
        }

        Context "Create" {
            It "New-FreshServiceAssetType should create a New FreshService Asset Type." -Tag "Asset Type" {
               $newFSAssetType | Should -Not -BeNullOrEmpty
            }

            $properties = ('id',
                           'name',
                           'parent_asset_type_id',
                           'visible',
                           'description')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Asset Type" {
                $newFSAssetType.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceAssetType should return data" -Tag "Asset Type" {
                $assetTypes = Get-FreshServiceAssetType
                $assetTypes | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceAssetType -id should return the test Asset Type" -Tag "Asset Type" {
                $at= Get-FreshServiceAssetType -id $newFSAssetType.ID
                $at.name | Should -BeLike "*$guid"
            }
            It "Get-FreshServiceAssetType -id should throw on bad id" -Tag "Asset Type" {
                {Get-FreshServiceAssetType -id $guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceAssetType should change the -description of Asset Type to Test" -Tag "Asset Type" {
                Set-FreshServiceAssetType -id $newFSAssetType.Id -description "Test" |
                    Select-Object -ExpandProperty description |
                        Should -Be "Test"
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceAssetType should delete the Asset Type" -Tag "Asset Type" {
                Remove-FreshServiceAssetType -id $newFSAssetType.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
