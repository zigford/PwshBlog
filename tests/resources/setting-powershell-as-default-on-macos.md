Setting Powershell as default on MacOS

When you click on 'Terminal.app' on a stock MacOS system, your connected to
the systems pseudo TTY which in turn launches your users default shell.

Terminal.app can be told to launch a process other than your users default
shell (eg, powershell), but there are a few cases where if you might want 
to replace your shell system-wide. (eg, sudo can use powershell then)

---

### Step 1

To do this, you first need to add powershell as an available system shell.
This is done by adding the path to the powershell binary into `/etc/shells`.

From bash you can do this:

        $ which pwsh | sudo tee -a /etc/shells

Or from an elevated pwsh:

        PS> (Get-Command pwsh).Source | Add-Content /etc/shell

The end result is that your /etc/shells file should look something like this:

        $ cat /etc/shells
        # List of acceptable shells for chpass(1).
        # Ftpd will not allow users to connect who are not using
        # one of these shells.

        /bin/bash
        /bin/csh
        /bin/ksh
        /bin/sh
        /bin/tcsh
        /bin/zsh
        /usr/local/microsoft/powershell/6/pwsh

### Step 2

The next step is to set your accounts shell. Do this interactivly by running
`chsh` or `chpass` (they are both the same binary). You can set the `Shell:`
parameter to the path to pwsh. You could also do this non-interactivly in 
bash:

        $ chsh -s `which pwsh`

Or via powershell

        PS> chsh -s "$((Get-Command pwsh).Source)"

### Step 3

Powershell is now the default shell, but we are not finished yet. When bash
is launched on macOS, the first thing executed is /etc/profile. In the
profile `/usr/libexec/path_helper` is executed which sets up the PATH
environment variable. Powershell doesn't do this so we need to setup a quick
function in our powershell profile to do a similar process.

#### Create a powershell profile

        PS> New-Item -ItemType Directory -Path (Split-Path -Path $profile -Parent) -force
        PS> New-Item -ItemType File -Path $profile

#### Contents of profile

        function Get-Path {
            [CmdLetBinding()]
            Param()
            $PathFiles = @()
            $PathFiles += '/etc/paths'
            $PathFiles = Get-ChildItem -Path /private/etc/paths.d | Select-Object -Expand FullName
            $PathFiles | ForEach-Object {
                Get-Content -Path $PSItem | ForEach-Object {
                    $_
                }
            }
            $Paths
        }

        function Add-Path {
            Param($Path)
            $env:PATH = "${env:PATH}:$Path"
        }

        function Update-Environment{
            [CmdLetBinding()]
            Param()
            $Paths = $env:PATH -split ':'
            Get-Path | ForEach-Object {
                If ($PSItem -notin $Paths) {
                    Write-Verbose "Adding $PSItem to Path"
                    Add-Path -Path $PSItem
                }
            }
        }

        Update-Environment

## Warning

Although I've been running with this configuration for a few months, I'm not
 sure doing this is excatly advisable. Some apps may be written to
assume that bash is the default on MacOS. VSCode for example may give some
greif.

Your mileage may vary.

Tags: powershell, macos
