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

    "End-Process"
)

#region     dirvers
Write-Host "Installing driver 'REALTEK Card Reader'..."

if (!(Is-AppInstalled  -MatchAttr "DisplayName" -Regex "Intel\(R\) Processor Graphics"))
{
    Install-App -FilePath "K:\Program\commonUse\drivers\vga_intel_10.18.10.3496_0x98020f83_w818764\setup.exe"  -ArgumentList "-s" -Wait -MatchAttr "DisplayName" -Regex "Intel\(R\) Processor Graphics"
    Restart
}

Install-App -FilePath "K:\Program\commonUse\drivers\nvdia_372.54_Win10_64_International\setup.exe" -MatchAttr "DisplayName" -Regex "^NVIDIA 图形驱动程序"
Wait-Process -Name setup -ErrorAction silentlycontinue | Out-Null

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

# Call the desired tweak functions
$tweaks | ForEach { Invoke-Expression $_ }
# WaitForKey