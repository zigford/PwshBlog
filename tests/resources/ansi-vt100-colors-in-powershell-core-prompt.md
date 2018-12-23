ANSI VT100 colors in Powershell Core prompt

Sometime ago I was searching the interwebs for inspiration to spruce up my
powershell prompt. I came across someone's prompt they shared on 
[stackoverflow][1] or [superuser][2] and unfortunatly I could not find the link
again to give proper credit.

---

Today, I'm essentially using the same prompt but I've had to adjust it to work
on [Windows][3] and [MacOS][4] with the two areas of compatability being that
Windows uses backslash `\` and Unixes like [GNU/Linux][5] and MacOS use
forwardslash `/`.

With Windows powershell, in order to get colorized text, you had to use the 
`Write-Host` commandlet, but when switching to PSCore, the same code produced
strange results. Initially the prompt would look fine, but if you were in a
deep path, as soon as you typed a key, much of the prompt would be overwritten
or word or some letters would be duplicated.

After a bit of research I found the Windows Console had had VT100 escape
sequence support added. You could, in theory, enable any Windows 10 1607+ 
console to support VT100, but you would need to use the WinAPI
[SetConsoleMode][6]

It turns out, that PSCore on Windows, does this very thing, and so without any
extra work, VT100 escape sequences work out of the box on this.

        function ConvertTo-ShortPath {
            Param([string]$Path)
            # Replace Home with ~ symbol
            $Location = $Path.Replace($HOME, '~')
            # Remove prefix for UNC paths
            $Location = $Location -replace '^[^:]+::', ''
            # Handle paths starting with \\ and . correctly
            # For paths not the current directory, display only a single
            #   character for each directory in the tree
            If ($IsMacOS -or $IsLinux) {
                # Systems with / paths 
                $Location = $Location -replace '(.?)([^/])[^/]*(?=/)','$1$2'
            } else {
                # Systems with \ paths
                $Location = $Location -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2'
            }
            return $Location
        }

        function prompt {
            If ($PSEdition -eq "Core") {
                $BC = "`e[96m" #Bright Cyan
                $C = "`e[36m" #Cyan
                $G = "`e[32m" #Green
                $N = "`e[0m" #No Color
            } else {
                $C = [ConsoleColor]::DarkCyan
                $G = [ConsoleColor]::Green
                $BC = [ConsoleColor]::Cyan
            }

            $root = [char]0x0E3
            $nonroot = [char]0x0A7
            $H = $([net.dns]::GetHostName()) 
            
            if (Test-CurrentAdminRights) {
                $priv = $root
            } else {
                $priv = $nonroot
            }

            if ($PSEdition -eq "Core"){
                # PSCore doesn't like a prompt using Write-Host
                #   thankfully, using VT100 signals works fine
                "${BC}${priv} $G$H $C{ $BC$(ConvertTo-ShortPath ((pwd).Path)) $C }$N "
            } else {
                Write-Host "$priv " -NoNewline -ForegroundColor $BC
                Write-Host $H -NoNewline -ForegroundColor $G
                Write-Host ' {' -NoNewline -ForegroundColor $C
                Write-Host (ConvertTo-ShortPath (pwd).Path) -NoNewline -ForegroundColor $BC
                Write-Host '}' -NoNewline -ForegroundColor $C
                return ' '
            }
        }

Tags: vt100, powershell, profile

[1]:https://stackoverflow.com
[2]:https://superuser.com
[3]:windows.html
[4]:macos.html
[5]:gnu-linux.html
[6]:https://docs.microsoft.com/en-us/windows/console/setconsolemode
