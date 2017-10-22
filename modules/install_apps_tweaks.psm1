$PSScriptRootPath = (Get-Item -Path $PSScriptRoot).Parent.FullName

Function SetNppConfigs
{
	Write-Host "Setting Notepad++ configs..."
	if (Test-Path HKLM:\SOFTWARE\Notepad++)
	{
		$switch = Get-Process -Name notepad++ -ea SilentlyContinue
		Stop-Process -Force -Name notepad++ -ea SilentlyContinue
		xcopy "$PSScriptRootPath\resources\configurations\notepad++\npp_scruel.xml" "$env:APPDATA\Notepad++\themes" /Y /H /C /Q >$null 2>$null
		xcopy "$PSScriptRootPath\resources\configurations\notepad++\config.xml" "$env:APPDATA\Notepad++" /Y /H /C /Q >$null 2>$null
        $Path = (Get-ItemProperty "HKLM:\SOFTWARE\Notepad++"  "(default)")."(default)" + "\notepad++.exe"
        if ($switch)
		{
			Start-Process -FilePath $Path
		}
		
	}else
	{
		Write-Host "Notepad++ install failed."
	}
}

Function SetPotPlayer64Configs
{
	Write-Host "Setting PotPlayer64 configs..."
	Stop-Process -Force -Name PotPlayerMini64 -ErrorAction SilentlyContinue
	$software = Get-ItemProperty HKLM:\SOFTWARE\DAUM\PotPlayer64 -ea SilentlyContinue
	if ($software)
	{
		$software = $software.ProgramFolder + "\Skins"
		# remove-Item -path "$env:APPDATA\PotPlayerMini64\Playlist" -Recurse -Force -ErrorAction SilentlyContinue
		# xcopy "$PSScriptRootPath\resources\configurations\potplayer\Playlist" "$env:APPDATA\PotPlayerMini64\Playlist" /I /E /Y /H /C /Q >$null 2>$null
		echo f | xcopy "$PSScriptRootPath\resources\configurations\potplayer\PotPlayerMini64.ini" "$env:APPDATA\PotPlayerMini64\PotPlayerMini64.ini" /I /Y /C /Q >$null 2>$null
        xcopy "$PSScriptRootPath\resources\configurations\potplayer\myZune.dsf" "$software" /I /Y /C /Q >$null 2>$null
	}else
	{
		Write-Host "PotPlayer install failed."
	}
}

Function RestoreTaskBarConfigs
{
	Write-Host "Restoring TaskBar configs..."
    $Path = "$PSScriptRootPath\resources\TaskBar\taskbar.reg_" + "{0:yyyyMMdd}_{0:HHmmss}" -f (Get-Date) + ".bak"
	Reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" "$Path" /y >$null
	regedit /s "$PSScriptRootPath\resources\TaskBar\taskbar.reg"
	xcopy "$PSScriptRootPath\resources\TaskBar\lnks" "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" /I /E /Y /C /Q >$null 2>$null
}

Function DisableWeChatAutoRun
{
	Write-Host "Disabling WeChat AutoRun..."
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Wechat" -ErrorAction SilentlyContinue
}

Function SetDefaultWallPaper
{
	Write-Host "Changing wallpapaer..."
	Import-Module -DisableNameChecking $PSScriptRoot\wallpapaer_utils.psm1
	Enhance-WallpaperQuality
	Set-Wallpaper -Path "$PSScriptRootPath\resources\desktop_background.jpg"
}
Function SetSystemEnvironments
{
	Write-Host "Setting system environments..."
	if (!(Is-RegistryExist "HKCU:\SOFTWARE\Scruel" "EnvironmentPath"))
	{
		Start-Process-AndWait("$PSScriptRootPath\batchs\environment_path.bat")
		Set-ItemProperty -Path "HKCU:\SOFTWARE\Scruel" -Name "EnvironmentPath" -Value ""
	}
}


Function RestoreStartMenu
{
	Write-Host "Restoring StartMenu..."
	# $env:AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar
	Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store" -Force -Recurse -ea silentlycontinue
	Import-StartLayout –LayoutPath "$PSScriptRootPath\resources\startmenu.xml" -MountPath $env:systemdrive\
}


Function AllOtherActions
{
	Stop-Process -Force -Name Photoshop -ErrorAction SilentlyContinue
}

