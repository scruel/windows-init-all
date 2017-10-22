##########
# Win10 Initial Setup Script
# Forked Repository Author: Disassembler <disassembler@dasm.cz>
# Forked Repository Version: v2.8, 2017-09-09
# Forked Repository Source: https://github.com/Disassembler0/Win10-Initial-Setup-Script
#
# Author: Scruel <scruel@vip.qq.com>
# Date: 2017-10-22
# Source: https://github.com/scruel
##########

$PSScriptRootPath = (Get-Item -Path $PSScriptRoot).Parent.FullName
# import util functions
Import-Module -DisableNameChecking $PSScriptRoot\utils.psm1

# Ask for elevated permissions if required
RequireAdmin -Path $PSCommandPath -Args $args -WorkingDirectory $PSScriptRoot

# Default preset
$tweaks = @(
	### System Tweaks ###
	"DisableDownloadSuggestedApps",
	"DisableStartSuggestions",        # "EnableStartSuggestions",
	"DisableUsbLikelyAutorun",
	"SetPowerHighPerformance",
	"EnableBlueLight",              # "DisableBlueLight"
	"EnableAutoDiskCleanSensor",    # "DisableAutoDiskCleanSensor"
	"DisableSuperfetch",            # "EnableSuperfetch",
	"DisableIndexing",              # "EnableIndexing",
	"DisableUpdateRestart",         # "EnableUpdateRestart",
	"EnableBlueScreenDetails",      # "DisableBlueScreenDetails",
	"RemoveENKeyboard",             # "AddENKeyboard",
	"SetWUDeliveryOptimization",    # "UnsetWUDeliveryOptimization",
	# "DisableWinLogonReport",        # "EnableWinLogonReport",
	# "DisableDefender",            # "EnableDefender",
	# "DisableTelemetry",             # "EnableTelemetry",
	# "DisableWiFiSense",             # "EnableWiFiSense",
	# "DisableSmartScreen",           # "EnableSmartScreen",
	# "DisableWebSearch",             # "EnableWebSearch",
	# "DisableLocationTracking",      # "EnableLocationTracking",
	# "DisableMapUpdates",            # "EnableMapUpdates",
	# "DisableFeedback",              # "EnableFeedback",
	# "DisableAdvertisingID",         # "EnableAdvertisingID",
	# "DisableCortana",               # "EnableCortana",
	# "DisableErrorReporting",        # "EnableErrorReporting",
	# "SetP2PUpdateLocal",            # "SetP2PUpdateInternet",
	# "DisableAutoLogger",            # "EnableAutoLogger",
	# "DisableDiagTrack",             # "EnableDiagTrack",
	# "DisableWAPPush",               # "EnableWAPPush",
	# "SetUACLow",                  # "SetUACHigh",
	# "EnableSharingMappedDrives",  # "DisableSharingMappedDrives",
	# "DisableAdminShares",           # "EnableAdminShares",
	# "DisableSMB1",                  # "EnableSMB1",
	# "SetCurrentNetworkPrivate",     # "SetCurrentNetworkPublic",
	# "SetUnknownNetworksPrivate",  # "SetUnknownNetworksPublic",
	# "DisableFirewall",            # "EnableFirewall",
	# "DisableUpdateMSRT",          # "EnableUpdateMSRT",
	# "DisableUpdateDriver",        # "EnableUpdateDriver",
	# "DisableHomeGroups",            # "EnableHomeGroups",
	# "EnableRemoteDesktop",          # "DisableRemoteDesktop",
	# "DisableAutoplay",              # "EnableAutoplay",
	# "DisableAutorun",               # "EnableAutorun",
	# "DisableDefragmentation",     # "EnableDefragmentation",
	# "SetBIOSTimeUTC",             # "SetBIOSTimeLocal",
	# "EnableHibernation",          # "DisableHibernation",
	# "DisableFastStartup",         # "EnableFastStartup",

	### UI Tweaks ###
	"SetShellWindowAlpha",
	"EnableTitleBarColor",            # "DisableTitleBarColor",
	"SetIncreaseMultipleInvokePromptMinimum",    # "UnsetMultipleInvokePromptMinimum",
	"EnableAutoColorization",         # "DisableAutoColorization",
	"ShowTaskbarSearchButton",        # "HideTaskbarSearch",         # "ShowTaskbarSearchBox",
	"HideTaskView",                 # "ShowTaskView",
	"ShowKnownExtensions",          # "HideKnownExtensions",
	"ShowHiddenFiles",              # "HideHiddenFiles",
	"SetTitleBarInactiveColor",     # "UnSetTitleBarInactiveColor", 
	"SetExplorerThisPC",            # "SetExplorerQuickAccess",
	"ShowThisPCOnDesktop",          # "HideThisPCFromDesktop",
	"HideMusicFromThisPC",          # "ShowMusicInThisPC",
	"HidePicturesFromThisPC",       # "ShowPicturesInThisPC",
	"HideVideosFromThisPC",         # "ShowVideosInThisPC",
	"SetVisualFXAppearance",       # "SetVisualFXPerformance",
	"DisabledLinkDescriptionAdd",              # "EnabledLinkDescriptionAdd",
	"DisableXboxRecordTips",              # "EnableXboxRecordTips",
	"SetUWPStartingAutoColorization",          # "UnsetUWPStartingAutoColorization"
	"SetKillWatingToZero",            # "UnsetKillWatingToZero"
	"SetTaskBarWeek",            # "UnsetTaskBarWeek"
	# "DisableActionCenter",          # "EnableActionCenter",
	# "DisableLockScreen",            # "EnableLockScreen",
	# "DisableLockScreenRS1",         # "EnableLockScreenRS1",
	# "HideNetworkFromLockScreen",    # "ShowNetworkOnLockScreen",
	# "HideShutdownFromLockScreen",   # "ShowShutdownOnLockScreen",
	# "DisableStickyKeys",            # "EnableStickyKeys",
	# "ShowTaskManagerDetails"        # "HideTaskManagerDetails",
	# "ShowFileOperationsDetails",    # "HideFileOperationsDetails",
	# "EnableFileDeleteConfirm",    # "DisableFileDeleteConfirm",
	# "ShowSmallTaskbarIcons",        # "ShowLargeTaskbarIcons",
	# "ShowTaskbarTitles",            # "HideTaskbarTitles",
	# "HideTaskbarPeopleIcon",        # "ShowTaskbarPeopleIcon",
	# "ShowTrayIcons",                # "HideTrayIcons",
	# "HideSyncNotifications"         # "ShowSyncNotifications",
	# "HideRecentShortcuts",          # "ShowRecentShortcuts",
	# "HideDesktopFromThisPC",        # "ShowDesktopInThisPC",
	# "HideDocumentsFromThisPC",      # "ShowDocumentsInThisPC",
	# "HideDownloadsFromThisPC",      # "ShowDownloadsInThisPC",
	# "DisableThumbnails",          # "EnableThumbnails",
	# "DisableThumbsDB",            # "EnableThumbsDB",         
	# "EnableNumlock",              # "DisableNumlock",
	
	### Application Tweaks ###
	"EnableCortanaHotKey",            # "DisableCortanaHotKey",
	"SetNotepadConfigs",              # "UnsetNotepadConfigs",
	"DisableSearchAppInStore",      # "EnableSearchAppInStore",
    "UninstallUeslessBloat",
    "EnableNetFx35",
	# "DisableXboxFeatures",          # "EnableXboxFeatures",
	# "DisableOneDrive",              # "EnableOneDrive",
	# "UninstallOneDrive",            # "InstallOneDrive",
	# "UninstallMsftBloat",           # "InstallMsftBloat",
	# "UninstallThirdPartyBloat",     # "InstallThirdPartyBloat",
	# "UninstallWindowsStore",        # "InstallWindowsStore",
	# "DisableConsumerApps",          # "EnableConsumerApps",
	# "UninstallMediaPlayer",       # "InstallMediaPlayer",
	# "UninstallWorkFolders",       # "InstallWorkFolders",
	# "InstallLinuxSubsystem",      # "UninstallLinuxSubsystem",
	# "InstallHyperV",              # "UninstallHyperV",
	# "SetPhotoViewerAssociation",    # "UnsetPhotoViewerAssociation",
	# "AddPhotoViewerOpenWith",       # "RemovePhotoViewerOpenWith",
	# "DisableNewAppPrompt",          # "EnableNewAppPrompt",
	# "EnableF8BootMenu",             # "DisableF8BootMenu",
	# "SetDEPOptOut",                 # "SetDEPOptIn",

	### NetWork Tweaks ###
	"DisableRemoteAssistance",        # "EnableRemoteAssistance",
	# "HideServerManagerOnLogin",   # "ShowServerManagerOnLogin",
	# "DisableShutdownTracker",     # "EnableShutdownTracker",
	# "DisablePasswordPolicy",      # "EnablePasswordPolicy",
	# "DisableCtrlAltDelLogin",     # "EnableCtrlAltDelLogin",
	# "DisableIEEnhancedSecurity",  # "EnableIEEnhancedSecurity",


    "End-Process"
)

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

# Load all tweak functions
Import-Module -DisableNameChecking $PSScriptRoot\apps_tweaks.psm1
Import-Module -DisableNameChecking $PSScriptRoot\system_tweaks.psm1
Import-Module -DisableNameChecking $PSScriptRoot\network_tweaks.psm1
Import-Module -DisableNameChecking $PSScriptRoot\ui_tweaks.psm1

# Call the desired tweak functions
$tweaks | ForEach { Invoke-Expression $_ }

Write-Host "Executing context_menu_tweaks batch..."
Start-Process-AndWait("$PSScriptRootPath\batchs\context_menu_tweaks.bat")
Write-Host "Executing sound_tweaks batch..."
Start-Process-AndWait("$PSScriptRootPath\batchs\sound_tweaks.bat")

# WaitForKey