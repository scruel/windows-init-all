##########
# UI Tweaks
##########

# Adjusts visual effects for performance - Disables animations, transparency etc. but leaves font smoothing and miniatures enabled
Function SetVisualFXPerformance {
	Write-Host "Adjusting visual effects for performance..."
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 0
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00))
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
	Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0
}

# Adjusts visual effects for appearance
Function SetVisualFXAppearance {
	Write-Host "Adjusting visual effects for appearance..."
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 200
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](0x9E,0x1E,0x07,0x80,0x12,0x00,0x00,0x00))
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 1
}

# Enable TitleBar Color
Function EnableTitleBarColor {
	Write-Host "Enabling TitleBar color..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "ColorPrevalence" -Type DWord -Value 1
	New-Item-IfNotExist "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 1
}

Function DisableTitleBarColor {
	Write-Host "Disabling TitleBar color..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "ColorPrevalence" -Type DWord -Value 0
	New-Item-IfNotExist "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 0
}

# Hide Task View button
Function HideTaskView {
	Write-Host "Hiding Task View button..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
}

# Show Task View button
Function ShowTaskView {
	Write-Host "Showing Task View button..."
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -ErrorAction SilentlyContinue
}

# Enable TitleBar AutoColorization
Function EnableAutoColorization {
	Write-Host "Enable AutoColorization..."
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Type DWord -Value 1
}

Function DisableAutoColorization {
	Write-Host "Disabling AutoColorization..."
	Remove-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -ea SilentlyContinue
}

# Change default Explorer view to This PC
Function SetExplorerThisPC {
	Write-Host "Changing default Explorer view to This PC..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1
}

# Change default Explorer view to Quick Access
Function SetExplorerQuickAccess {
	Write-Host "Changing default Explorer view to Quick Access..."
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -ErrorAction SilentlyContinue
}

Function DisableXboxRecordTips {
	Write-Host "Disabling Xbox Record Tips..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "ShowStartupPanel" -Type DWord -Value 0
}

Function EnableXboxRecordTips {
	Write-Host "Enabling Xbox Record Tips..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "ShowStartupPanel" -Type DWord -Value 1
}

# 35286a68-3c57-41a1-bbb1-0eae73d76c95 Videos
# 7d83ee9b-2244-4e70-b1f5-5393042af1e4 Downloads
# B4BFCC3A-DB2C-424C-B029-7FE99A87C641 Desktop
# f42ee2d3-909f-4907-8871-4c22fc0bf756 Documents
# 0ddd015d-b06c-45d5-8c4c-f59713854639 Pictures
# a0c69a99-21c8-4671-8703-7934162fcf1d Music

# Show This PC shortcut on desktop
Function ShowThisPCOnDesktop {
	Write-Host "Showing This PC shortcut on desktop..."
	If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
		New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
	If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
		New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
}

# Hide This PC shortcut from desktop
Function HideThisPCFromDesktop {
	Write-Host "Hiding This PC shortcut from desktop..."
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -ErrorAction SilentlyContinue
}

# Hide Desktop icon from This PC
Function HideDesktopFromThisPC {
	Write-Host "Hiding Desktop icon from This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
}

# Show Desktop icon in This PC
Function ShowDesktopInThisPC {
	Write-Host "Showing Desktop icon in This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
}

# Hide Documents icon from This PC
Function HideDocumentsFromThisPC {
	Write-Host "Hiding Documents icon from This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
}

# Show Documents icon in This PC
Function ShowDocumentsInThisPC {
	Write-Host "Showing Documents icon in This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
}

# Hide Downloads icon from This PC
Function HideDownloadsFromThisPC {
	Write-Host "Hiding Downloads icon from This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
}

# Show Downloads icon in This PC
Function ShowDownloadsInThisPC {
	Write-Host "Showing Downloads icon in This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
}

# Hide Music icon from This PC
Function HideMusicFromThisPC {
	Write-Host "Hiding Music icon from This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
}

# Show Music icon in This PC
Function ShowMusicInThisPC {
	Write-Host "Showing Music icon in This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
}

# Hide Pictures icon from This PC
Function HidePicturesFromThisPC {
	Write-Host "Hiding Pictures icon from This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
}

# Show Pictures icon in This PC
Function ShowPicturesInThisPC {
	Write-Host "Showing Pictures icon in This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
}

# Hide Videos icon from This PC
Function HideVideosFromThisPC {
	Write-Host "Hiding Videos icon from This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
}

# Show Videos icon in This PC
Function ShowVideosInThisPC {
	Write-Host "Showing Videos icon in This PC..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
}

# Hide Taskbar Search button / box
Function HideTaskbarSearch {
	Write-Host "Hiding Taskbar Search box / button..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
}

# Show Taskbar Search box
Function ShowTaskbarSearchBox {
	Write-Host "Showing Taskbar Search box..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 2
}

# Show Taskbar Search button
Function ShowTaskbarSearchButton {
	Write-Host "Showing Taskbar Search button..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1
}

# Show known file extensions
Function ShowKnownExtensions {
	Write-Host "Showing known file extensions..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0
}

# Hide known file extensions
Function HideKnownExtensions {
	Write-Host "Hiding known file extensions..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 1
}

# Show hidden (sytem)files
Function ShowHiddenFiles {
	Write-Host "Showing hidden files..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 1
}

# Hide hidden (sytem)files
Function HideHiddenFiles {
	Write-Host "Hiding hidden files..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 2
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 0
}

# Set Title Bar Inactive Color
Function SetTitleBarInactiveColor {
	Write-Host "Setting TitleBar inactiveColor hotkey..."
	# The active window color(priority)
	New-Item-IfNotExist "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentColorMenu" -Type DWord -Value 0xffb46b3a
	
	# The theme color of current active window
	# 当前激活窗口主题色
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AccentColor" -Type DWord -Value 0xffb46b3a
	
	# The theme color of current inactive window
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AccentColorInactive" -Type DWord -Value 0xffb47841
}

Function UnSetTitleBarInactiveColor {
	Write-Host "Unsetting TitleBar inactiveColor hotkey..."
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentColorMenu" -ea SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AccentColor" -ea SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AccentColorInactive" -ea SilentlyContinue
}
<# deprecated TipbandDesiredVisibility
Function EnabledTaskbarAvoidance {
	Write-Host "Enabling Taskbar Avoidance..."
	New-Item-IfNotExist "HKLM:\Software\Microsoft\StigRegKey\Typing\TaskbarAvoidanceEnabled" | Out-Null
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\StigRegKey\Typing\TaskbarAvoidanceEnabled" -Name "Enable" -Type DWord -Value 1
}

Function DisabledTaskbarAvoidance {
	Write-Host "Disabling Taskbar Avoidance..."
	New-Item-IfNotExist "HKLM:\Software\Microsoft\StigRegKey\Typing\TaskbarAvoidanceEnabled" | Out-Null
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\StigRegKey\Typing\TaskbarAvoidanceEnabled" -Name "Enable" -Type DWord -Value 0
}
#>
Function SetUWPStartingAutoColorization {
	Write-Host "Setting UWP Starting AutoColorization..."
	New-Item-IfNotExist "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\SplashScreen\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" | Out-Null
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\Microsoft.WindowsStore_8wekyb3d8bbwe\SplashScreen\Microsoft.WindowsStore_8wekyb3d8bbwe!App" -Name "BackgroundColor" -Type String -Value "transparent"
}

Function UnsetUWPStartingAutoColorization {
	Write-Host "Unsetting UWP Starting AutoColorization..."
	New-Item-IfNotExist "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\SplashScreen\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" | Out-Null
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\Microsoft.WindowsStore_8wekyb3d8bbwe\SplashScreen\Microsoft.WindowsStore_8wekyb3d8bbwe!App" -Name "BackgroundColor" -Type String -Value "#D0D0D0"
}

Function DisabledLinkDescriptionAdd {
	Write-Host "Disabling link description add..."
	New-Item-IfNotExist "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "Link" -Type Binary -Value ([byte[]](0x00,0x00,0x00,0x00))
}

# TODO
Function EnabledLinkDescriptionAdd {
	Write-Host "Enabling link description add..."
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -ea SilentlyContinue 
}

Function SetIncreaseMultipleInvokePromptMinimum {
	Write-Host "Setting multiple invoke prompt minimum to 10..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "MultipleInvokePromptMinimum" -Type DWord -Value 10
}

Function UnsetMultipleInvokePromptMinimum {
	Write-Host "Unsetting multiple invoke prompt minimum to 0..."
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "MultipleInvokePromptMinimum" -ea SilentlyContinue
}

Function SetShellWindowAlpha {
	# make CMD & PowerShell transparent
	Set-ItemProperty -Path "HKCU:\Console" -Name "WindowAlpha" -Type DWord -Value "0x000000e0"
	Set-ItemProperty -Path "HKCU:\Console\%SystemRoot%_SysWOW64_WindowsPowerShell_v1.0_powershell.exe" -Name "WindowAlpha" -Type DWord -Value "0x000000e0"
	Set-ItemProperty -Path "HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe" -Name "WindowAlpha" -Type DWord -Value "0x000000e0"
}


Function SetTaskBarWeek {
	# 任务栏日期显示“星期几”
	# Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name "sLongDate" -Type String -Value "yyyy'年'M'月'd'日' dddd"
	Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name "sShortDate" -Type String -Value "yyyy/M/d ddd"
}

Function UnsetTaskBarWeek {
	# Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name "sLongDate" -Type String -Value "yyyy'年'M'月'd'日'"
	Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name "sShortDate" -Type String -Value "yyyy/M/d"
}



