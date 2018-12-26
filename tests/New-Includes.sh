#!/bin/bash

check_tst() {
    echo -n "${1}: "
    if diff f1 f2>/dev/null; then
        echo Passed
        rm f1 f2
    else
        echo Failed
        mv f1 f1.old
        mv f2 f2.old
    fi
}


    global_author_url="http://twitter.com/example" 
    global_url="http://example.com/blog"
    global_title="My fancy blog"
    index_file="index.html"
    global_description="A blog about turtles and carrots"
    global_feedburner=""
    css_include=()
    template_subscribe_browser_button="Subscribe to this page..."
    blog_feed="feed.rss"
    global_email="john@smith.com"
    global_author="John Smith"
    global_license="CC by-nc-nd"

create_css() {
    # To avoid overwriting manual changes. However it is recommended that
    # this function is modified if the user changes the blog.css file
    (( ${#css_include[@]} > 0 )) && return || css_include=('main.css' 'blog.css')
    if [[ ! -f blog.css ]]; then 
        # blog.css directives will be loaded after main.css and thus will prevail
        echo '#title{font-size: x-large;}
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
        #twitter{line-height:20px;vertical-align:top;text-align:right;font-style:italic;color:#333;margin-top:24px;font-size:14px;}' > blog.css
    fi

    # If there is a style.css from the parent page (i.e. some landing page)
    # then use it. This directive is here for compatibility with my own
    # home page. Feel free to edit it out, though it doesn't hurt
    if [[ -f ../style.css ]] && [[ ! -f main.css ]]; then
        ln -s "../style.css" "main.css" 
    elif [[ ! -f main.css ]]; then
        echo 'body{font-family:Georgia,"Times New Roman",Times,serif;margin:0;padding:0;background-color:#F3F3F3;}
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
        blockquote iframe{margin:12px 0px;}' > main.css
    fi
}



create_includes() {
    header_file="$1"
    footer_file="$2"
    {
        echo "<h1 class=\"nomargin\"><a class=\"ablack\" href=\"$global_url/$index_file\">$global_title</a></h1>" 
        echo "<div id=\"description\">$global_description</div>"
    } > ".title.html"

    if [[ -f $header_file ]]; then cp "$header_file" .header.html
    else {
        echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
        echo '<html xmlns="http://www.w3.org/1999/xhtml"><head>'
        echo '<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />'
        echo '<meta name="viewport" content="width=device-width, initial-scale=1.0" />'
        printf '<link rel="stylesheet" href="%s" type="text/css" />\n' "${css_include[@]}"
        if [[ -z $global_feedburner ]]; then
            echo "<link rel=\"alternate\" type=\"application/rss+xml\" title=\"$template_subscribe_browser_button\" href=\"$blog_feed\" />"
        else 
            echo "<link rel=\"alternate\" type=\"application/rss+xml\" title=\"$template_subscribe_browser_button\" href=\"$global_feedburner\" />"
        fi
        } > ".header.html"
    fi

    if [[ -f $footer_file ]]; then cp "$footer_file" .footer.html
    else {
        protected_mail=${global_email//@/&#64;}
        protected_mail=${protected_mail//./&#46;}
        echo "<div id=\"footer\">$global_license <a href=\"$global_author_url\">$global_author</a> &mdash; <a href=\"mailto:$protected_mail\">$protected_mail</a><br/>"
        echo 'Generated with <a href="https://github.com/cfenollosa/bashblog">bashblog</a>, a single bash script to easily create blogs like this one</div>'
        } >> ".footer.html"
    fi
}

pst() {
    pwsh -NoLogo -Command "&{
        import-module ../../src/BlogPost; 
        New-Includes
    }"
}

mkdir tmp1
cd tmp1

rm .title.html
rm .header.html
rm .footer.html

create_css
create_includes

cd ..
mkdir tmp2
cd tmp2
rm .title.html
rm .header.html
rm .footer.html
pst

cd ..

if diff tmp1/.title.html tmp2/.title.html > /dev/null; then 
    echo "Title Passed"
else
    echo "Title failed"
fi

if diff tmp1/.header.html tmp2/.header.html > /dev/null; then 
    echo "Header Passed"
else
    echo "Header failed"
fi

if diff tmp1/.footer.html tmp2/.footer.html > /dev/null; then 
    echo "Footer Passed"
else
    echo "Footer failed"
fi

