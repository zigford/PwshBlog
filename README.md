[![Master build status][appveyor-badge]][appveyor-build]

PwshBlog
========

A single Powershell script to create blogs. 

I've ported [BashBlog](https://github.com/cfenollosa/bashblog) to Powershell as a holiday fun excersize. I use BashBlog to run my site [zigford.org](http://zigford.org), but spend most of my time in PowerShell for my day job, so thought it might be interesting to learn more about bash an powershell at once.

Currenlty you can create new posts, edit posts, rebuild the site. Not implemented yet
is updating the RSS feed and twitter cards. Everything was written to maintain compatibility with BashBlog and I would consider this a port rather than a rewrite.


Usage
-----

Download the code and copy the PwshBlog directory into your modules path.

    Import-Module PwshBlog
    New-BlogConfig -Whatif
    Edit-BlogPost ./happy-new-year-2019.md
    New-BlogPost
    Get-BlogPosts

Features
--------

- Ultra simple usage: Just type a post with your favorite editor and the script does the rest. No templating.
- No installation required. Download `PwshBlog` and start blogging.
- Zero dependencies. It runs just on pure Powershell.
- GNU/Linux, OSX and Windows compatible out of the box as long as powershell 6.1+ is installed
- All content is static. You only need shell access to a machine with a public web folder.
- Support for tags/categories
- Support for Markdown

Coming soon
-----------

Disqus comments, Twitter, Feedburner, Google Analytics.

Configuration
-------------

Configuration is not required for a test drive, but if you plan on running your blog with pwshblog, you will
want to change the default titles, author names, etc, to match your own.

There are two ways to configure the blog strings:

- Edit `PwshBlog.psm1` and modify the variables in the `Get-GlobalVariables` function
- Create a `.config` file with your configuration values -- useful if you don't want to touch the script and be able to update it regularly with git

The software will load the values in the script first, then overwrite them with the values in the `.config` file.
This means that you don't need to define all variables in the config file, only those which you need to override
from the defaults.

The format of the `.config` file is just one `$Script:variablename="value"`
per line, just like in the `Get-GlobalVariables` function.
You can also create a default one using: `New-BlogConfig`

PwshBlog uses the `$EDITOR` environment value to open the text editor.

Examples:

`$ENV:EDITOR = 'C:\windows\system32\notepad.exe'`
or
`$ENV:EDITOR = '/usr/bin/vim'`


Detailed features
-----------------

- A simple but nice and readable design, with nothing but the blog posts
- Uses PowerShell built-in ConvertFrom-Markdown
- Currently in implementation phase, so more features will be added


License
-------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

[appveyor-badge]: https://ci.appveyor.com/api/projects/status/x50f93ji0xons8os/branch/master?svg=true
[appveyor-build]: https://ci.appveyor.com/project/zigford/pwshblog/
