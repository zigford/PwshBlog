Import-Module PwshBlog

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

Describe "New-BlogConfig" {
    It "makes a new config file" {
        New-BlogConfig
        Test-Path .config | should be $True
    }
    Remove-Item .config -Force
}

Describe "New-BlogPost" {
    $TestRoot = New-TestPath
    Push-Location
    Set-Location $TestRoot
    $EDITOR=$ENV:EDITOR
    $ENV:EDITOR = 'true '
    It "Creates a new html post" {
        # New-BlogConfig
        New-BlogPost -Force -Confirm:$False -WarningAction 'SilentlyContinue'|
        Out-Null
        $Result = If (
            Compare-Object `
            (Get-Content title-on-this-line.html) `
            (Get-Content $PSScriptRoot\title-on-this-line.html) |
            Where-Object {$_.InputObject -notmatch 'bashblog_timestamp'}
           ) {
            "Post content does not match example"
        } else {
            "Post content matches examples"
        }
        $Result | Should be "Post content matches examples"
    }
    $ENV:EDITOR = $EDITOR
    Pop-Location
    Remove-Item $TestRoot -Force -Recurse
}
Reset-BlogSite -Confirm:$False
Remove-Module PwshBlog
