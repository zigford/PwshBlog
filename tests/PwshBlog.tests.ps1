Import-Module (Join-Path -Path (Split-Path -Path $PSScriptRoot -Parent) `
    -ChildPath PwshBlog.psm1)

function New-TestPath {
    $TEMP = if ($IsMacOS -or $IsLinux -and $ENV:TMPDIR) {
        $ENV:TMPDIR
    } elseif ($IsLinux -and (Test-Path '/tmp')) {
        '/tmp'
    } elseif ($IsLinix -and (Test-Path '/var/tmp')) {
        '/var/tmp'
    } else {
        $ENV:TEMP
    }
    return (New-Item -ItemType Directory -Path $TEMP -Name (Get-Random))
}

function Get-Editor {
    # Get an editor which does nothing
    # on *nix or Windows
    if ($IsMacOS -or $IsLinux) {
        return '/bin/true'
    } else {
        return 'c:\windows\system32\icacles.exe'
    }
}


function New-TestEnvironment {
    $Script:TestRoot = New-TestPath
    Push-Location
    Set-Location $Script:TestRoot
}

function Remove-TestEnvironment {
    Pop-Location
    Remove-Item $Script:TestRoot -Force -Recurse
}

Describe "New-BlogConfig" {
    New-TestEnvironment
    It "makes a new config file" {
        New-BlogConfig
        Test-Path .config | should be $True
    }
    Remove-TestEnvironment
}

Describe "New-BlogPost" {
    New-TestEnvironment
    $EDITOR=$ENV:EDITOR
    $ENV:EDITOR = Get-Editor
    It "Creates a new html post" {
        # New-BlogConfig
        New-BlogPost -Force -Confirm:$False -WarningAction 'SilentlyContinue'|
        Out-Null
        $i=0
        $ComparePost = Get-Content $PSScriptRoot\title-on-this-line.html
        Get-Content title-on-this-line.html | ForEach-Object {
            If (
                    $_ -notmatch 'bashblog_timestamp' -and
                    $_ -notmatch 'subtitle'
               )
            {
                $_ | Should be $ComparePost[$i]
                $i++
            } else { $i++ }
        }
    }
    $ENV:EDITOR = $EDITOR
    Remove-TestEnvironment
}

Remove-Module PwshBlog
