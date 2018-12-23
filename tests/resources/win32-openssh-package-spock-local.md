Win32 OpenSSH Package

#### Update 20/09/2018

Updated the script to UseBasicParsing so it works on Server core out of the box.
Also, if you have to allow the port on Windows Firewall:

`New-NetFirewallRule -DisplayName "Allow SSH" -Direction Inbound -LocalPort 22 -Protocol TCP -Action Allow`

#### Update 11/09/2018

I've made a copy of this [script][1] which downloads the dependencies (including
PSCore. Also of note, on a machine I ran it on, I had to set the allowed .Net
TLS modes before it would let me download from github.

`[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"` 

---

I've recently been using Macos at work in order to share 
admin responsibilities across the team. Still suppporting Windows, however 
there are a couple of tools I use to make working Windows from a Mac 
simpler. 

## PowerShell

Microsoft Open-Sourced PowerShell in [2016](https://azure.microsoft.com/en-us/blog/powershell-is-open-sourced-and-is-available-on-linux/) and today
in 2018, you can get stable installations for Macos, Linux and Windows on
[github](https://github.com/Powershell/Powershell) which is often referred
to as PSCore.

As an aside, this new version of powershell is not nativly backward 
compatible with compiled binary modules of the previous "Windows Powershell",
however recently in development is a new module:
[WindowsCompatibility](https://github.com/PowerShell/WindowsCompatibility)
(currently only available on Windows Insider builds) that allows your to
import "Windows Powershell" modules into PSCore.

When alpha and beta builds first became available I started testing remote
sessions from Linux and Macos to Windows (As I would prefer to work from a
unix system at work), but quickly found that the native "Enter-PSSession"
wasn't supported from PSCore.

## OpenSSH

Around the same time, Microsoft began working with the OpenBSD's OpenSSH
project to bring official OpenSSH builds to Windows and the PSCore team
found a way to make "Enter-PSSession" work with this.

## Packaging PSCore

Packaging PSCore is very straightforward and I won't go into detail here.
Suffice it to say that PSCore is released as an
[MSI](https://en.wikipedia.org/wiki/Windows_Installer) and these are very
simple to deploy using tools like [Configuration Manager](aka.ms/sccm).

## OpenSSH Package

Essentially I created a Windows Powershell script which follows the
installation directions on the Win32 OpenSSH github [Installation](github.com/PowerShell/Win32-OpenSSH/wiki/Install-Win32-OpenSSH) page. 

### The Scripts

Deploying an application using scripts in Configuration Manager, usually
requires 3 scripts, and this case is no exception. I have provided the all
needed scripts below:

#### Install.ps1

    [CmdLetBinding()]
    Param()

    #region Helper functions
    function Get-Path {
        [CmdLetBinding()]
        Param(
            [ValidateSet(
                "Machine",
                "User"
            )]$Context = "User",
            [Switch]$Raw
        )
        If ($Context -eq "Machine") {
            $Root = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'
        } else {
            $Root = 'HKCU:'
        }
        If ($Raw){
            Get-ItemPropertyValue -Path "$Root\Environment" -Name Path
        } Else {
            Try {

                (Get-ItemPropertyValue -Path "$Root\Environment" `
                    -Name Path -EA SilentlyContinue) -split ';'
            } Catch {
                Write-Warning "No user environment variables found"
            }
        }
    }

    function Add-Path {
        [CmdLetBinding()]
        Param(
            [Parameter(Mandatory=$True)]
            [ValidateScript({
                if (Test-Path -Path $_) {
                    $True
                } else {
                    throw "Unable to validate path $_"
                }
                })]$Path,
            [ValidateSet(
                "Machine",
                "User"
            )]$Context
        )

        Write-Verbose "Adding $Path to environment"
        if ($Context -eq 'Machine') {
            If (! $Path -in (Get-Path -Context Machine)){
                Write-Verbose "Adding $Path to machine context"
                setx /m PATH "$(Get-Path -Context Machine -Raw);$Path"
            }
        } else {
            Write-Verbose "Adding $Path to user context"
            If (! $Path -in (Get-Path -Context User)){
                Write-Verbose "Adding $Path to user context"
                setx PATH "$(Get-Path -Context Use -Raw);$Path"
            }
        }
    }

    function New-SymbolicLink {
    Param($Link,$Target)
        If (-Not (Test-Path -Path $Link)){
            If ((Get-Item $Target).PSIsContainer) {
                cmd.exe /c mklink /D $Link $Target
            } Else {
                cmd.exe /c mklink $Link $Target
            }
        }
    }
    #endregion

    # Extract OpenSSH
    $Archive = Get-ChildItem -Filter *.zip
    Expand-Archive -Path $Archive -DestinationPath $env:ProgramFiles
    Rename-Item -Path $Env:ProgramFiles\OpenSSH-Win64 -NewName OpenSSH

    #Add InstallDir to Path
    Add-Path -Path $Env:ProgramFiles\OpenSSH -Context Machine -Verbose

    # Configure OpenSSH
    & $Env:ProgramFiles\OpenSSH\install-sshd.ps1

    # Start sshd service

    Start-Service -Name sshd

    # Set service startup

    Set-Service sshd -StartupType Automatic
    Set-Service ssh-agent -StartupType Automatic

    # Setup pwsh link to work around 
    # https://github.com/PowerShell/Win32-OpenSSH/issues/784
    # Find PSCore Install and Make symbolic link

    $PSCoreDir = Get-ChildItem -Path $env:ProgramFiles\PowerShell `
        -Directory | Select-Object -Last 1
    New-SymbolicLink -Link $env:SystemDrive\pwsh -Target $PSCoreDir.FullName

    # Enable Password Authentication and set pwsh as default shell
    $NewConfig = Get-Content -Path $Env:ProgramData\ssh\sshd_config | 
        ForEach-Object {
        Switch ($_) {
            {$_ -match '^#PasswordAuthentication\syes'} {$_.replace('#','')}
            {$_ -match '^#PubkeyAuthentication\syes'} {$_.replace('#','')}
            {$_ -match '^Subsystem\s+sftp\s+'} {
                'Subsystem    powershell c:\pwsh\pwsh.exe -sshs -NoLogo -NoProfile'
            }
            Default {$_}
        }
    }
    # Update sshd config
    Set-Content -Path $Env:ProgramData\ssh\sshd_config -Value $NewConfig `
        -Force

    # Restart sshd
    Restart-Service sshd 

#### Uninstall.ps1

    [CmdLetBinding()]
    Param()

    #region Helper functions

        function Remove-SymbolicLink {
    Param($Link,$Target)
        If (Test-Path -Path $Link){
            If ((Get-Item $Target).PSIsContainer) {
                cmd.exe /c rmdir $Link
            
            } Else {
                cmd.exe /c del $Link
            
            }
        
        }

        }

    function Get-Path {
        [CmdLetBinding()]
            Param(
                    [ValidateSet(
                "Machine",
                "User"
            
                        )]$Context = "User",
            [Switch]$Raw
        
                 )
                If ($Context -eq "Machine") {
            $Root = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'
        
                } else {
            $Root = 'HKCU:'
        
                }
        If ($Raw){
            Get-ItemPropertyValue -Path "$Root\Environment" -Name Path
        
        } Else {
            Try {

                (Get-ItemPropertyValue -Path "$Root\Environment" `
                    -Name Path -EA SilentlyContinue) -split ';'
            
            } Catch {
                Write-Warning "No user environment variables found"
            
            }
        
        }

    }

    function Remove-Path {
        [CmdLetBinding()]
            Param(
            [Parameter(Mandatory=$True)]
            $Path,
            [ValidateSet(
                "Machine",
                "User"
            
                )]$Context
        
                 )

        Write-Verbose "Removing $Path from environment"
        if ($Context -eq 'Machine') {
            If ($Path -in (Get-Path -Context Machine)){
                Write-Verbose "Removing $Path from machine context"
                $NewPath = ""
                Get-Path -Context Machine | Where-Object {
                    $psItem -ne $Path -and
                    $psItem -ne ""
                
                } ForEach-Object {
                        $NewPath += "$psItem;"
                
                }
                setx /m PATH "$NewPath"
            
            }
        
        } else {
            Write-Verbose "Removing $Path from user context"
                If ($Path -in (Get-Path -Context User)){
                Write-Verbose "Removing $Path from user context"
                $NewPath = ""
                Get-Path -Context User | Where-Object {
                    $psItem -ne $Path -and
                    $psItem -ne ""
                
                } ForEach-Object {
                        $NewPath += "$psItem;"
                
                }
                setx PATH "$NewPath"
            
                }
        
        }

    }

    #endregion

    & $Env:ProgramFiles\OpenSSH\uninstall-sshd.ps1

    # Extract OpenSSH
    Remove-Item -Path $env:ProgramFiles\OpenSSH -Recurse -Force
    Remove-Path -Path $env:ProgramFiles\OpenSSH -Context Machine -Verbose

    # Find PSCore Install and remove symbolic link

    $PSCoreDir = Get-ChildItem -Path $env:ProgramFiles\PowerShell -Directory | Select-Object -Last 1
    Remove-SymbolicLink -Link $env:SystemDrive\pwsh -Target $PSCoreDir.FullName

    # Remove old config
    Remove-Item -Path $env:ProgramData\ssh -Recurse -Force

#### Detect.ps1

    $AssumeInstalled = $True

    If (-Not (Test-Path $Env:ProgramFiles\OpenSSH)) {
        $AssumeInstalled = $False

    }

    If (-Not (Test-Path $Env:SystemDrive\pwsh)) {
        $AssumeInstalled = $False

    }

    If (-Not (Get-Service sshd -ErrorAction SilentlyContinue)) {
        $AssumeInstalled = $False

    }

    If ($AssumeInstalled) {
        Write-Output "True"

    }

## Using OpenSSH with Powershell

Now that I have used these scripts to deploy OpenSSH and PSCore, I can
PSRemote to a PC using my Mac.

The old way to use "Enter-PSSession" was by specifying the ComputerName
parameter like so:

    PS\> Enter-PSSession -ComputerName Blah

However, when using OpenSSH with a PS Session you do the following:

    PS\> Enter-PSSession -HostName Blah -UserName MrBlah

You could also setup a session in a variable and resue it multiple times
in a session:

    PS\> $s = New-PSSesssion -HostName Blah -UserName MrBlah
    PS\> Enter-PSSession -Session $s

    [Blah] PS\>

I hope you have found this usefull.

Tags: powershell, pscore, openssh, windows, macos

[1]: scripts.html
