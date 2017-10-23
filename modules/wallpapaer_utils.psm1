function Set-Wallpaper {
	param (
		[Parameter(Mandatory=$true)]
		$Path
	)
	
	Write-Host "Changing wallpaper..."
	
	Add-Type @"
	using System;
	using System.Runtime.InteropServices;
	using Microsoft.Win32;
	namespace Wallpaper {
		public class Setter {
			public const int SetDesktopWallpaper = 20;
			public const int UpdateIniFile = 0x01;
			public const int SendWinIniChange = 0x02;
			[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
			private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
			public static void SetWallpaper ( string path) {
				RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
				key.SetValue(@"WallpaperStyle", "10") ;
				key.SetValue(@"TileWallpaper", "0") ;
				key.Close();
				SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
			}
		}
	}
"@

	[Wallpaper.Setter]::SetWallpaper( $Path )
}

# Enhance wallpaper quality (between 60 and 100)
function Enhance-WallpaperQuality {
	Write-Host "Enhancing wallpaper quality..."
	Set-ItemProPerty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Value "0x0000064" -Type Dword
	Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Themes\TranscodedWallpaper" -Force -Recurse  -ea SilentlyContinue
	Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Themes\CachedFiles" -Force -Recurse  -ea SilentlyContinue
}


# $path = (get-item $PSScriptRoot).Parent.FullName + "\resources\desktop_background.jpg"

