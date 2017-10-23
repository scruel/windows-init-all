##########
# System Tweaks
##########

# Disable Telemetry
Function DisableTelemetry {
	Write-Host "Disabling Telemetry..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
}

# Enable Telemetry
Function EnableTelemetry {
	Write-Host "Enabling Telemetry..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 3
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 3
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 3
}

# Disable SmartScreen Filter
Function DisableSmartScreen {
	Write-Host "Disabling SmartScreen Filter..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Type String -Value "Off"
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" -Name "EnableWebContentEvaluation" -Type DWord -Value 0
	$edge = (Get-AppxPackage -AllUsers "Microsoft.MicrosoftEdge").PackageFamilyName
	If (!(Test-Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$edge\MicrosoftEdge\PhishingFilter")) {
		New-Item -Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$edge\MicrosoftEdge\PhishingFilter" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$edge\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$edge\MicrosoftEdge\PhishingFilter" -Name "PreventOverride" -Type DWord -Value 0
}

# Enable SmartScreen Filter
Function EnableSmartScreen {
	Write-Host "Enabling SmartScreen Filter..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Type String -Value "RequireAdmin"
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" -Name "EnableWebContentEvaluation" -ErrorAction SilentlyContinue
	$edge = (Get-AppxPackage -AllUsers "Microsoft.MicrosoftEdge").PackageFamilyName
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$edge\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$edge\MicrosoftEdge\PhishingFilter" -Name "PreventOverride" -ErrorAction SilentlyContinue
}

# Disable Autoplay
Function DisableAutoplay {
	Write-Host "Disabling Autoplay..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 1
}

# Enable Autoplay
Function EnableAutoplay {
	Write-Host "Enabling Autoplay..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 0
}

# Disable Autorun for all drives
Function DisableAutorun {
	Write-Host "Disabling Autorun for all drives..."
	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Type DWord -Value 255
	If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
		New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Type DWord -Value 255
}

# Enable Autorun for removable drives
Function EnableAutorun {
	Write-Host "Enabling Autorun for all drives..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -ErrorAction SilentlyContinue
}

# Disable Autorun for usb likely dirves.
# http://blog.csdn.net/yk3372/article/details/6174682
Function DisableUsbLikelyAutorun {
	Write-Host "Disabling Autorun for all usb likely drives..."
	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Type DWord -Value 221
	If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
		New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Type DWord -Value 221
	# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NolowDiskSpaceChecks" -Type DWord -Value 1
}

Function EnableBlueLight {
	Write-Host "Enabling blue light..."
	Import-Module -DisableNameChecking $PSScriptRoot\Set-BlueLight.psm1
	Set-BlueLight -EnableAutomaticSchedule
}

Function DisableBlueLight {
	Write-Host "Disabling blue light..."
	Import-Module -DisableNameChecking $PSScriptRoot\Set-BlueLight.psm1
	SSet-BlueLight -DisableBlueLight
}

Function EnableAutoDiskCleanSensor {
	Write-Host "Enable Auto Disk Clean Sensor..."
	New-Item-IfNotExist -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Type DWord -Value 1
}

Function DisableAutoCleanSensor {
	Write-Host "Disable Auto Disk Clean Sensor..."
	New-Item-IfNotExist -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Type DWord -Value 0
}

# Disable Start Menu suggestions
# 禁止在开始菜单中推荐应用
Function DisableStartSuggestions {
	Write-Host "Disabling Start Menu suggestions..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
	(Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -ErrorAction SilentlyContinue).PSObject.Properties | ForEach-Object {
      If($_.Name -Match 'SubscribedContent') {
	    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name $_.Name -Type DWord -Value 0
      }
    }
}

# Enable Start Menu suggestions
Function EnableStartSuggestions {
	Write-Host "Enabling Start Menu suggestions..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 1
	(Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -ErrorAction SilentlyContinue).PSObject.Properties | ForEach-Object {
      If($_.Name -Match 'SubscribedContent') {
	    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name $_.Name -Type DWord -Value 1
      }
    }
}

# Disable automatic Maps updates
Function DisableMapUpdates {
	Write-Host "Disabling automatic Maps updates..."
	Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
}

# Enable automatic Maps updates
Function EnableMapUpdates {
	Write-Host "Enable automatic Maps updates..."
	Remove-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -ErrorAction SilentlyContinue
}

# Stop and disable WAP Push Service
Function DisableWAPPush {
	Write-Host "Stopping and disabling WAP Push Service..."
	Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
	Set-Service "dmwappushservice" -StartupType Disabled
}

# Enable and start WAP Push Service
Function EnableWAPPush {
	Write-Host "Enabling and starting WAP Push Service..."
	Set-Service "dmwappushservice" -StartupType Automatic
	Start-Service "dmwappushservice" -WarningAction SilentlyContinue
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice" -Name "DelayedAutoStart" -Type DWord -Value 1
}


# Stop and disable Superfetch service - Not applicable to Server
## 禁止 Superfetch 服务（SSD必选）
Function DisableSuperfetch {
	Write-Host "Stopping and disabling Superfetch service..."
	Stop-Service "SysMain" -WarningAction SilentlyContinue
	Set-Service "SysMain" -StartupType Disabled
	If (!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters")) {
		New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnablePrefetcher" -Type DWord -Value 0
}

# Start and enable Superfetch service - Not applicable to Server
Function EnableSuperfetch {
	Write-Host "Starting and enabling Superfetch service..."
	Set-Service "SysMain" -StartupType Automatic
	Start-Service "SysMain" -WarningAction SilentlyContinue
	If (!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters")) {
		New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnablePrefetcher" -Type DWord -Value 1
}

# Disable Windows Defender
Function DisableDefender {
	Write-Host "Disabling Windows Defender..."
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Type DWord -Value 1
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -ErrorAction SilentlyContinue
}

# Enable Windows Defender
Function EnableDefender {
	Write-Host "Enabling Windows Defender..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -ErrorAction SilentlyContinue
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
}

# Disable implicit administrative shares
Function DisableAdminShares {
	Write-Host "Disabling implicit administrative shares..."
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -Type DWord -Value 0
}

# Enable implicit administrative shares
Function EnableAdminShares {
	Write-Host "Enabling implicit administrative shares..."
	Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -ErrorAction SilentlyContinue
}

# Enable sharing mapped drives between users
Function EnableSharingMappedDrives {
	Write-Host "Enabling sharing mapped drives between users..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -Type DWord -Value 1
}

# Disable sharing mapped drives between users
Function DisableSharingMappedDrives {
	Write-Host "Disabling sharing mapped drives between users..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -ErrorAction SilentlyContinue
}

# Restrict Windows Update P2P only to local network
Function SetP2PUpdateLocal {
	Write-Host "Restricting Windows Update P2P only to local network..."
	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
	If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization")) {
		New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" -Name "SystemSettingsDownloadMode" -Type DWord -Value 3
}

# Unrestrict Windows Update P2P
Function SetP2PUpdateInternet {
	Write-Host "Unrestricting Windows Update P2P to internet..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" -Name "SystemSettingsDownloadMode" -ErrorAction SilentlyContinue
}

#禁止乱下 uwp 应用
Function DisableDownloadSuggestedApps {
	Write-Host "Disabling download suggested Apps..."
	New-Item-IfNotExist "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
	Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" -Force -ErrorAction SilentlyContinue
}

# Disable Lock screen
Function DisableLockScreen {
	Write-Host "Disabling Lock screen..."
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Type DWord -Value 1
}

# Enable Lock screen
Function EnableLockScreen {
	Write-Host "Enabling Lock screen..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -ErrorAction SilentlyContinue
}

# Disable Lock screen (Anniversary Update workaround) - Applicable to RS1 or newer
Function DisableLockScreenRS1 {
	Write-Host "Disabling Lock screen using scheduler workaround..."
	$service = New-Object -com Schedule.Service
	$service.Connect()
	$task = $service.NewTask(0)
	$task.Settings.DisallowStartIfOnBatteries = $false
	$trigger = $task.Triggers.Create(9)
	$trigger = $task.Triggers.Create(11)
	$trigger.StateChange = 8
	$action = $task.Actions.Create(0)
	$action.Path = "reg.exe"
	$action.Arguments = "add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData /t REG_DWORD /v AllowLockScreen /d 0 /f"
	$service.GetFolder("\").RegisterTaskDefinition("Disable LockScreen", $task, 6, "NT AUTHORITY\SYSTEM", $null, 4) | Out-Null
}

# Enable Lock screen (Anniversary Update workaround) - Applicable to RS1 or newer
Function EnableLockScreenRS1 {
	Write-Host "Enabling Lock screen (removing scheduler workaround)..."
	Unregister-ScheduledTask -TaskName "Disable LockScreen" -Confirm:$false -ErrorAction SilentlyContinue
}

# Show file operations details
Function ShowFileOperationsDetails {
	Write-Host "Showing file operations details..."
	If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
		New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1
}

# Hide file operations details
Function HideFileOperationsDetails {
	Write-Host "Hiding file operations details..."
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -ErrorAction SilentlyContinue
}

# Add secondary en-US keyboard
Function AddENKeyboard {
	Write-Host "Adding secondary en-US keyboard..."
	$langs = Get-WinUserLanguageList
	$langs.Add("en-US")
	Set-WinUserLanguageList $langs -Force
}

# Remove secondary en-US keyboard
Function RemoveENKeyboard {
	Write-Host "Removing secondary en-US keyboard..."
	$langs = Get-WinUserLanguageList
	Set-WinUserLanguageList ($langs | ? {$_.LanguageTag -ne "en-US"}) -Force -ea SilentlyContinue
}
# Fix the issues that windows automatically adding EN-US keyboard
Function DisableKeyboardRemoteAdd {
	Write-Host "Disabling keyboard preload..."
	Remove-Item -Path "HKCU:\Keyboard Layout\Preload" -Force -ea SilentlyContinue
	Remove-Item -Path "Registry::HKU\.DEFAULT\Keyboard Layout\Preload" -Force -ea SilentlyContinue
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" -Name "IgnoreRemoteKeyboardLayout" -Type DWORD -Value 0
}

Function EnableKeyboardRemoteAdd {
	Write-Host "Disabling keyboard preload..."
	Remove-Item -Path "HKCU:\Keyboard Layout\Preload" -Force -ea SilentlyContinue
	Remove-Item -Path "Registry::HKU\.DEFAULT\Keyboard Layout\Preload" -Force -ea SilentlyContinue
	Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" -Name "IgnoreRemoteKeyboardLayout" -ea SilentlyContinue
}

# Show Task Manager details
Function ShowTaskManagerDetails {
	Write-Host "Showing task manager details..."
	If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Force | Out-Null
	}
	$preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
	If (!($preferences)) {
		$taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
		While (!($preferences)) {
			Start-Sleep -m 250
			$preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
		}
		Stop-Process $taskmgr
	}
	$preferences.Preferences[28] = 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
}

# Hide Task Manager details
Function HideTaskManagerDetails {
	Write-Host "Hiding task manager details..."
	$preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
	If ($preferences) {
		$preferences.Preferences[28] = 1
		Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
	}
}

# Disable WinLogon Report
Function DisableWinLogonReport {
	Write-Host "Disabling WinLogon Report..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "ReportBootOk" -Type DWord -Value 0
}

# Enable WinLogon Report
Function EnableWinLogonReport {
	Write-Host "Enabling WinLogon Report..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "ReportBootOk" -Type DWord -Value 1
}

# Enable BlueScreen Details
Function EnableBlueScreenDetails {
	Write-Host "Enabling bluescreen details..."
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "DisplayParameters" -Type DWord -Value 1
}

# Disable BlueScreen Details
Function DisableBlueScreenDetails {
	Write-Host "Disabling bluescreen details..."
	Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "DisplayParameters" -ErrorAction SilentlyContinue
}

# Disable search for app in store for unknown extensions
# 禁用在打开未知扩展名文件的时候显示的“在Web上寻找适当的程序”
# "Open With..." becomes default
Function DisableSearchAppInStore {
	Write-Host "Disabling search for app in store for unknown extensions..."
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -Type DWord -Value 1
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "NoInternetOpenWith" -Type DWord -Value 1
}

# Enable search for app in store for unknown extensions
Function EnableSearchAppInStore {
	Write-Host "Enabling search for app in store for unknown extensions..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -ErrorAction SilentlyContinue
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "NoInternetOpenWith" -Type DWord -Value 0
}

# Disable 'How do you want to open this file?' prompt
Function DisableNewAppPrompt {
	Write-Host "Disabling 'How do you want to open this file?' prompt..."
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoNewAppAlert" -Type DWord -Value 1
}

# Enable 'How do you want to open this file?' prompt
Function EnableNewAppPrompt {
	Write-Host "Enabling 'How do you want to open this file?' prompt..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoNewAppAlert" -ErrorAction SilentlyContinue
}

# Uninstall Windows Media Player
Function UninstallMediaPlayer {
	Write-Host "Uninstalling Windows Media Player..."
	Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Install Windows Media Player
Function InstallMediaPlayer {
	Write-Host "Installing Windows Media Player..."
	Enable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null
}


# Stop and disable Windows Search indexing service
Function DisableIndexing {
	Write-Host "Stopping and disabling Windows Search indexing service..."
	Stop-Service "WSearch" -WarningAction SilentlyContinue
	Set-Service "WSearch" -StartupType Disabled
}

# Start and enable Windows Search indexing service
Function EnableIndexing {
	Write-Host "Starting and enabling Windows Search indexing service..."
	Set-Service "WSearch" -StartupType Automatic
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WSearch" -Name "DelayedAutoStart" -Type DWord -Value 1
	Start-Service "WSearch" -WarningAction SilentlyContinue
}


# Disable Windows Update automatic restart
Function DisableUpdateRestart {
	Write-Host "Disabling Windows Update automatic restart..."
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Name "UxOption" -Type DWord -Value 1
}

# Enable Windows Update automatic restart
Function EnableUpdateRestart {
	Write-Host "Enabling Windows Update automatic restart..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -ErrorAction SilentlyContinue
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Name "UxOption" -Type DWord -Value 0
}

# Optimize Windows Update Net Delivery Speed(For win10 v.1709(Fall Creater Update)) 
Function SetWUDeliveryOptimization {
	Write-Host "Seting Windows Update Net Speed ..."
	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" -Name "DownloadRateBackgroundPct" -Type String -Value "30"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" -Name "UpRatePctBandwidth" -Type String -Value "5"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" -Name "UploadLimitGBMonth" -Type String -Value "5"
}

Function UnsetWUDeliveryOptimization {
	Write-Host "Unseting Windows Update automatic restart..."
	Remove-ItemProperty -Path "HKLM:HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" -Name "DownloadRateBackgroundPct" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKLM:HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" -Name "UpRatePctBandwidth" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKLM:HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" -Name "UploadLimitGBMonth" -ErrorAction SilentlyContinue
}

# Disable Xbox features
Function DisableXboxFeatures {
	Write-Host "Disabling Xbox features..."
	Get-AppxPackage "Microsoft.XboxApp" | Remove-AppxPackage
	Get-AppxPackage "Microsoft.XboxIdentityProvider" | Remove-AppxPackage
	Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage
	Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Type DWord -Value 0
}

# Enable Xbox features
Function EnableXboxFeatures {
	Write-Host "Enabling Xbox features..."
	Get-AppxPackage -AllUsers "Microsoft.XboxApp" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.XboxIdentityProvider" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.XboxSpeechToTextOverlay" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.XboxGameOverlay" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 1
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -ErrorAction SilentlyContinue
}

# Install Linux Subsystem - Applicable to RS1 or newer, not applicable to Server yet
Function InstallLinuxSubsystem {
	Write-Host "Installing Linux Subsystem..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 1
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -Type DWord -Value 1
	Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Uninstall Linux Subsystem - Applicable to RS1 or newer, not applicable to Server yet
Function UninstallLinuxSubsystem {
	Write-Host "Uninstalling Linux Subsystem..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -Type DWord -Value 0
	Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Install Hyper-V - Not applicable to Home
Function InstallHyperV {
	Write-Host "Installing Hyper-V..."
	If ((Get-WmiObject -Class "Win32_OperatingSystem").Caption -like "*Server*") {
		Install-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
	} Else {
		Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -NoRestart -WarningAction SilentlyContinue | Out-Null
	}
}

# Uninstall Hyper-V - Not applicable to Home
Function UninstallHyperV {
	Write-Host "Uninstalling Hyper-V..."
	If ((Get-WmiObject -Class "Win32_OperatingSystem").Caption -like "*Server*") {
		Uninstall-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
	} Else {
		Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -NoRestart -WarningAction SilentlyContinue | Out-Null
	}
}

# Disable Lock screen
Function SetKillWatingToZero {
	Write-Host "Setting KillWating to zero Lock screen..."
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -Type DWord -Value 0
}

# Enable Lock screen
Function UnsetKillWatingToZero {
	Write-Host "Unetting KillWating to zero Lock screen..."
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Type DWord -Value 4000
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -Type DWord -Value 4000
}

# Set system to high-performance power plan
Function SetPowerHighPerformance {
	Write-Host "Setting system to high-performance power plan..."
	# active high-performance power plan
	powercfg.exe -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
	# harddisk
	powercfg /change disk-timeout-ac 0 
	powercfg /change disk-timeout-dc 0
	# hibernate
	powercfg /change hibernate-timeout-ac 0
	powercfg /change hibernate-timeout-dc 0
	# standby
	powercfg /change standby-timeout-ac 0
	powercfg /change standby-timeout-dc 0
	# disable USB selective pause
	powercfg /setacvalueindex SCHEME_MIN 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
	powercfg /setdcvalueindex SCHEME_MIN 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
	# change the operation when closing the lid
	powercfg /setacvalueindex SCHEME_MIN SUB_BUTTONS LIDACTION 0
	powercfg /setdcvalueindex SCHEME_MIN SUB_BUTTONS LIDACTION 0
	# change the operation when press the power button
	powercfg /setacvalueindex SCHEME_MIN SUB_BUTTONS PBUTTONACTION 2
	powercfg /setdcvalueindex SCHEME_MIN SUB_BUTTONS PBUTTONACTION 2
	# power button now in the start menu
	New-Item-IfNotExist -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "ShowHibernateOption" -Type DWord -Value 1
	powercfg /setacvalueindex SCHEME_MIN SUB_BUTTONS UIBUTTON_ACTION 2
	powercfg /setdcvalueindex SCHEME_MIN SUB_BUTTONS UIBUTTON_ACTION 2
	# 直流电源(电池) 最小处理器状态
	# Minimum processor status of DC power supply (battery)
	powercfg /setdcvalueindex SCHEME_MIN SUB_PROCESSOR PROCTHROTTLEMIN 50
	# brightness of display to 100
	powercfg /setacvalueindex SCHEME_MIN SUB_VIDEO aded5e82-b909-4619-9949-f5d71dac0bcb 100
	powercfg /setdcvalueindex SCHEME_MIN SUB_VIDEO aded5e82-b909-4619-9949-f5d71dac0bcb 100
	# video playback quality bias.
	powercfg /setacvalueindex SCHEME_MIN 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 10778347-1370-4ee0-8bbd-33bdacaade49 1
	powercfg /setdcvalueindex SCHEME_MIN 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 10778347-1370-4ee0-8bbd-33bdacaade49 1
}




