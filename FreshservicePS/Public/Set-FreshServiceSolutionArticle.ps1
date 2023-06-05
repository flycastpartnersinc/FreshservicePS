<#
.SYNOPSIS
    Updates a Freshservice Solution Article.

.DESCRIPTION
    Updates a Freshservice Solution Article via REST API.

    https://api.freshservice.com/#update_solution_article

.PARAMETER id
    Unique id of the solution article.

.PARAMETER title
    Title of the solution article.

.PARAMETER description
    Description of the solution article.

.PARAMETER article_type
    The type of the article.

    1 = permanent
    2 = workaround

.PARAMETER folder_id
    Unique id of the folder under which the article is listed.

.PARAMETER category_id
    Unique id of the category under which the article is belongs to.

.PARAMETER status
    Status of the article.

    1 = draft
    2 = published

.PARAMETER approval_status
    Approval status of the article.

.PARAMETER tags
    Tags that have been associated with the article

.PARAMETER keywords
    keywords that have been associated with the article

.PARAMETER attachments
    Article attachments. The total size of these attachments cannot exceed 25MB.

.PARAMETER url
    Article from external url link.

.PARAMETER review_date
    Date in future when this article would need to be reviewed again.

.PARAMETER send_for_approval
    Send the article for approval.

.EXAMPLE
    Set-FreshServiceSolutionArticle -id 21000399687 -description "Updated Solution for KB"

    description                      : <p>Updated Solution for KB</p>
    group_folder_group_ids           : {}
    folder_department_ids            : {}
    group_folder_requester_group_ids : {}
    group_folder_department_ids      : {}
    attachments                      : {}
    folder_visibility                : 1
    id                               : 21000399687
    created_at                       : 3/23/2023 1:49:08 PM
    updated_at                       : 3/31/2023 1:54:52 AM
    title                            : VPN Issue 4
    status                           : 1
    user_id                          : 21000418005
    approval_status                  :
    position                         : 7
    folder_id                        : 21000036164
    category_id                      : 21000023800
    thumbs_up                        : 0
    thumbs_down                      : 0
    modified_by                      : 21000418005
    modified_at                      : 3/31/2023 1:54:52 AM
    inserted_into_tickets            : 0
    url                              :
    article_type                     : 1
    views                            : 0
    description_text                 :  Updated Solution for KB
    keywords                         : {VPN}
    review_date                      :
    tags                             : {VPN}
    approvals                        : {}
    cloud_files                      : {}

    Update the description on a Freshservice Solution Article.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceSolutionArticle {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the solution article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the solution article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Approval',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the solution article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'External',
            Position = 0
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Title of the solution article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Title of the solution article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'External',
            Position = 1
        )]
        [string]$title,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the solution article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 2
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The type of the article. ( 1 - permanent, 2 - workaround )',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [long]$article_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the folder under which the article is listed',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the folder under which the article is listed',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'External',
            Position = 2
        )]
        [long]$folder_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the article. ( 1 - draft, 2 - published )',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the article. ( 1 - draft, 2 - published )',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'External',
            Position = 3
        )]
        [ValidateRange(1,2)]
        [int]$status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Tags that have been associated with the article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Tags that have been associated with the article',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'External',
            Position = 4
        )]
        [array]$tags,
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
            Position = 5
        )]
        [array]$keywords,
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
            Position = 6
        )]
        [string]$url,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Date in future when this article would need to be reviewed again.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [datetime]$review_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Send the article for approval.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Approval',
            Position = 1
        )]
        [switch]$send_for_approval

    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/solutions/articles' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        if ($send_for_approval) {
            $uri.Path = "{0}/send_for_approval" -f $uri.Path
            [void]$PSBoundParameters.Remove('send_for_approval')
        }

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
                    Method      = 'PUT'
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

                if ($result.Content) {
                    $content = $result.Content |
                                    ConvertFrom-Json

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
