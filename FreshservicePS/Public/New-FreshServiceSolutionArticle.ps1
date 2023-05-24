<#
.SYNOPSIS
    Creates a new Freshservice Solution Article.

.DESCRIPTION
    Creates a new Freshservice Solution Article via REST API.

    https://api.freshservice.com/#create_solution_article

.PARAMETER title
    Title of the solution article.

.PARAMETER description
    Description of the solution article.

.PARAMETER article_type
    The type of the article.

    1 - Permanent
    2 - Workaround

.PARAMETER folder_id
    Unique id of the folder under which the article is listed.

.PARAMETER category_id
    Unique id of the category under which the article is belongs to.

.PARAMETER status
    Status of the article.

    1 - Draft
    2 - Published

.PARAMETER approval_status
    Approval status of the article.

.PARAMETER tags
    Tags that have been associated with the article.

.PARAMETER keywords
    keywords that have been associated with the article.

.PARAMETER attachments
    Article attachments. The total size of these attachments cannot exceed 25MB.

.PARAMETER url
    Article from external url link.

.PARAMETER review_date
    Date in future when this article would need to be reviewed again.

.PARAMETER language
    Language of secondary solution article. For example: French -> "fr"
    For other language code please refer here:
    https://support.freshservice.com/en/support/solutions/articles/50000003971-how-to-upgrade-your-multilingual-knowledge-base

.PARAMETER parent_id
    Unique ID of the primary language (Solution) article.

.EXAMPLE
    New-FreshServiceSolutionArticle -title 'How to fix the internet.' -description '<ol><li>Restart computer</li></ol>' -folder_id 21000036164 -status 1

    description                      : <ol><li>Restart computer</li></ol>
    group_folder_group_ids           : {}
    folder_department_ids            : {}
    group_folder_requester_group_ids : {}
    group_folder_department_ids      : {}
    attachments                      : {}
    folder_visibility                : 1
    id                               : 21000434337
    created_at                       : 3/28/2023 7:02:40 PM
    updated_at                       : 3/28/2023 7:02:40 PM
    title                            : How to fix the internet.
    status                           : 1
    user_id                          : 21000418005
    approval_status                  :
    position                         : 75
    folder_id                        : 21000036164
    category_id                      : 21000023800
    thumbs_up                        : 0
    thumbs_down                      : 0
    modified_by                      :
    modified_at                      : 3/28/2023 7:02:40 PM
    inserted_into_tickets            : 0
    url                              :
    article_type                     : 1
    views                            : 0
    description_text                 :   Restart computer
    keywords                         : {}
    review_date                      :
    tags                             : {}
    approvals                        : {}
    cloud_files                      : {}

    Creates a new Freshservice Solution Article.

.EXAMPLE
    New-FreshServiceSolutionArticle -title 'Freshservice API Documentation' -folder_id 21000036164 -url 'https://api.freshservice.com/' -tags API -keywords API

    description                      :
    group_folder_group_ids           : {}
    folder_department_ids            : {}
    group_folder_requester_group_ids : {}
    group_folder_department_ids      : {}
    attachments                      : {}
    folder_visibility                : 1
    id                               : 21000434371
    created_at                       : 3/28/2023 7:09:09 PM
    updated_at                       : 3/28/2023 7:09:09 PM
    title                            : Freshservice API Documentation
    status                           : 2
    user_id                          : 21000418005
    approval_status                  :
    position                         : 76
    folder_id                        : 21000036164
    category_id                      : 21000023800
    thumbs_up                        : 0
    thumbs_down                      : 0
    modified_by                      :
    modified_at                      : 3/28/2023 7:09:09 PM
    inserted_into_tickets            : 0
    url                              : https://api.freshservice.com/
    article_type                     : 1
    views                            : 0
    description_text                 :
    keywords                         : {API}
    review_date                      :
    tags                             : {API}
    approvals                        : {}
    cloud_files                      : {}

    Creates a Freshservice Solution article for External Url.
.EXAMPLE
    New-FreshServiceSolutionArticle -title 'Comment reparer Internet.' -description '<ol><li>Redemarrer lordinateur</li></ol>' -parent_id 21000434337 -folder_id 21000036164 -language 'fr' -status 1

    Creates a Secondary Language Freshservice Solution article.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceSolutionArticle {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Title of the solution article',
            ValueFromPipelineByPropertyName = $true,
            Position = 0
        )]
        [string]$title,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the folder under which the article is listed',
            ValueFromPipelineByPropertyName = $true,
            Position = 1
        )]
        [long]$folder_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Status of the article. ( 1 - draft, 2 - published )',
            ValueFromPipelineByPropertyName = $true,
            Position = 2
        )]
        [ValidateRange(1,2)]
        [int]$status,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Description of the solution article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Description of the solution article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Language',
            Position = 3
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The type of the article. ( 1 - permanent, 2 - workaround )',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The type of the article. ( 1 - permanent, 2 - workaround )',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Language',
            Position = 4
        )]
        [long]$article_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Tags that have been associated with the article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Tags that have been associated with the article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'External',
            Position = 5
        )]
        [string[]]$tags,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'keywords that have been associated with the article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'keywords that have been associated with the article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'External',
            Position = 6
        )]
        [string[]]$keywords,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket attachments. The total size of these attachments cannot exceed 15MB.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7
        )]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw ("Cannot find path {0} because it does not exist." -f $_.FullName)
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw ("{0} is not a valid file. Folder paths are not allowed." -f $_.FullName)
            }
            if($_.Length/1MB -gt 15 ) {
                throw ("{0} exceeds the file size limit. Files must be under 15MB." -f $_.FullName)
            }
            return $true
        })]
        [System.IO.FileInfo[]]$attachments,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Article from external url link.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'External',
            Position = 8
        )]
        [string]$url,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Date in future when this article would need to be reviewed again.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 9
        )]
        [datetime]$review_date,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Language of secondary solution article, For example: French -> "fr"',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Language',
            Position = 10
        )]
        [string]$language,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique ID of the primary language (Solution) article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Language',
            Position = 11
        )]
        [long]$parent_id
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/solutions/articles' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
                    ErrorAction = 'Stop'
                }

                if ( $attachments ) {
                    if ( $PSVersionTable.PSVersion.Major -lt 7 ) {
                        Write-Warning "Sorry! Attachments are not currently supported in versions earlier than Powershell 7.x due to multipart/form-data requirements. Attachment parameter will be ignored."
                        $jsonBody.Remove('attachments')
                        $params.Body = $jsonBody | ConvertTo-Json
                    }
                    else {
                        #Invoke-WebRequest -Form is supported in 7+
                        $jsonBody.Add('attachments[]',$attachments)
                        $jsonBody.Remove('attachments')
                        $params.Form = $jsonBody
                    }
                }
                else {
                    $params.Body = $jsonBody | ConvertTo-Json
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json -Depth 5

                if ($content) {
                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
