#! /usr/bin/env pwsh

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
    $Script:global_author="John Smith"
    # You can use twitter or facebook or anything for global_author_url
    $Script:global_author_url="http://twitter.com/example" 
    # Your email
    $Script:global_email="john@smith.com"

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
    $Script:non_blogpost_files=@('about.html','links.html','gnu-linux.html','macos.html','the-bsds.html','my-setup.html','todo.html','visitors.html')

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
    $Script:html_exclude=@('windows.html','scripts.html','visitors.html')

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
    $Script:date_format="MMMM dd, yyyy"
    $Script:date_locale=(Get-Culture).Name
    $Script:date_inpost="bashblog_timestamp"
    # Don't change these dates
    $Script:date_format_full="dddd, dd MMM yyyy HH:mm:ss zzzz"
    $Script:date_format_timestamp="yyyyMMddHHmm.ss"
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
    #Begin {Get-GlobalVariables}
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

function Test-BoilerplateFile {
    Param($FilePath)

    #Get-GlobalVariables
    $Name = (Get-Item $FilePath).Name
    If ($Name -in $Script:non_blogpost_files) { return $True }

    Switch ($Name) {
        {$_ -in $index_file,$archive_index,$tags_index,$footer_file,$header_file,$global_analytics_file} { return $True }
        {$_ -match $prefix_tags} { return $True }
        Default {
            If ($Name -in $html_exclude) { return $True } 
            return $False
        }
    }
}

function New-HTMLPage {
[CmdLetBinding(DefaultParameterSetName='NoIndex')]
Param(
    [ValidateScript({Test-Path -Path $_})]
    [Parameter(Mandatory=$True)]
    [string]$Content,
    [Parameter(Mandatory=$True)]$FileName,
    [Parameter(Mandatory=$True)]$Title,
    [Parameter(ParameterSetName='Index')][switch]$Index,
    [Parameter(ParameterSetName='NoIndex')]$Timestamp,
    [Parameter(ParameterSetName='NoIndex')]$Author
)

    Invoke-Command -ScriptBlock {
        Get-Content '.header.html'
        Write-Output "<title>$Title</title>"
        # google_analytics
        #twitter_card "$content" "$title"
        Write-Output "</head><body>"
        # stuff to add before the actual body content
        If ($Script:body_begin_file) { Get-Content "$Script:body_begin_file" }
        # body divs
        Write-Output '<div id="divbodyholder">'
        Write-Output '<div class="headerholder"><div class="header">'
        # blog title
        Write-Output '<div id="title">'
        Get-Content .title.html
        Write-Output '</div></div></div>' # title, header, headerholder
        Write-Output '<div id="divbody"><div class="content">'

        $FileUrl=(Get-Item $FileName).Name
        $FileUrl=$FileUrl.Replace('\\\.rebuilt','') # get the correct url when rebuilding
        # one blog entry
        if (!$Index) {
            Write-Output '<!-- entry begin -->' # marks the beginning of the whole post
            Write-Output "<h3><a class=`"ablack`" href=`"$FileUrl`">"
            # remove possible <p>'s on the title because of markdown conversion
            $Title -match '<[pP]>(?<title>.*)</[pP]>' | Out-Null
            If ($Matches) { $Title=$Matches['title'] }
            Write-Output "$Title"
            Write-Output '</a></h3>'
            if (!$Timestamp) {
                Write-Output "<!-- $date_inpost`: #$(Get-Date -Format "$Script:date_format_timestamp")# -->"
                #Write-Output "<!-- $date_inpost: #$((Get-Date -Format "$Script:date_format_timestamp") -replace '^([A-Z][a-z]{2})\w+,\s(\d\d\s\w{3}\s\d{4}\s\d\d:\d\d:\d\d)\s(.\d\d):(\d\d)','$1, $2$3$4')# -->"
            } else {
                Write-Output "<!-- $date_inpost`: #$(Get-Date $Timestamp -Format "$Script:date_format_timestamp")# -->"
            }
            if (!$Timestamp) {
                $DivOutput = "<div class=`"subtitle`">$(Get-Date -Format "$Script:date_format")"
            } else {
                $DivOutput = "<div class=`"subtitle`">$(Get-Date $Timestamp -Format "$Script:date_format")"
            }

            If ($Author) { $DivOutput += " &mdash; `n$Author`n" }
            Write-Output "$DivOutput</div>"
            Write-Output '<!-- text begin -->' # this marks the text body, after the title, date...
        }
        Get-Content $Content # actual content
        if (!$Index) {
            Write-Output "`n<!-- text end -->"

            #twitter "$global_url/$file_url"

            Write-Output '<!-- entry end -->' # absolute end of the post
        }

        Write-Output '</div>' # content

        # Add disqus commments except for index and all_posts pages
        #If (!$Index) { disqus_body }

        # page footer
        Get-Content .footer.html
        # close divs
        Write-Output '</div></div>' # divbody and divbodyholder 
        #disqus_footer
        If ($Script:body_end_file) { Get-Content "$body_end_file" }
        Write-Output '</body></html>'
    } | Out-File "$FileName"
}

function New-Includes {
    Invoke-Command -ScriptBlock {
        Write-Output "<h1 class=`"nomargin`"><a class=`"ablack`" href=`"$Script:global_url/$Script:index_file`">$Script:global_title</a></h1>" 
        Write-Output "<div id=`"description`">$global_description</div>"
    } | Out-File ".title.html"

    if ($Script:header_file -and (Test-Path -Path $Script:header_file)) {
        Copy-Item "$Script:header_file" .header.html
    } else {
        Invoke-Command -ScriptBlock {
            Write-Output '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
            Write-Output '<html xmlns="http://www.w3.org/1999/xhtml"><head>'
            Write-Output '<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />'
            Write-Output '<meta name="viewport" content="width=device-width, initial-scale=1.0" />'
            $Script:css_include | ForEach-Object { "<link rel=`"stylesheet`" href=`"$_`" type=`"text/css`" />"}
            if (!$Script:global_feedburner) {
                Write-Output "<link rel=`"alternate`" type=`"application/rss+xml`" title=`"$Script:template_subscribe_browser_button`" href=`"$Script:blog_feed`" />"
            } else { 
                Write-Output "<link rel=`"alternate`" type=`"application/rss+xml`" title=`"$Script:template_subscribe_browser_button`" href=`"$Script:global_feedburner`" />"
            }
        } | Out-File ".header.html"
    }

    if ($Script:footer_file -and (Test-Path -Path $Script:footer_file)) {
        Copy-Item "$Script:footer_file" .footer.html
    } else {
        Invoke-Command -ScriptBlock {
            $protected_mail=$Script:global_email -replace '@','&#64;'
            $protected_mail=$protected_mail -replace '\.','&#46;'
            Write-Output "<div id=`"footer`">$Script:global_license <a href=`"$Script:global_author_url`">$Script:global_author</a> &mdash; <a href=`"mailto:$protected_mail`">$protected_mail</a><br/>"
            Write-Output 'Generated with <a href="https://github.com/cfenollosa/bashblog">bashblog</a>, a single bash script to easily create blogs like this one</div>'
        } | Out-File -Append ".footer.html"
    }
}

function New-CSS {
    If ($Script:css_include.Count -gt 0) { return } else {
        $Script:css_include = @('main.css', 'blog.css')
    }

    If (!(Test-Path -Path blog.css)) {
        # blog.css directives will be loaded after main.css and thus will prevail
        Write-Output '#title{font-size: x-large;}
        a.ablack{color:black !important;}
        li{margin-bottom:8px;}
        ul,ol{margin-left:24px;margin-right:24px;}
        #all_posts{margin-top:24px;text-align:center;}
        .subtitle{font-size:small;margin:12px 0px;}
        .content p{margin-left:24px;margin-right:24px;}
        h1{margin-bottom:12px !important;}
        #description{font-size:large;margin-bottom:12px;}
        h3{margin-top:42px;margin-bottom:8px;}
        h4{margin-left:24px;margin-right:24px;}
        img{max-width:100%;}
        #twitter{line-height:20px;vertical-align:top;text-align:right;font-style:italic;color:#333;margin-top:24px;font-size:14px;}' | Out-File blog.css
    }

    # If there is a style.css from the parent page (i.e. some landing page)
    # then use it. This directive is here for compatibility with my own
    # home page. Feel free to edit it out, though it doesn't hurt
    If ((Test-Path -Path ../style.css) -and !(Test-Path -Path main.css)) {
        ln -s "../style.css" "main.css" 
    } elseif (!(Test-Path -Path main.css)) {
        Write-Output 'body{font-family:Georgia,"Times New Roman",Times,serif;margin:0;padding:0;background-color:#F3F3F3;}
        #divbodyholder{padding:5px;background-color:#DDD;width:100%;max-width:874px;margin:24px auto;}
        #divbody{border:solid 1px #ccc;background-color:#fff;padding:0px 48px 24px 48px;top:0;}
        .headerholder{background-color:#f9f9f9;border-top:solid 1px #ccc;border-left:solid 1px #ccc;border-right:solid 1px #ccc;}
        .header{width:100%;max-width:800px;margin:0px auto;padding-top:24px;padding-bottom:8px;}
        .content{margin-bottom:5%;}
        .nomargin{margin:0;}
        .description{margin-top:10px;border-top:solid 1px #666;padding:10px 0;}
        h3{font-size:20pt;width:100%;font-weight:bold;margin-top:32px;margin-bottom:0;}
        .clear{clear:both;}
        #footer{padding-top:10px;border-top:solid 1px #666;color:#333333;text-align:center;font-size:small;font-family:"Courier New","Courier",monospace;}
        a{text-decoration:none;color:#003366 !important;}
        a:visited{text-decoration:none;color:#336699 !important;}
        blockquote{background-color:#f9f9f9;border-left:solid 4px #e9e9e9;margin-left:12px;padding:12px 12px 12px 24px;}
        blockquote img{margin:12px 0px;}
        blockquote iframe{margin:12px 0px;}' | Out-File main.css
    }
}

function Edit-BlogPost {

}

function New-BlogPost {

}



function do_main {
    [CmdLetBinding()]
    Param()
    Get-GlobalVariables
    $global_config=".config"
    Write-Verbose "Running version $global_software_version"
    New-CSS
}

Get-GlobalVariables
#
# MAIN
# Do not change anything here. If you want to modify the code, edit do_main
#
do_main
