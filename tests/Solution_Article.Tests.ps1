
Describe "Solution Article" {
    InModuleScope FreshservicePS {
         BeforeDiscovery {
            Connect-Freshservice -Name ItsFine_Prod -NoBanner
            $Script:solution_article_test_guid = New-Guid

            $Script:category_id = Get-FreshServiceSolutionCategory |
                                    Where-Object -FilterScript {$_.name -eq 'General'} |
                                        Select-Object -ExpandProperty id

            $Script:folder_id = Get-FreshServiceSolutionFolder -category_id $category_id |
                                    Where-Object -FilterScript {$_.name -like 'FAQ'} |
                                        Select-Object -ExpandProperty id

            $newFreshServiceSolutionArticleSplat = @{
                title        = 'KB {0}' -f $solution_article_test_guid
                description  = 'This is how you fix stuff'
                article_type = 1 #permanent
                folder_id    = $folder_id
                status       = 1 #Draft
                tags         = "Pester", "Test"
                keywords     = 'Pester'
                review_date  = (Get-Date).AddDays(365)
            }

            $Script:newFSSolutionArticle = New-FreshServiceSolutionArticle @newFreshServiceSolutionArticleSplat
        }

        Context "Create" {
            It "New-FreshServiceSolutionArticle should create a New FreshService SolutionArticle." -Tag "Solution Article" {
               $newFSSolutionArticle | Should -Not -BeNullOrEmpty
            }

            $properties = ('description',
                           'group_folder_group_ids',
                           'folder_department_ids',
                           'group_folder_requester_group_ids',
                           'group_folder_department_ids',
                           'attachments',
                           'folder_visibility',
                           'id',
                           'created_at',
                           'updated_at',
                           'title',
                           'status',
                           'user_id',
                           'approval_status',
                           'position',
                           'folder_id',
                           'category_id',
                           'thumbs_up',
                           'thumbs_down',
                           'modified_by',
                           'modified_at',
                           'inserted_into_tickets',
                           'url',
                           'article_type',
                           'views',
                           'description_text',
                           'keywords',
                           'review_date',
                           'tags',
                           'approvals',
                           'cloud_files')

            It "Object schema Contains property <_>" -ForEach $properties -Tag "Solution Article" {
                $newFSSolutionArticle.PSObject.Properties.Name | Should -Contain $_
            }
        }

        Context "View and List" {
            It "Get-FreshServiceSolutionArticle should return data" -Tag "Solution Article" {
                $solArticles = Get-FreshServiceSolutionArticle -folder_id $folder_id
                $solArticles | Should -Not -BeNullOrEmpty
            }
            It "Get-FreshServiceSolutionArticle -id should return the test SolutionArticle" -Tag "Solution Article" {
                $solArticle = Get-FreshServiceSolutionArticle -folder_id $folder_id -id $newFSSolutionArticle.ID
                $solArticle.title | Should -BeLike "*$solution_article_test_guid"
            }
            It "Get-FreshServiceSolutionArticle -id should throw on bad id" -Tag "Solution Article" {
                {Get-FreshServiceSolutionArticle -folder_id $folder_id -id $solution_article_test_guid} |
                    Should -Throw
            }
        }

        Context "Set" {
            It "Set-FreshServiceSolutionArticle should change the -description of SolutionArticle to 'Updated Desc'" -Tag "Solution Article" {
                Set-FreshServiceSolutionArticle -id $newFSSolutionArticle.Id -description "Updated Desc" |
                    Select-Object -ExpandProperty description_text |
                        Should -BeLike "*Updated Desc*"
            }
            It "Set-FreshServiceSolutionArticle -status 2 should Publish the Solution Article'" -Tag "Solution Article" {
                Set-FreshServiceSolutionArticle -id $newFSSolutionArticle.Id -status 2 |
                    Select-Object -ExpandProperty status |
                        Should -Be 2
            }
        }

        Context "Delete" {
            It "Remove-FreshServiceSolutionArticle should delete the SolutionArticle" -Tag "Solution Article" {
                Remove-FreshServiceSolutionArticle -id $newFSSolutionArticle.Id |
                    Select-Object -ExpandProperty Status |
                        Should -BeLike 'success*'
            }
        }
    }
}
