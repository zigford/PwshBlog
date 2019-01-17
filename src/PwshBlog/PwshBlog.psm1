#! /usr/bin/env pwsh

# PwshBlog, a simple blog system written as a PowerShell Module.
# Inspired by BashBlog originally written by 
# (C) Carlos Fenollosa <carlos.fenollosa@gmail.com>, 2011-2016 and contributors
# https://github.com/carlesfe/bashblog/contributors
# Check out README.md for more details

# Global variables
# It is recommended to perform a 'Build' after changing any of this in the code

# Config file. Any settings "$key=value" written there will override the
# global_variables defaults. Useful to avoid editing PwshBlog.psm1 and having to
# deal with merges in VCS

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
    $Script:date_format="MMMM dd, yyyy"
    $Script:date_locale=(Get-Culture).Name
    $Script:date_inpost="bashblog_timestamp"
    # Don't change these dates
    $Script:date_format_full="dddd, dd MMM yyyy HH:mm:ss zzzz"
    $Script:date_format_timestamp="yyyyMMddHHmm.ss"
    $Script:date_allposts_header="MMMM yyyy"
    
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
    Param(
        [ValidateScript({(Test-Path $_)})]
        [Parameter(Mandatory=$True)]
        [System.IO.FileInfo]$MarkdownFile
    )
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
                "<script type=`"text/javascript`">

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
            '<div id="disqus_thread"></div>
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
            '<script type="text/javascript">
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

    Initialize-Blog
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
            ConvertTo-BlogPost -SourceFile $TMPFILE -Timestamp $Edit_Timestamp | Out-Null
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
        Update-Tags -Posts $relevant_posts -Tags $relevant_tags
    }
    Exit-PwshBlog
}

function Get-TwitterCard {

}

function Get-TwitterCode {

}

function Test-BoilerplateFile {
    [CmdLetBinding()]
    Param($Name)
    Import-Config
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
        "<title>$Title</title>"
        Get-JSContent -Code GoogleAnalytics
        #twitter_card "$content" "$title" ## Not implemented yet ##
        "</head><body>"
        # stuff to add before the actual body content
        If ($Script:body_begin_file) { Get-Content "$Script:body_begin_file" }
        # body divs
        '<div id="divbodyholder">'
        '<div class="headerholder"><div class="header">'
        # blog title
        '<div id="title">'
        Get-Content .title.html
        '</div></div></div>' # title, header, headerholder
        '<div id="divbody"><div class="content">'

        $FileUrl=(Get-Item $FileName).Name
        $FileUrl=$FileUrl.Replace('\\\.rebuilt','') # get the correct url when rebuilding
        # one blog entry
        if (!$Index) {
            '<!-- entry begin -->' # marks the beginning of the whole post
            "<h3><a class=`"ablack`" href=`"$FileUrl`">"
            # remove possible <p>'s on the title because of markdown conversion
            $Matches = $Null
            $Title -match '<[pP]>(?<title>.*)</[pP]>' | Out-Null
            If ($Matches) { $Title=$Matches['title'] }
            $Title
            '</a></h3>'
            if (!$Timestamp) {
                "<!-- $date_inpost`: #$(Get-Date -Format "$Script:date_format_timestamp")# -->"
            } else {
                "<!-- $date_inpost`: #$(Get-Date $Timestamp -Format "$Script:date_format_timestamp")# -->"
            }
            if (!$Timestamp) {
                $DivOutput = "<div class=`"subtitle`">$(Get-Date -Format "$Script:date_format")"
            } else {
                $DivOutput = "<div class=`"subtitle`">$(Get-Date $Timestamp -Format "$Script:date_format")"
            }

            If ($Author) { $DivOutput += " &mdash; `n$Author`n" }
            "$DivOutput</div>"
            '<!-- text begin -->' # this marks the text body, after the title, date...
        }
        Get-Content $Content # actual content
        if (!$Index) {
            "`n<!-- text end -->"

            #twitter "$global_url/$file_url"

            '<!-- entry end -->' # absolute end of the post
        }

        '</div>' # content

        # Add disqus commments except for index and all_posts pages
        If (!$Index) { Get-JSContent -Code DisqusBody }

        # page footer
        Get-Content .footer.html
        # close divs
        '</div></div>' # divbody and divbodyholder 
        Get-JSContent -Code DisqusFooter
        If ($Script:body_end_file) { Get-Content "$body_end_file" }
        '</body></html>'
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
            "<p>$Script:template_tags_line_header " | Out-File "$Content" -NoNewLine -Append
            $Tags | ForEach-Object {
                $TagContent += "<a href='${Script:prefix_tags}${_}.html'>${_}</a>, "
            }
            $TagContent -replace ', $','</p>' | Out-File "$Content" -Append
        } else {
            $_ | Out-File "$Content" -Append
        }
    }

    # Create the actual html page
    New-HTMLPage $Content $FileName $Title $Timestamp -Author $Script:global_author
    Remove-Item "$Content"
    If (!$DestinationFile) {
        return $FileName
    }
}

function New-BlogPost {
    # was write_entry
    [CmdLetBinding(SupportsShouldProcess, ConfirmImpact='High')]
    Param(
        [switch]$HTML,
        [Parameter(Position=0)][ValidateScript({Test-Path $_})]$FileName
    )
    
    Initialize-Blog
    $Fmt = If ( $HTML ) { 'html' } else { 'md' }
    If ($FileName) {
        $TMPFILE = Get-Item $FileName
        $Ext = $TMPFILE.Extension
        $Fmt = If ($Ext -eq '.md' -and !$HTML) {'md'}else{'html'}
    } else {
        $TMPFILE = ".entry-$(Get-Random).$Fmt"
        "Title on this line`n" | Out-File "$TMPFILE" -Append
        $To,$Tc,$Tf = If ($Fmt -eq 'html') { "<p>","</p>","<b>html</b>" } else {"","","**Markdown**"}
        "${To}The rest of the text file is an $Tf blog post. The process will continue as soon
as you exit your editor.$Tc

$To$Script:template_tags_line_header keep-this-tag-format, tags-are-optional, example$Tc" | Out-File "$TMPFILE" -Append
    }
    #chmod 600 "$TMPFILE"
    $PostStatus="E"
    While ($PostStatus -notmatch '[pP]') {
        If ($FileName) {Remove-Item $FileName}

        Start-Process $env:EDITOR "$TMPFILE" -Wait
        If ($Fmt -eq 'md') {
            $HtmlFromMd = New-HTMLFromMarkdown "$TMPFILE"
            $FileName = ConvertTo-BlogPost -SourceFile $HtmlFromMd
            Remove-Item $HtmlFromMd -Force
            Write-Verbose "Blog saved as $FileName"
        } else {
            $FileName = ConvertTo-BlogPost -SourceFile "$TMPFILE" # this command sets $filename as the html processed file
            Write-Verbose "Blog saved as $FileName"
        }
        If (!$Script:preview_url) { $Script:preview_url=$Script:global_url }
        "To preview the entry, open $Script:preview_url/$FileName in your browser"
        $PostStatus = Read-Host -Prompt "[P]ost this entry, [E]dit again, [D]raft for later? (p/E/d)"
        If ($PostStatus -match '[dD]') {
            New-Item -ItemType Directory -Name drafts -Force

            $Title = (Get-Content "$TMPFILE" -Head 1)
            If ($Script:convert_filename) { $Title=Invoke-Expression "Write-Output '$Title' | $Script:convert_filename" }
            If (!$Title) { $Title=Get-Random }
            $Draft = "drafts/$Title.$Fmt"
            Move-Item "$TMPFILE" $Draft
            Remove-Item $FileName
            Remove-Includes
            Write-Output "Saved your draft as '$Draft'"
            return 
        }
    }
    If ($Fmt -eq 'md' -and $Script:save_markdown) {
        $NewMDFileName = $FileName -replace '(.*?)\..*','$1.md'
        Write-Verbose "Keeping MD file as: $NewMDFileName"
        If (Test-Path $NewMDFileName) {
            Write-Warning "MD $NewMDFileName already exists. Replace?"
            If ($PSCmdlet.ShouldProcess($NewMDFileName, "Overwrite")) {
                Move-Item "$TMPFILE" ($FileName -replace '(.*?)\..*','$1.md') -Force
            }
        } else {
            Move-Item "$TMPFILE" ($FileName -replace '(.*?)\..*','$1.md')
        }
    } else {
        Remove-Item "$TMPFILE"
    }
    "Posted $FileName"
    $relevant_tags = Find-TagsInPost $FileName
    If ($relevant_tags) {
        $relevant_posts=(Find-PostsWithTags $relevant_tags)+$FileName
        Update-Tags -Posts $relevant_posts -Tags $relevant_tags
    }
    Exit-PwshBlog
}

function Update-AllPosts {
    [CmdLetBinding()]
    Param()
    # was all_posts
    Write-Progress -Activity "Creating index page with all posts" -Status "Getting posts" -PercentComplete 0
    $ContentFile = "$Script:archive_index.$(Get-Random)"
    While (Test-Path $ContentFile) {$ContentFile = "$Script:archive_index.$(Get-Random)"}
    Invoke-Command -ScriptBlock {
        "<h3>$Script:template_archive_title</h3>"
        $prev_month=$null
        $Posts = Get-ChildItem -Filter "*.html" | Sort-Object -Property LastWriteTime -Descending
        $i=0
        $prev_month=$null
        Foreach ($Post in $Posts) {
            $i=$i+1
            If (Test-BoilerplateFile $Post) { continue }
            Write-Progress -Activity "Creating index page with all posts" -Status "Post: $($Post.Name)" -PercentComplete ($i/$Posts.Count*100)
            # Month headers
            $month = Get-Date $Post.LastWriteTime -Format $Script:date_allposts_header
            If ($month -ne $prev_month) {
                If ($prev_month) { Write-Output "</ul>" }
                "<h4 class='allposts_header'>$month</h4>"
                "<ul>"
                $prev_month=$month
            }
            # Title
            $Title = Get-PostTitle $Post
            $Output = "<li><a href=`"$($Post.Name)`">$Title</a> &mdash;"
            $Date = Get-Date $Post.LastWriteTime -Format "$Script:date_format"
            "${Output}${Date}</li>"
        }
        "`n</ul>"
        "<div id=`"all_posts`"><a href=`"$Script:index_file`">$Script:template_archive_index_page</a></div>"
    } | Out-File $ContentFile

    New-HTMLPage "$contentfile" "$Script:archive_index.tmp" -Index -Title "$Scipt:global_title &mdash; $Script:template_archive_title"
    Move-Item "$Script:archive_index.tmp" "$Script:archive_index" -Force
    Remove-Item "$contentfile"
}

function Update-AllTags {
    # was all_tags
    Write-Progress -Activity "Creating an index page with all the tags" -Status "Reading tag files" -PercentComplete 0
    $i=0
    $ContentFile="${Script:tags_index}.$(Get-Random)"

    while (Test-Path $ContentFile) {
        $ContentFile="${Script:tags_index}.$(Get-Random)"
    }

    Invoke-Command -ScriptBlock {
        "<h3>${Script:template_tags_title}</h3>"
        "<ul>"
        $TagFiles = Get-ChildItem -Filter "${Script:prefix_tags}*.html"
        Foreach ($TagFile in $TagFiles) {
            $i=$i+1
            If (!(Test-Path $TagFile)) { break }
            $TagName=$TagFile.Name -replace "^${Script:prefix_tags}([^\.]*).*",'$1'
            Write-Progress -Activity "Creating an index page with all the tags" -Status "$TagName" -PercentComplete ($i/$TagFiles.Count*100)
            $NPosts = (Select-String '<!-- text begin -->' $TagFile).Count
            $Word = Switch ($NPosts) {
                1 {$Script:template_tags_posts_singular}
                {$_ -ge 2 -and $_ -le 4} {$Script:template_tags_posts_2_4}
                Default  {$Script:template_tags_posts}
            }
            "<li><a href=`"$($TagFile.Name)`">$TagName</a> &mdash; $NPosts $Word</li>"
        }
        "</ul>"
        "<div id=`"all_posts`"><a href=`"./$Script:index_file`">$Script:template_archive_index_page</a></div>"
    } | Out-File "$ContentFile"

    New-HTMLPage "$ContentFile" "${Script:tags_index}.tmp" -Index -Title "$Script:global_title &mdash; $Script:template_tags_title"
    Move-Item "${Script:tags_index}.tmp" "${Script:tags_index}" -Force
    Remove-Item "$contentfile" -Force
}

function Update-Index {
    [CmdLetBinding()]
    Param()

    # was rebuild_index
    Write-Verbose "Building the index"
    $NewIndexFile="${Script:index_file}.$(Get-Random)"
    $ContentFile="${NewIndexFile}.content"
    While (Test-Path $NewIndexFile -ErrorAction SilentlyContinue) {
        $NewIndexFile="${Script:index_file}.$(Get-Random)"
        $ContentFile="${NewIndexFile}.content"
    }
    # Create the content file
    Invoke-Command -ScriptBlock {
        $n=0
        $i=0
        $Posts = Get-ChildItem -Filter "*.html" | Sort-Object -Property LastWriteTime -Descending
        foreach ($Post in $Posts.Name) {
            $i=$i+1
            Write-Progress -Activity "Generating Index" -Status "Scanning $Post" -PercentComplete ($i/$Posts.count*100)
            If (Test-BoilerplateFile $Post) { continue }
            If ($n -ge $Script:number_of_index_articles) { break }
            If ($Script:cut_do) {
                Get-Content $Post | Get-HTMLFileContent "entry" "entry" -Cut |
                ForEach-Object {
                    If ($_ -match "$Script:cut_line") {
                        "<p class=`"readmore`"><a href=`"$($Post.Name)`">${Script:template_read_more}</a></p>"
                    } else {
                        $_
                    }
                }
            } else {
                Get-Content $Post | Get-HTMLFileContent "entry" "entry"
            }
            $n=$n+1
        }
    } | Out-File "$ContentFile"

    $Feed=$Script:blog_feed
    if ($Script:global_feedburner) { $Feed=$Script:global_feedburner }
    "<div id=`"all_posts`"><a href=`"$Script:archive_index`">$Script:template_archive</a> &mdash; <a href=`"$Script:tags_index`">$Script:template_tags_title</a> &mdash; <a href=`"$Feed`">$Script:template_subscribe</a></div>" | Out-File "$contentfile" -Append

    New-HTMLPage "$contentfile" "$newindexfile" -Index -Title "$Script:global_title"
    Remove-Item "$contentfile"
    Move-Item "$newindexfile" "$Script:index_file" -Force
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

function Update-Tags {
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
                        "<p class=`"readmore`"><a href=`"$($Post.Name)`">${Script:template_read_more}</a></p>"
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
    Param([string]$FileName)

    # was get_post_title
    $Ctx = Get-Content $FileName | Select-String `
        -Pattern '<h3><a class="ablack" href=".+">' `
        -Context 0,2
    $Ctx | Where-Object {$PSItem.Context.PostContext[1] -eq '</a></h3>'} |
    ForEach-Object {$PSItem.Context.PostContext[0]}
}

function Get-PostAuthor {
    Param([string]$FileName)

    # was get_post_author
    $Ctx = Get-Content $FileName | Select-String `
    -Pattern '<div class="subtitle">.+' `
    -Context 0,2
    $Ctx | Where-Object {$PSItem.Context.PostContext[1] -eq '</div>'} |
    ForEach-Object {$PSItem.Context.PostContext[0]}
}

function Get-BlogTags {
    [CmdletBinding()]
    Param([switch]$Sort)

    # was list_tags
    $TagFiles = Get-ChildItem -Filter "${Script:prefix_tags}*.html"

    If (!$TagFiles) { throw "No posts yet. Use New-BlogPost to create one" }
    $Objects = @()
    ForEach ($TagFile in $TagFiles) {
       If ($TagFile.PSIsContainer) { continue } 
       $NPosts = (Select-String '<!-- text begin -->' $TagFile).Count
       $TagName = $TagFile.Name -replace "${Script:prefix_tags}(.*?)\..*", '$1'
       $Object = [PSCustomObject]@{
           'Tag' = $TagName
           'PostCount' = [int]$NPosts
       }
       If (!$Sort) { $Object } else { $Objects += $Object }
    }
    If ($Sort) { $Objects | Sort-Object -Property PostCount }
}

function Get-BlogPosts {
    # was list_posts
    $PostFiles = Get-ChildItem -Filter "*.html" |
    Sort-Object -Property LastWriteTime -Descending

    If (!$PostFiles) { throw "No posts yet. Use New-BlogPost to create one" }
    
    ForEach ($PostFile in $PostFiles) {
        If (Test-BoilerplateFile $PostFile) { continue }
        [PSCustomObject]@{
            'Title' = Get-PostTitle $PostFile
            'Timestamp' = (Get-Date (Get-Item $PostFile).LastWriteTime -Format $Script:date_format) 
        }
    }

}

function Update-RSS {
    # was make_rss
}

function New-Includes {
    # was create_includes
    Write-Verbose "Crearing header and footer"
    Invoke-Command -ScriptBlock {
        "<h1 class=`"nomargin`"><a class=`"ablack`" href=`"$Script:global_url/$Script:index_file`">$Script:global_title</a></h1>" 
        "<div id=`"description`">$global_description</div>"
    } | Out-File ".title.html"

    if ($Script:header_file -and (Test-Path -Path $Script:header_file)) {
        Copy-Item "$Script:header_file" .header.html
    } else {
        Invoke-Command -ScriptBlock {
            '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
            '<html xmlns="http://www.w3.org/1999/xhtml"><head>'
            '<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />'
            '<meta name="viewport" content="width=device-width, initial-scale=1.0" />'
            $Script:css_include | ForEach-Object { "<link rel=`"stylesheet`" href=`"$_`" type=`"text/css`" />"}
            if (!$Script:global_feedburner) {
                $feed = $Script:blog_feed
            }
            "<link rel=`"alternate`" type=`"application/rss+xml`" title=`"$Script:template_subscribe_browser_button`" href=`"$feed`" />"
            }
        } | Out-File ".header.html"
    }

    if ($Script:footer_file -and (Test-Path -Path $Script:footer_file)) {
        Copy-Item "$Script:footer_file" .footer.html
    } else {
        Invoke-Command -ScriptBlock {
            $protected_mail=$Script:global_email -replace '@','&#64;'
            $protected_mail=$protected_mail -replace '\.','&#46;'
            "<div id=`"footer`">$Script:global_license <a href=`"$Script:global_author_url`">$Script:global_author</a> &mdash; <a href=`"mailto:$protected_mail`">$protected_mail</a><br/>"
            'Generated with <a href="https://github.com/cfenollosa/bashblog">bashblog</a>, a single bash script to easily create blogs like this one</div>'
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

function Update-BlogPosts {
    [CmdletBinding()]
    Param()
    # was rebuild_all_entries
    Write-Verbose "Building all entries"
    $HtmlFiles = Get-ChildItem -Filter "*.html"
    $i=0
    Foreach ($HtmlFile in $HtmlFiles) {
        $i=$i+1
        If (Test-BoilerplateFile $HtmlFile) { continue }
        $ContentFile = ".tmp.$(Get-Random)"
        While (Test-Path $ContentFile) { $ContentFile = ".tmp.$(Get-Random)" }
        Write-Progress -Activity "Rebuilding all entries" -Status "Rebuilding $($HtmlFile.Name)" -PercentComplete ($i/$HtmlFiles.Count*100)
        # Get the title and entry, and rebuild the html structure from scratch (divs, title, description...)
        $Title = Get-PostTitle $HtmlFile.Name
        Get-Content $HtmlFile | Get-HTMLFileContent 'text' 'text' | Out-File $ContentFile -Append
        # Read timestamp from post, if present, and sync file timestamp
        $Timestamp=Select-String "<!-- ${Script:date_inpost}: #(.+)# -->" $HtmlFile | ForEach-Object {
            Write-Verbose "Trying to set datetime with $($_.Matches.Groups[1].Value)"
            [DateTime]::ParseExact($_.Matches.Groups[1].Value,$Script:date_format_timestamp,$null)}
        If ($Timestamp) { 
            Write-Verbose "Found timestamp: $Timestamp on $($HtmlFile.Name)"
            Set-FileTimestamp -FileName $HtmlFile -Timestamp $Timestamp | Out-Null
        }
        # Read timestamp from file in correct format for 'create_html_page'
        $Timestamp = (Get-Date (Get-Item $HtmlFile).LastWriteTime -Format $Script:date_format_full) -replace '^([A-Z][a-z]{2})\w+,\s(\d\d\s\w{3}\s\d{4}\s\d\d:\d\d:\d\d)\s(.\d\d):(\d\d)','$1, $2$3$4'

        New-HTMLPage $ContentFile "$HtmlFile.rebuilt" -Title $Title -Timestamp $Timestamp -Author (Get-PostAuthor $HtmlFile)

        # keep the original timestamp!
        $timestamp = (Get-Item $HtmlFile).LastWriteTime
        Move-Item "$HtmlFile.rebuilt" "$HtmlFile" -Force
        Set-FileTimestamp -FileName $HtmlFile -Timestamp $Timestamp | Out-null
        Remove-Item $ContentFile -Force
    }
    Write-Progress -Activity "Rebuilding all entries" -Status "Finished" -Completed
}

function Reset-BlogSite {
    [CmdLetBinding(SupportsShouldProcess, ConfirmImpact='High')]
    Param()

    # was reset
    If ($PSCmdlet.ShouldProcess("All html, css and rss files", "Delete")) {
        '.*.html', '*.html', '*.css', '*.rss' |
        ForEach-Object {
            Remove-Item $_ -Force
        }
    }

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

function Update-BlogSite {
    [CmdLetBinding()]
    Param()
    Initialize-Blog
    Update-BlogPosts
    Update-Tags
    Exit-PwshBlog
}

function Remove-BlogPost {
    [CmdLetBinding(SupportShouldProcess, ConfirmImpact='High')]
    Param([System.IO.FileInfo]$File)
    Initialize-Blog
    If ($PSCmdlet.ShouldProcess($File.Name, "Remove Blog post")) {
        Remove-Item $File
        Update-Tags
    }
    Exit-PwshBlog
}

function ConvertFrom-BBConfig {
    [CmdLetBinding()]
    Param(
        [ValidateScript({Test-Path $_})]
        [Parameter(Mandatory=$True)]
        [System.IO.FileInfo]$ConfigFile
    )

    function Test-EvenQuotes {
    [CmdLetBinding()]
        Param($Value)
        # Test if the value has an even number of quotes. Return the string stripped of the final one if so.
        $NewValue = '"',"'" | %{
            $Count = $Value.Split($_).Count - 1
            If ($Count -gt 0 -and [int]($Count/2) -ne $Count/2) { 
                $Value -replace "(.*?)${_}.*",'$1' 
            }
        }
        If ($NewValue) { return $NewValue } else { return $Value }
    }

    $HT = @{}
    Get-Content $ConfigFile | ForEach-Object {
        If ($_ -match '^[^#]\w+=.+') {
            $Value = ($_ -replace '.*?=(.*)','$1').Trim('" ')
            $Value = Test-EvenQuotes $Value
            $HT.Add($_.Split('=')[0],$Value)
        }
    }
    $HT
}

function New-BlogConfig {
    [CmdLetBinding(SupportsShouldProcess)]
    Param()

    Import-Config

    # Check if a config exists
    If (Test-Path -Path .config) {
        #Is is a bb file
        $config = Get-Content "$Script:global_config" | Out-String
        If (!(Test-Config $config)) {
            ## version detected. Offer to upgrade
            $i = $null
            Write-Output "An existing BashBlog config has been detected"
            While ($i -notmatch '[urc]') {
                $i = Read-Host "[U]pgrade config file, [R]eplace with defaults, [C]ancel? (u/R/c)"
            }
            If ($i -eq 'c') { break }
            If ($u -eq 'u') {

                $Settings = ConvertFrom-BBConfig "$Script:global_config" | ConvertTo-PwshConfig 

            } else {

                # Get a list of variables from this module
                #
                $Settings = Get-Options | %{ ('$Script:{0}={1}' -f $_.Name,$_.Value) }
            }

            If ($PSCmdlet.ShouldProcess(".config","Overwrite")) {
                Set-Content "$Script:global_config" -Value ""
                $Settings | Out-File -Path "$Script:global_config" -Append
            } else {
                $Settings
            }
        }

    }

}

function Get-Options {
    'global_software_name','global_software_version','global_title','global_description','global_url','global_author','global_author_url','global_email','global_license','global_analytics','global_analytics_file','global_feedburner','global_twitter_username','global_twitter_cookieless','global_twitter_search','global_disqus_username','index_file','number_of_index_articles','archive_index','tags_index','non_blogpost_files','blog_feed','number_of_feed_articles','cut_do','cut_tags','cut_line','save_markdown','prefix_tags','header_file','footer_file','body_begin_file','body_end_file','css_include','html_exclude','template_comments','template_read_more','template_archive','template_archive_title','template_tags_title','template_tags_posts','template_tags_posts_2_4','template_tags_posts_singular','template_tag_title','template_tags_line_header','template_archive_index_page','template_subscribe','template_subscribe_browser_button','template_twitter_button','template_twitter_comment','date_format','date_locale','date_inpost','date_format_full','date_format_timestamp','date_allposts_header','convert_filename','preview_url' | ForEach-Object { [PSCustomObject]@{'Name'=$_;'Value'=Get-DefaultSetting $_ } }
    }

function Get-DefaultSetting {
    Param($Name)
    $v=Invoke-Expression "`$Script:$Name"
    If ($v -is [string]) {
        "`"$v`""
    } elseif ($v -is [array]) {
       "$($v|%{$_})" -replace '^(.*)$','@($1)' -replace ' ',','
    } else {
       "@()"
    }

}

function ConvertTo-PwshConfig {
    [CmdLetBinding(SupportsShouldProcess, ConfirmImpact='High')]
    Param(
        [Parameter(ValueFromPipeline=$True)]$Settings
    )
    Begin {
        $HT=@{}
        Import-Config
        $Incompatible = 'convert_filename','date_format','date_format_timestamp','date_format_full','date_allposts_header','date_format_timestamp'
    }

    Process {
        $Settings.Keys | ForEach-Object {
            $Value = Switch ($_) {
                'markdown_bin' {Write-Verbose "Markdown_bin not needed, stripping setting"}
                'date_locale' {Write-Verbose "Markdown_bin not needed, stripping setting"}
                {$_ -in $Incompatible} { 
                    Get-DefaultSetting $_
                    Write-Warning "$_ value cannot be converted from bb. Resetting to Pwsh default."
                }
                Default {
                    $Value = $Settings[$_]
                    if ($Value -match '^\(') {
                        $Value.Trim('()').Replace(' ',',')  
                    } else { "`"$Value`"" }
                }
            }
            $HT.Add($_,$Value)
        }
        
    }
    End {
        $HT
    }
}

function Import-Config {
    [CmdLetBinding()]
    Param()
    If (!$Script:global_software_name){
        Get-GlobalVariables
        If (Test-Path "$Script:global_config") {
            $config = Get-Content "$Script:global_config" | Out-String
            If (Test-Config $config) {
                Write-Verbose "Configuration valid. Importing "
                Invoke-Expression $config
            } else {
                Write-Verbose "Invalid configuration detected."
            }
        }
        Test-GlobalVariables
    }
}

function Test-Config {
    [CmdLetBinding()]
    Param([string]$config)
    If ($config -match '^global') {
        Write-Verbose "Bash style variables detected in config"
        return $False
    } elseif ($config -match '^$Script:global') {
        Write-Verbose "Powershell style variables detected in config"
        return $True
    } else {
        Write-Verbose "Something went wrong with the configuration file"
        return $False
    }
}

function Initialize-Blog {
    [CmdLetBinding()]
    Param()
    Write-Verbose "Running version $global_software_version"
    Import-Config
    New-CSS
    New-Includes
}

function Exit-PwshBlog {
    [CmdLetBinding()]
    Param()
    Update-Index
    Update-AllPosts
    Update-AllTags
    Update-RSS
    Remove-Includes
}

Export-ModuleMember New-BlogPost
Export-ModuleMember Edit-BlogPost
Export-ModuleMember Get-BlogPosts
Export-ModuleMember Get-BlogTags
Export-ModuleMember Remove-BlogPost
Export-ModuleMember Update-BlogSite
Export-ModuleMember New-BlogConfig
Export-ModuleMember Reset-BlogSite 

# vim: set shiftwidth=4 tabstop=4 expandtab:
