##########
# Application Tweaks
##########

# Contana quick active by using hotkey
Function EnableCortanaHotKey {
	Write-Host "Enabling Cortana hotkey..."
	New-Item-IfNotExist "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "VoiceShortcut" -Type DWord -Value 1
}

Function DisableCortanaHotKey {
	Write-Host "Disabling Cortana hotkey..."
	New-Item-IfNotExist "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "VoiceShortcut" -Type DWord -Value 0
}

Function SetNotepadConfigs {
	Write-Host "Setting Notepad configs..."
	New-Item-IfNotExist "HKCU:\Software\Microsoft\Notepad" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Notepad" -Name "fWrap" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Notepad" -Name "StatusBar" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Notepad" -Name "fSaveWindowPositions" -Type DWord -Value 1
}

Function UnsetNotepadConfigs {
	Write-Host "Unsetting Notepad configs..."
	New-Item-IfNotExist "HKCU:\Software\Microsoft\Notepad" | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Notepad" -Name "fWrap" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Notepad" -Name "StatusBar" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Notepad" -Name "fSaveWindowPositions" -Type DWord -Value 0
}

# Uninstall default Microsoft applications
Function UninstallMsftBloat {
	Write-Host "Uninstalling default Microsoft applications..."
	$apps = @(
		# default Windows 10 apps
		"Microsoft.3DBuilder"
		"Microsoft.Appconnector"
		"Microsoft.BingFinance"
		"Microsoft.BingNews"
		"Microsoft.BingSports"
		"Microsoft.BingWeather"
		#"Microsoft.FreshPaint"
		"Microsoft.Getstarted"
		"Microsoft.MicrosoftOfficeHub"
		"Microsoft.MicrosoftSolitaireCollection"
		"Microsoft.Office.OneNote"
		"Microsoft.People"
		"Microsoft.SkypeApp"
		"Microsoft.MicrosoftStickyNotes"
		"Microsoft.OneConnect"
		"Microsoft.WindowsFeedbackHub"
		"Microsoft.MicrosoftPowerBIForWindows"
		"Microsoft.NetworkSpeedTest"
		"Microsoft.MSPaint"
		"Microsoft.Microsoft3DViewer"
		"Microsoft.RemoteDesktop"
		#"Microsoft.Windows.Photos"
		"Microsoft.WindowsAlarms"
		# "Microsoft.WindowsCalculator"
		"Microsoft.WindowsCamera"
		"Microsoft.WindowsMaps"
		"Microsoft.WindowsPhone"
		"Microsoft.WindowsSoundRecorder"
		#"Microsoft.WindowsStore"
		# "Microsoft.XboxApp"
		"Microsoft.ZuneMusic"
		"Microsoft.ZuneVideo"
		"microsoft.windowscommunicationsapps"
		"Microsoft.MinecraftUWP"
		"Microsoft.MicrosoftPowerBIForWindows"
		"Microsoft.NetworkSpeedTest"
		
		# Threshold 2 apps
		"Microsoft.CommsPhone"
		"Microsoft.ConnectivityStore"
		"Microsoft.Messaging"
		"Microsoft.Office.Sway"
		
		#Redstone apps
		"Microsoft.BingFoodAndDrink"
		"Microsoft.BingTravel"
		"Microsoft.BingHealthAndFitness"
		"Microsoft.WindowsReadingList"
	)
	UninstallApps $apps
}

# Install default Microsoft applications
Function InstallMsftBloat {
	Write-Host "Installing default Microsoft applications..."
	Get-AppxPackage -AllUsers "Microsoft.3DBuilder" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.BingFinance" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.BingNews" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.BingSports" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.BingWeather" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.Getstarted" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.MicrosoftOfficeHub" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.MicrosoftSolitaireCollection" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.Office.OneNote" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.People" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.SkypeApp" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.Windows.Photos" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.WindowsAlarms" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.WindowsCamera" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.windowscommunicationsapps" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.WindowsMaps" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.WindowsPhone" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.WindowsSoundRecorder" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.ZuneMusic" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.ZuneVideo" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.AppConnector" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.ConnectivityStore" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.Office.Sway" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.Messaging" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.CommsPhone" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.MicrosoftStickyNotes" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.OneConnect" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.WindowsFeedbackHub" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.MinecraftUWP" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.MicrosoftPowerBIForWindows" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.NetworkSpeedTest" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.MSPaint" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.Microsoft3DViewer" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.RemoteDesktop" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
}
# In case you have removed them for good, you can try to restore the files using installation medium as follows
# New-Item C:\Mnt -Type Directory | Out-Null
# dism /Mount-Image /ImageFile:D:\sources\install.wim /index:1 /ReadOnly /MountDir:C:\Mnt
# robocopy /S /SEC /R:0 "C:\Mnt\Program Files\WindowsApps" "C:\Program Files\WindowsApps"
# dism /Unmount-Image /Discard /MountDir:C:\Mnt
# Remove-Item -Path C:\Mnt -Recurse

function UninstallUeslessBloat {
	Write-Host "Uninstalling default third party applications..."
	$apps = @(
		"9E2F88E3.Twitter"
		"PandoraMediaInc.29680B314EFC2"
		"king.com.BubbleWitch3Saga"
		"Flipboard.Flipboard"
		"AdobeSystemsIncorporated.AdobePhotoshopExpress"
		"ShazamEntertainmentLtd.Shazam"
		"king.com.CandyCrushSaga"
		"king.com.CandyCrushSodaSaga"
		"king.com.*"
		"ClearChannelRadioDigital.iHeartRadio"
		"4DF9E0F8.Netflix"
		"6Wunderkinder.Wunderlist"
		"Drawboard.DrawboardPDF"
		"2FE3CB00.PicsArt-PhotoStudio"
		"D52A8D61.FarmVille2CountryEscape"
		"TuneIn.TuneInRadio"
		"GAMELOFTSA.Asphalt8Airborne"
		#"TheNewYorkTimes.NYTCrossword"
		"DB6EA5DB.CyberLinkMediaSuiteEssentials"
		"Facebook.Facebook"
		"flaregamesGmbH.RoyalRevolt2"
		"Playtika.CaesarsSlotsFreeCasino"
		"A278AB0D.MarchofEmpires"
		"KeeperSecurityInc.Keeper"
		"ThumbmunkeysLtd.PhototasticCollage"
		"XINGAG.XING"
		"89006A2E.AutodeskSketchBook"
		"D5EA27B7.Duolingo-LearnLanguagesforFree"
		"46928bounde.EclipseManager"
		"ActiproSoftwareLLC.562882FEEB491" # next one is for the Code Writer from Actipro Software LLC

        # china region
        "903DB504.QQWP" # QQ音乐
        "0C72C7CD.Beta" # 爱奇艺
        "903DB504.QQ"    # QQ UWP

        # microsoft
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.Office.OneNote"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.MinecraftUWP"
	)
    
	UninstallApps $apps
}
# Uninstall default third party applications
function UninstallThirdPartyBloat {
	Write-Host "Uninstalling default third party applications..."
	$apps = @(
		"9E2F88E3.Twitter"
		"PandoraMediaInc.29680B314EFC2"
		"king.com.BubbleWitch3Saga"
		"Flipboard.Flipboard"
		"AdobeSystemsIncorporated.AdobePhotoshopExpress"
		"ShazamEntertainmentLtd.Shazam"
		"king.com.CandyCrushSaga"
		"king.com.CandyCrushSodaSaga"
		"king.com.*"
		"ClearChannelRadioDigital.iHeartRadio"
		"4DF9E0F8.Netflix"
		"6Wunderkinder.Wunderlist"
		"Drawboard.DrawboardPDF"
		"2FE3CB00.PicsArt-PhotoStudio"
		"D52A8D61.FarmVille2CountryEscape"
		"TuneIn.TuneInRadio"
		"GAMELOFTSA.Asphalt8Airborne"
		#"TheNewYorkTimes.NYTCrossword"
		"DB6EA5DB.CyberLinkMediaSuiteEssentials"
		"Facebook.Facebook"
		"flaregamesGmbH.RoyalRevolt2"
		"Playtika.CaesarsSlotsFreeCasino"
		"A278AB0D.MarchofEmpires"
		"KeeperSecurityInc.Keeper"
		"ThumbmunkeysLtd.PhototasticCollage"
		"XINGAG.XING"
		"89006A2E.AutodeskSketchBook"
		"D5EA27B7.Duolingo-LearnLanguagesforFree"
		"46928bounde.EclipseManager"
		"ActiproSoftwareLLC.562882FEEB491" # next one is for the Code Writer from Actipro Software LLC
	)
	UninstallApps $apps
}

# Install default third party applications
Function InstallThirdPartyBloat {
	# DolbyLaboratories.DolbyAtmosforHeadphones
	Write-Host "Installing default third party applications..."
	Get-AppxPackage -AllUsers "9E2F88E3.Twitter" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "king.com.CandyCrushSodaSaga" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "4DF9E0F8.Netflix" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Drawboard.DrawboardPDF" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "D52A8D61.FarmVille2CountryEscape" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "GAMELOFTSA.Asphalt8Airborne" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "flaregamesGmbH.RoyalRevolt2" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "AdobeSystemsIncorporated.AdobePhotoshopExpress" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "ActiproSoftwareLLC.562882FEEB491" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "D5EA27B7.Duolingo-LearnLanguagesforFree" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Facebook.Facebook" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "46928bounde.EclipseManager" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "A278AB0D.MarchofEmpires" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "KeeperSecurityInc.Keeper" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "king.com.BubbleWitch3Saga" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "89006A2E.AutodeskSketchBook" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "CAF9E577.Plex" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
}


Function EnableNetFx35 {
    # Dism /online /get-features
    Write-Host "Enabling Netfx35..."
    if (!((Get-WindowsOptionalFeature –Online -FeatureName "NetFx3").State -eq "enabled")) {
	    # for better visual
	    Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3" -NoRestart -WarningAction SilentlyContinue | Out-Null
	    # for more compatibility, use the following command.
	    # DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /NoRestart -WarningAction SilentlyContinue | Out-Null
    }
}