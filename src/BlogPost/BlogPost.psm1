#! /usr/bin/env pwsh

[CmdletBinding()]
Param(
    [Parameter(ParameterSetName="Post")]
        [switch]$Post,
    [Parameter(ParameterSetName="Edit")]
        [switch]$Edit,
    [Parameter(ParameterSetName="Delete")]
        [switch]$Delete,
    [Parameter(ParameterSetName="Rebuild")]
        [switch]$Rebuild,
    [Parameter(ParameterSetName="Reset")]
        [switch]$Reset,
    [Parameter(ParameterSetName="List")]
        [switch]$List,
    [Parameter(ParameterSetName="Tags")]
        [switch]$Tags,
    [Parameter(ParameterSetName="Post")]
    [Parameter(ParameterSetName="Edit",Mandatory=$True)]
    [Parameter(ParameterSetName="Delete")]
    [ValidateScript({Test-Path -Path $_})]
        [string]$FileName,
    [Parameter(ParameterSetName="Post")]
        [switch]$HTML,
    [Parameter(ParameterSetName="Edit")]
    [Parameter(ParameterSetName="Name")]
    [Parameter(ParameterSetName="Tags")]
        [switch]$NewName,
    [Parameter(ParameterSetName="Edit")]
    [Parameter(ParameterSetName="Full")]
        [switch]$FullFile
     )


function Get-GlobalVariables {
    $Script:global_software_name='PwshBlog'
    $Script:global_software_version='0.1'

    # Blog title
    $Script:global_title="My fancy blog"
    # The typical subtitle for each blog
    $Script:global_description="A blog about turtles and carrots"
    # The public base URL for this blog
    $Script:global_url="http://example.com/blog"

    # Your name
    $Script:global_author="Matt Smith"
    # You can use twitter or facebook or anything for global_author_url
    $Script:global_author_url="http://twitter.com/example" 
    # Your email
    $Script:global_email="matt@smith.com"

    # CC by-nc-nd is a good starting point, you can change this to "&copy;" for Copyright
    $Script:global_license="CC by-nc-nd"

    # If you have a Google Analytics ID (UA-XXXXX) and wish to use the standard
    # embedding code, put it on global_analytics
    # If you have custom analytics code (i.e. non-google) or want to use the Universal
    # code, leave global_analytics empty and specify a global_analytics_file
    $Script:global_analytics=""
    $Script:global_analytics_file=""

    # Leave this empty (i.e. "") if you don't want to use feedburner, 
    # or change it to your own URL
    $Script:global_feedburner=""

    # Change this to your username if you want to use twitter for comments
    $Script:global_twitter_username=""
    # Set this to false for a Twitter button with share count. The cookieless version
    # is just a link.
    $Script:global_twitter_cookieless="true"
    # Default search page, where tweets more than a week old are hidden
    $Script:global_twitter_search="twitter"

    # Change this to your disqus username to use disqus for comments
    $Script:global_disqus_username=""


    # Blog generated files
    # index page of blog (it is usually good to use "index.html" here)
    $Script:index_file="index.html"
    $Script:number_of_index_articles="8"
    # global archive
    $Script:archive_index="all_posts.html"
    $Script:tags_index="all_tags.html"

    # Non blogpost files. Bashblog will ignore these. Useful for static pages and custom content
    # Add them as a bash array, e.g. non_blogpost_files=("news.html" "test.html")
    $Script:non_blogpost_files=@()

    # feed file (rss in this case)
    $Script:blog_feed="feed.rss"
    $Script:number_of_feed_articles="10"
    # "cut" blog entry when putting it to index page. Leave blank for full articles in front page
    # i.e. include only up to first '<hr>', or '----' in markdown
    $Script:cut_do="cut"
    # When cutting, cut also tags? If "no", tags will appear in index page for cut articles
    $Script:cut_tags="yes"
    # Regexp matching the HTML line where to do the cut
    # note that slash is regexp separator so you need to prepend it with backslash
    $Script:cut_line='<hr ?\/?>'
    # save markdown file when posting with "pb -post -m". Leave blank to discard it.
    $Script:save_markdown="yes"
    # prefix for tags/categories files
    # please make sure that no other html file starts with this prefix
    $Script:prefix_tags="tag_"
    # personalized header and footer (only if you know what you're doing)
    # DO NOT name them .header.html, .footer.html or they will be overwritten
    # leave blank to generate them, recommended
    $Script:header_file=""
    $Script:footer_file=""
    # extra content to add just after we open the <body> tag
    # and before the actual blog content
    $Script:body_begin_file=""
    # extra content to add just before we cloese <body tag (just before
    # </body>)
    $Script:body_end_file=""
    # CSS files to include on every page, f.ex. css_include=('main.css' 'blog.css')
    # leave empty to use generated
    $Script:css_include=@()
    # HTML files to exclude from index, f.ex. post_exclude=('imprint.html 'aboutme.html')
    $Script:html_exclude=@()

    # Localization and i18n
    # "Comments?" (used in twitter link after every post)
    $Script:template_comments="Comments?"
    # "Read more..." (link under cut article on index page)
    $Script:template_read_more="Read more..."
    # "View more posts" (used on bottom of index page as link to archive)
    $Script:template_archive="View more posts"
    # "All posts" (title of archive page)
    $Script:template_archive_title="All posts"
    # "All tags"
    $Script:template_tags_title="All tags"
    # "posts" (on "All tags" page, text at the end of each tag line, like "2. Music - 15 posts")
    $Script:template_tags_posts="posts"
    $Script:template_tags_posts_2_4="posts"  # Some slavic languages use a different plural form for 2-4 items
    $Script:template_tags_posts_singular="post"
    # "Posts tagged" (text on a title of a page with index of one tag, like "My Blog - Posts tagged "Music"")
    $Script:template_tag_title="Posts tagged"
    # "Tags:" (beginning of line in HTML file with list of all tags for this article)
    $Script:template_tags_line_header="Tags:"
    # "Back to the index page" (used on archive page, it is link to blog index)
    $Script:template_archive_index_page="Back to the index page"
    # "Subscribe" (used on bottom of index page, it is link to RSS feed)
    $Script:template_subscribe="Subscribe"
    # "Subscribe to this page..." (used as text for browser feed button that is embedded to html)
    $Script:template_subscribe_browser_button="Subscribe to this page..."
    # "Tweet" (used as twitter text button for posting to twitter)
    $Script:template_twitter_button="Tweet"
    $Script:template_twitter_comment="&lt;Type your comment here but please leave the URL so that other people can follow the comments&gt;"
    
    # The locale to use for the dates displayed on screen
    $Script:date_format="%B %d, %Y"
    $Script:date_locale="C"
    $Script:date_inpost="bashblog_timestamp"
    # Don't change these dates
    $Script:date_format_full="%a, %d %b %Y %H:%M:%S %z"
    $Script:date_format_timestamp="%Y%m%d%H%M.%S"
    $Script:date_allposts_header="%B %Y"
    
    <#
    # Perform the post title -> filename conversion
    # Experts only. You may need to tune the locales too
    # Leave empty for no conversion, which is not recommended
    # This default filter respects backwards compatibility
    $Script:convert_filename="iconv -f utf-8 -t ascii//translit | sed 's/^-*//' | tr [:upper:] [:lower:] | tr ' ' '-' | tr -dc '[:alnum:]-'"
    #>

    # URL where you can view the post while it's being edited
    # same as global_url by default
    # You can change it to path on your computer, if you write posts locally
    # before copying them to the server
    $Script:preview_url=""
}

function Get-HTMLFileContent {
    [CmdLetBinding()]
    Param(
        [ValidateSet("text","entry")][string]$Start,
        [ValidateSet("text","entry")][string]$Stop,
        [switch]$Cut,
        [Parameter(ValueFromPipeLine=$True)][string]$Content
    )
    Process {
        If ($_ -match "<!-- $Start begin -->"){
            $Capture = $True
        } elseif ($_ -match "<!-- $Stop end -->") {
            $Capture = $False
        } elseif ($Capture) {
            If ($Cut -and $_ -match $Script:cut_line) {
                 $_; $Capture=$False
                 return
            } else {
                $_
            }
        }
    }
}

function Edit-Post {

}

function do_main {
    [CmdLetBinding()]
    Param()
    Get-GlobalVariables
    $global_config=".config"
    Write-Verbose "Running version $global_software_version"

}

#
# MAIN
# Do not change anything here. If you want to modify the code, edit do_main
#
do_main
