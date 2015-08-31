$dnvmVersion = "1.0.0-beta6";
$buildNumber = 0;
$preRelease = $null;

if ($env:APPVEYOR_BUILD_NUMBER) {
    $buildNumber = $env:APPVEYOR_BUILD_NUMBER
}

if ($env:preRelease) {
    Write-Output "Setting Prerelease: $env:preRelease"
    $preRelease = $env:preRelease
}

if ($env:APPVEYOR) {
    
    Write-Output "Building branch: $env:APPVEYOR_REPO_BRANCH"

    if ($env:APPVEYOR_REPO_TAG) {
        Write-Output "Building tag: $env:APPVEYOR_REPO_TAG_NAME"
    }
    else {
        Write-Output "No tag applied to build"
    }
}

function Install-Dnvm
{
    & where.exe dnvm 2>&1 | Out-Null
    if($LASTEXITCODE -ne 0)
    {
        Write-Host "DNVM not found"
        &{$Branch='dev';iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.ps1'))}

        # Normally this happens automatically during install but AppVeyor has
        # an issue where you may need to manually re-run setup from within this process.
        if($env:DNX_HOME -eq $NULL)
        {
            Write-Host "Initial DNVM environment setup failed; running manual setup"
            $tempDnvmPath = Join-Path $env:TEMP "dnvminstall"
            $dnvmSetupCmdPath = Join-Path $tempDnvmPath "dnvm.ps1"
            & $dnvmSetupCmdPath setup
        }
    }
}

Push-Location $PSScriptRoot

# Install DNVM
Install-Dnvm

# Install DNX
dnvm install $dnvmVersion -r CoreCLR -NoNative
dnvm install $dnvmVersion -r CLR -NoNative
dnvm use $dnvmVersion -r CLR

Import-Module .\psake.psm1

Invoke-Psake -taskList Build,Test -properties @{ buildNumber=$buildNumber; preRelease=$preRelease }

Pop-Location