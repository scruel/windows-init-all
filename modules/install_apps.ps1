##########
# Author: Scruel <scruel@vip.qq.com>
# Date: 2017-10-21
# Source: https://github.com/scruel
# 
# This is a simple file, if you want to use it for yourself,
# please modify it and choose the applications that you want to install.
##########

$PSScriptRootPath = (Get-Item -Path $PSScriptRoot).Parent.FullName

# import util functions
Import-Module -DisableNameChecking $PSScriptRoot\utils.psm1

# Ask for elevated permissions if required
RequireAdmin -Path $PSCommandPath -Args $args -WorkingDirectory $PSScriptRoot

###############  Default preset  ###############
$tweaks = @(
	# Setup Apps
	# Goto file install_apps_tweaks.psm1 and modify the path of your wallpapaer.
	"SetDefaultWallPaper", 
	# "SetNppConfigs",
	# "SetPotPlayer64Configs",
	# "DisableWeChatAutoRun",
	# "RestoreTaskBarConfigs",
	
	"SetSystemEnvironments",
    # "RestoreStartMenu",
    "AllOtherActions",
	
    "RestartExplorer",

    "End-Process"
)

# Set power plan incase stop when install
Import-Module -DisableNameChecking $PSScriptRoot\system_tweaks.psm1
SetPowerHighPerformance

###############  Default software install  ###############
#region    App Install 

## some softwares ##
#region    office install
if (!(Is-AppInstalled -Regex "^Office16"))
{
	Write-Host "Installing Office16..."
    $isopath = Mount-DiskImage -ImagePath "K:\Program\commonUse\office\SW_DVD5_Office_Professional_Plus_2016_64Bit_ChnSimp_MLF_X20-42426.ISO" -PassThru
    $isopath = ($isopath | Get-Volume).DriveLetter + ":\SETUP.EXE"
    Start-Process-AndWait -FilePath $isopath -ArgumentList "/adminfile `"$PSScriptRootPath\resources\install\office.MSP`""
    Dismount-DiskImage -ImagePath "K:\Program\commonUse\office\SW_DVD5_Office_Professional_Plus_2016_64Bit_ChnSimp_MLF_X20-42426.ISO"
    Start-Process "K:\Program\cracks\win actives\Microsoft Toolkit.exe" -Verb RunAs
}
#endregion office install
Install-App -FilePath "K:\Program\commonUse\PotPlayerSetup64.exe" -ArgumentList "/S" -Regex "^PotPlayer64$"
Install-App -FilePath "K:\Program\commonUse\npp.Installer.x64.exe" -ArgumentList "/S" -Wait -Regex "^Notepad\+\+$"

Install-App -FilePath "K:\Program\commonUse\typora-setup-x64.exe" -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-" -Wait -MatchAttr "DisplayName" -Regex "^Typora"

## some programmer softwares ##
Install-App -FilePath "K:\Program\programming\GitHubDesktopSetup.exe" -Wait -Regex "^HuorongSysdiag$"
Install-App -FilePath "K:\Program\programming\jdk-9_windows-x64_bin.exe" -ArgumentList "/s" -Wait -MatchAttr "DisplayName" -Regex "Java.* SE Development Kit"
Install-App -FilePath "msiexec" -ArgumentList "/i `"K:\Program\programming\Redis-x64-3.2.100.msi`" /norestart /passive /qb" -Wait -MatchAttr "DisplayName" -Regex "^Redis on Windows$"
Install-App -FilePath "K:\Program\programming\rubyinstaller-2.4.1-2-x64.exe" -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-" -Wait -MatchAttr "DisplayName" -Regex "^Ruby"
# Add 'ADDLOCAL=ALL' Parameter will auto add python2 environment to path
Install-App -FilePath "msiexec" -ArgumentList "/i `"K:\Program\programming\[Python]python2.msi`" /qb /norestart ALLUSERS=1 " -Wait -MatchAttr "DisplayName" -Regex "^Python 2"
Install-App -FilePath "K:\Program\programming\[Python]python3-amd64.exe" -ArgumentList "/quiet PrependPath=1 InstallAllUsers=1" -Wait -MatchAttr "DisplayName" -Regex "^Python 3"
Install-App -FilePath "K:\Program\programming\[JAVA IDE]ideaIU.exe" -ArgumentList "/S" -MatchAttr "DisplayName" -Regex "^IntelliJ IDEA 2"
Install-App -FilePath "K:\Program\programming\[C++ IDE]CLion.exe" -ArgumentList "/S" -Wait -Regex "^CLion"
Install-App -FilePath "K:\Program\programming\[Python IDE]pycharm.exe" -ArgumentList "/S" -Regex "^PyCharm"

#endregion ##########


##########
# Parse parameters and apply tweaks
##########
# Load function names from command line arguments or a preset file
If ($args) {
	$tweaks = $args
	If ($args[0].ToLower() -eq "-preset") {
		$tweaks = Get-Content "$($args | Select-Object -Skip 1)" -ErrorAction Stop | ForEach { $_.Trim() } | Where { $_ -ne "" -and $_[0] -ne "#" }
	}
}

Import-Module -DisableNameChecking $PSScriptRoot\install_apps_tweaks.psm1

# Call the desired tweak functions
$tweaks | ForEach { Invoke-Expression $_ }

# WaitForKey