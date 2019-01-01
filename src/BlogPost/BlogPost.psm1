#! /usr/bin/env pwsh

$Script:global_config='.config'

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
    
    #
    # Perform the post title -> filename conversion
    # Experts only. You may need to tune the locales too
    # Leave empty for no conversion, which is not recommended
    # This default filter respects backwards compatibility
    $Script:convert_filename="%{`$b=[system.text.encoding]::UTF8.GetBytes(`$_);`$c=[system.text.encoding]::convert([text.encoding]::UTF8,[text.encoding]::ASCII,`$b);(-join [system.text.encoding]::ASCII.GetChars(`$c)).ToLower() -replace ' ','-' -replace '[^a-z0-9-]',''}"

    # URL where you can view the post while it's being edited
    # same as global_url by default
    # You can change it to path on your computer, if you write posts locally
    # before copying them to the server
    $Script:preview_url=""
}

function Test-GlobalVariables {
    if ($Script:header_file -eq '.header.html') {
        Write-Error "Please check your configuration. '.header.html' is not a valid value for the setting 'header_file'"
    } 
    if ($Script:footer_file -eq '.footer.html') {
        Write-Error "Please check your configuration. '.footer.html' is not a valid value for the setting 'footer_file'"
    }
}

function New-HTMLFromMarkdown {
    [CmdLetBinding()]
    Param([ValidateScript({Test-Path $_})][Parameter(Mandatory=$True)]$MarkdownFile)
    $Out = "$(($MarkdownFile).BaseName).html"
    While (Test-Path $Out) { $Out = "$(($MarkdownFile).BaseName).$(Get-Random).html" }
    $Content = ConvertFrom-Markdown -Path $MarkdownFile 
    New-Item -ItemType File -Name "$Out" `
        -Value $Content.Html
        Write-Verbose "md converted to html: $Out"
}

function Get-JSContent {
    Param(
        [ValidateSet(
        "GoogleAnalytics",
        "DisqusBody",
        "DisqusFooter"
    )]$Code)

    Switch ($Code) {
        GoogleAnalytics {
            if (!$Script:global_analytics -and !$Script:global_analytics_file) { return }
            if (!$Script:global_analytics_file) {
                Write-Output "<script type=`"text/javascript`">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '${Script:global_analytics}']);
        _gaq.push(['_trackPageview']);

        (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

        </script>"
            } else {
                Get-Content "$global_analytics_file"
            }
        }
        DisqusBody {
            if (!$Script:global_disqus_username) { return }
            Write-Output '<div id="disqus_thread"></div>
            <script type="text/javascript">
            /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
               var disqus_shortname = '"'$Script:global_disqus_username'"'; // required: replace example with your forum shortname

            /* * * DONT EDIT BELOW THIS LINE * * */
            (function() {
            var dsq = document.createElement("script"); dsq.type = "text/javascript"; dsq.async = true;
            dsq.src = "//" + disqus_shortname + ".disqus.com/embed.js";
            (document.getElementsByTagName("head")[0] || document.getElementsByTagName("body")[0]).appendChild(dsq);
            })();
            </script>
            <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
            <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>'
        }
        DisqusFooter {
            if (!$Script:global_disqus_username) { return }
            Write-Output '<script type="text/javascript">
        /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
        var disqus_shortname = '"'$Script:global_disqus_username'"'; // required: replace example with your forum shortname

        /* * * DONT EDIT BELOW THIS LINE * * */
        (function () {
        var s = document.createElement("script"); s.async = true;
        s.type = "text/javascript";
        s.src = "//" + disqus_shortname + ".disqus.com/count.js";
        (document.getElementsByTagName("HEAD")[0] || document.getElementsByTagName("BODY")[0]).appendChild(s);
    }());
    </script>'
            }
    }
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

function Edit-BlogPost {
    [CmdletBinding(DefaultParameterSetName="File")]
    Param(
        [Parameter(Mandatory=$True,ParameterSetName="File",Position=0)]
            [Parameter(ParameterSetName="FileAndKeep")]
            [Parameter(ParameterSetName="FileAndFull")]
            [ValidateScript({
                $f="$((Get-Item $_).BaseName).html"
                If (!(Test-Path $f )) { throw "Can't edit post $f, did you mean to use `"Edit-BlogPost <draft_file`"?" } else { $True }
                })]
            [string]$FileName,
        [Parameter(ParameterSetName="FileAndKeep")]
            [switch]$Keep,
        [Parameter(ParameterSetName="FileAndFull")]
            [switch]$Full
        )

    Test-Editor 
    New-CSS
    New-Includes
    $File=Get-Item $FileName
    $Orig_FileName=$FileName
    # Original post timestamp
    $tmpFileName="$($File.BaseName).html"
    $Edit_Timestamp=(Get-Date (Get-Item $tmpFileName).LastWriteTime -Format $Script:date_format_full) -replace '^([A-Z][a-z]{2})\w+,\s(\d\d\s\w{3}\s\d{4}\s\d\d:\d\d:\d\d)\s(.\d\d):(\d\d)','$1, $2$3$4'
    $Touch_Timestamp=(Get-Date (Get-Item $tmpFileName).LastWriteTime)
    [array]$tags_before=Find-TagsInPost $tmpFileName
    if ($Full) {
        Start-Process $env:EDITOR -ArgumentList $FileName -Wait
    } else {
        If ($File.Extension -eq '.md') {
            # editing markdown file
            Start-Process $env:EDITOR -ArgumentList $FileName -Wait
            $TMPFILE=(New-HTMLFromMarkdown $File)
            $FileName="$($File.Basename).html"
        } else {
            # Create the content file
            $TMPFILE="$($File.BaseName).$(Get-Random).html"
            # Title
            Get-PostTitle "$FileName" | Out-File "$TMPFILE"
            # Post text with plaintext tags
            Get-Content $File | Get-HTMLFileContent 'text' 'text' |
            ForEach-Object {
                If ($_ -match "^<p>$Script:template_tags_line_header") {
                    $_ -replace "<a href='${Script:prefix_tags}([^']*).html'>\1</a>", "$1"
                } else {
                    $_
                }
            } | Out-File "$TMPFILE" -Append
            Start-Process $env:EDITOR -ArgumentList $FileName -Wait
        }
        Remove-Item "$FileName"
        If ($Keep) {
            ConvertTo-BlogPost -SourceFile $TMPFILE -Timestamp $Edit_Timestamp "$FileName"
        } else {
            ConvertTo-BlogPost -SourceFile $TMPFILE -Timestamp $Edit_Timestamp
            If ($File.Extension -eq '.md') {
                Write-Verbose "Moving $File to $($FileName -replace '(.*?\..*)','$1.md') filename: $FileName"
                Move-Item $File ($FileName -replace '(.*?)\..*','$1.md') -Force
            }
        }
        Remove-Item "$TMPFILE"
    }
    Set-FileTimestamp $FileName -Timestamp $Touch_Timestamp | Out-Null
    Set-FileTimestamp $Orig_FileName -Timestamp $Touch_Timestamp | Out-Null
    # chmod 644 "$filename"
    [array]$tags_after=Find-TagsInPost $FileName
    $relevant_tags=$tags_before+$tags_after | Sort-Object -Unique
    if ($relevant_tags) {
        $relevant_posts=(Find-PostsWithTags $relevant_tags)+$FileName
        Build-Tags -Posts $relevant_posts -Tags $relevant_tags
    }
    Remove-Includes
}

function Get-TwitterCard {

}

function Get-TwitterCode {

}

function Test-BoilerplateFile {
    [CmdLetBinding()]
    Param($Name)
    # Check if the file is a 'boilerplate' (i.e. not a post)
    If ($Name.Name) { $Name = $Name.Name }
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
    [Parameter(Mandatory=$True,Position=0)]
    [string]$Content,
    [Parameter(Mandatory=$True,Position=1)]$FileName,
    [Parameter(Mandatory=$True,Position=2)]$Title,
    [Parameter(ParameterSetName='Index')][switch]$Index,
    [Parameter(ParameterSetName='NoIndex',Position=3)]$Timestamp,
    [Parameter(ParameterSetName='NoIndex',Position=4)]$Author
)

    Write-Verbose "Creating new html page $FileName"
    Invoke-Command -ScriptBlock {
        Get-Content '.header.html'
        Write-Output "<title>$Title</title>"
        Get-JSContent -Code GoogleAnalytics
        #twitter_card "$content" "$title" ## Not implemented yet ##
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
            $Matches = $Null
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
        If (!$Index) { Get-JSContent -Code DisqusBody }

        # page footer
        Get-Content .footer.html
        # close divs
        Write-Output '</div></div>' # divbody and divbodyholder 
        Get-JSContent -Code DisqusFooter
        If ($Script:body_end_file) { Get-Content "$body_end_file" }
        Write-Output '</body></html>'
    } | Out-File "$FileName"
}

function ConvertTo-BlogPost {
    Param(
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]$SourceFile,
        $Timestamp,
        $DestinationFile
    )
    # was parse_file() in bb
    $Title=""
    Get-Content $SourceFile | ForEach-Object {
        If (!$Title) {
            # remove extra <p> and </p> added by markdown
            $Title=$_ -replace '<\/*p>',''
            If ($DestinationFile) {
                $FileName=$DestinationFile
            } else {
                $FileName=$Title
                If ($Script:convert_filename) {
                    $FileName = Invoke-Expression "Write-Output '$Title' | $Script:convert_filename"
                }
                If (!$FileName) {
                    $FileName=(Get-Random) # don't allow empty filenames
                }
                $FileName="$FileName.html"

                # Check for duplicate file names
                while (Test-Path $FileName) {
                    $FileName="$((Get-Item $FileName).Basename)$(Get-Random).html"
                }
            #>
            }
            $Content="$FileName.tmp"
        # Parse possible tags
        } elseif ($_ -match "<p>$Script:template_tags_line_header") {
            $Tags=$_.split(':')[1].replace('</p>','').trim().replace(', ',',').split(',')
            Write-Output "<p>$Script:template_tags_line_header " | Out-File "$Content" -NoNewLine -Append
            $Tags | ForEach-Object {
                $TagContent += "<a href='${Script:prefix_tags}${_}.html'>${_}</a>, "
            }
            $TagContent -replace ', $','</p>' | Out-File "$Content" -Append
        } else {
            Write-Output "$_" | Out-File "$Content" -Append
        }
    }

    # Create the actual html page
    New-HTMLPage $Content $FileName $Title $Timestamp -Author $Script:global_author
    Remove-Item "$Content"
}

function New-BlogPost {
    # was write_entry
}

function New-IndexPage {
    # was all_posts
}

function New-TagsIndex {
    # was all_tags
}

function Build-Index {
    # was rebuild_index
}

# Finds all tags referenced in one post.
# Accepts either filename as first argument, or post content at stdin
# Prints one line with space-separated tags to stdout
function Find-TagsInPost {
    # was tags_in_post
    Param(
        [Parameter(Position=0)][ValidateScript({Test-Path $_})][string]$FileName,
        [Parameter(ValueFromPipeline=$True)]$InputObject
    )
    Begin { If ($FileName) {$InputObject=Get-Content "$FileName"} }
    Process {
        $InputObject | ForEach-Object {
            If ($_ -match "^<p>$Script:template_tags_line_header") {
                $tags = $_ `
                -replace "^<p>$Script:template_tags_line_header", ""`
                -replace '<[^>]*>', ''`
                -replace '[, ]+', ' '
                $tags.trim().split(' ')
            }
        }
    }
}

function Find-PostsWithTags {
    # was posts_with_tags
    # Finds all posts referenced in a number of tags.
    # Arguments are tags
    # Prints one line with space-separated tags to stdout
    Param([array]$Tags)
    $Tags | ForEach-Object {
        $TagFile = "${Script:prefix_tags}${_}.html"
        Get-Content $TagFile -ErrorAction SilentlyContinue | ForEach-Object {
            If ($_ -match '^<h3><a class="ablack" href="[^"]*">') {
                $_ -replace '.*href="([^"]*)">.*','$1'
            }
        }
    }
}

function Build-Tags {
    # was rebuild_tags
    [CmdLetBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    Param(
        [Parameter(ParameterSetName="Both")][array]$Posts,
        [Parameter(ParameterSetName="Both")][array]$Tags
    )
    If (!$Posts -and !$Tags) {
        $Posts=Get-ChildItem -Filter '*.html' | Sort-Object -Property LastWriteTime -Descending
        $AllTags=$True
    } elseif ($Posts -and $Tags) {
        $Posts = $Posts | Sort-Object -Unique | Get-ChildItem | Sort-Object -Property LastWriteTime -Descending
    } else {
        throw "Invalid combination of parameters"
    }
    If ($AllTags) {
        Remove-Item "${Script:prefix_tags}*.html"
    } else {
        $Tags | ForEach-Object {
            Remove-Item "${Script:prefix_tags}${_}.html" -ErrorAction SilentlyContinue
        }
    }
    # First we will process all files and create temporal tag files
    # with just the content of the posts
    $tmpfile="tmp.$(Get-Random)"
    While (Test-Path $tmpfile) { $tmpfile="tmp.$(Get-Random)" }
    $i=0
    foreach ($Post in $Posts) {
        $i=$i+1
        Write-Progress -Activity "Scanning for tag pages" -Status "Scanning $Post for tags" -PercentComplete ($i/$Posts.count*100)
        If (Test-BoilerplateFile $Post) { continue }
        Invoke-Command -ScriptBlock {
            If ($Script:cut_do) {
                Get-Content $Post | Get-HTMLFileContent "entry" "entry" -Cut | ForEach-Object {
                    If ($_ -match "$Script:cut_line") {
                        Write-Output "<p class=`"readmore`"><a href=`"$($Post.Name)`">${Script:template_read_more}</a></p>"
                    } else {
                        $_
                    }
                }
            } else {
                Get-Content $Post | Get-HTMLFileContent "entry" "entry"
            }
        } | Out-File $tmpfile
        ForEach ($Tag in (Find-TagsInPost $Post)){
            If ($AllTags -or $Tag -in $Tags) {
                Get-Content $tmpfile | Out-File "${Script:prefix_tags}${Tag}.tmp.html" -Append
            }
        }
    }
    Write-Progress -Activity "Scanning for tag pages" -Status "Finished" -Complete
    Remove-Item $tmpfile
    # Now generate the tag files with headers, footers, etc
    Write-Verbose "Generating tag files"
    $i=0
    Write-Progress -Activity "Rebuilding tag pages" -Status "Writing tags" -PercentComplete 0
    $tmpTagFiles = Get-ChildItem "${Script:prefix_tags}*.tmp.html" | Sort-Object -Property LastWriteTime -Descending 
    $tmpTagFiles | ForEach-Object {
        $tagname=$_.Name -replace "^${Script:prefix_tags}([^\.]*).*",'$1'
        Write-Progress -Activity "Rebuilding tag pages" -Status "Writing $tagname" -PercentComplete ($i/$tmpTagFiles.count*100)
        New-HTMLPage -Content $_ -FileName "${Script:prefix_tags}${tagname}.html" -Index -Title "${Script:global_title} &mdash; ${Script:template_tag_title} `"$tagname`""
        Remove-Item $_
    }
    Write-Progress -Activity "Rebuilding tag pages" -Complete
}

function Get-PostTitle {
    # was get_post_title
}

function Get-PostAuthor {
    # was get_post_author
}

function Get-Tags {
    # was list_tags
}

function Get-Posts {
    # was list_posts
}

function New-RSSFeedFile {
    # was make_rss
}

function New-Includes {
    # was create_includes
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

function Remove-Includes {
    '.title.html', '.footer.html', '.header.html' | Remove-Item -Force
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

function Build-AllEntries {
    # was rebuild_all_entries
}

function Reset-BlogSite {
    # was reset
}

#####
# Other functions to implement missing features
function Set-FileTimestamp {
    <#
    .SYNOPSIS
        Replace Unix Touch command in a powershelly way
    .DESCRIPTION
        Set a file's timestamp. Create the file if it doesn't exist.
    .PARAMETER FileName
        Filename/path to file of which to set timestamp.
    .PARAMETER Timestamp
        If specified set the lastwritetime of a file to this timestamp. Otherwise, use the current date/time.
    .EXAMPLE
        Set-FileTimestamp -FileName "billybob.txt"
    .EXAMPLE
        Set-FileTimestamp -FileName "secrets.txt" -Timestamp (Get-Date).AddDays(-102)
    .NOTES
        notes
    .LINK
        online help
    #>
    [CmdLetBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    Param(
        [Parameter(Mandatory=$True)]
        [ValidateScript({((Test-Path $_) -and !(Get-Item $_).PSIsContainer) -or !(Test-Path $_)})]$FileName,
        [DateTime]$Timestamp
    )

    If (!$Timestamp) { $Timestamp = Get-Date }
    If (Test-Path -Path $FileName) { 
        If ($PSCmdlet.ShouldProcess("$Filename","Update timestamp")) {
            (Get-Item $FileName).LastWriteTime = $Timestamp
        }
        Get-Item $FileName
    } else {
        If ($PSCmdlet.ShouldProcess("$FileName","Create new file with timestamp")) {
            (New-Item -ItemType File -Name $FileName -Confirm:$False).LastWriteTime = $Timestamp
            Get-Item $FileName
        }
    }
}


function Test-Editor {
    If (!$Env:EDITOR) {throw "Please set your `$ENV:EDITOR environment variable. For example, to use nano, add the line '`$ENV:EDITOR=nano' to your $profile file"
    }
}

function do_main {
    [CmdLetBinding()]
    Param()
    Get-GlobalVariables
    If (Test-Path "$Script:global_config") {
        $config = Get-Content "$Script:global_config" | Out-String
        Invoke-Expression $config
    }
    Write-Verbose "Running version $global_software_version"
}

#Get-GlobalVariables
#
# MAIN
# Do not change anything here. If you want to modify the code, edit do_main
#
do_main
