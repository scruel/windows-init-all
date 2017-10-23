$softwares = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*
$softwares = $softwares + (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)
$softwares = $softwares + (Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)
$softwares
# Relaunch the script with administrator privileges
Function RequireAdmin {
	param (
		[Parameter(Mandatory=$True)]
		$Path,
		$WorkingDirectory,
		[Parameter(Mandatory=$False)]
        $Args
	)
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$Path`" $Args" -WorkingDirectory $WorkingDirectory -Verb RunAs
		Exit
	}
}

# Restart computer
Function Restart {
	Write-Host "Restarting..."
	Restart-Computer -Confirm
}

# Restart explorer
Function RestartExplorer {
	Write-Host "Restarting explorer..."
	taskkill /f /IM explorer.exe >$null 2>$null
	start explorer.exe >$null 2>$null
}

# Function Write-Host-WithTime

Function WaitForKey {
	Write-Host
	Write-Host "Press any key to continue..." -ForegroundColor Black -BackgroundColor White
	[Console]::ReadKey($True) | Out-Null
}


# Check If the specified App is Installed or Not
function Is-AppInstalled {
    param (
		[Parameter(Mandatory=$False)]
        $MatchAttr = "PSChildName",
		$Regex = $null
    )
	
    If (!$softwares) {
        Write-Error "Exception: softwares 变量为空"
        exit
    }
    
	If ($Regex -And ($softwares | Where-Object $MatchAttr -Match "$Regex" -ErrorAction SilentlyContinue)) {
        # $softwares | Where-Object $MatchAttr -Match "$Regex" -ErrorAction SilentlyContinue
        return $True;
    }
	Else {
        return $False;
    }
}

function Is-RegistryExist {
	param (
		[Parameter(Mandatory=$True)]
		$Path,
		$EntryName
	)
	
	If (!(Test-Path "$path")) {
		return $False
	}
	
	return ((Get-Item $Path).GetValueNames() -contains "$EntryName")
}

function Start-Process-IfNotRunning {
	param (
		[Parameter(Mandatory=$True)]
		$Name,
		$FilePath
	)
	
	If (!(Get-Process -Name $Name -ErrorAction SilentlyContinue)) {
        Start-Process -FilePath $FilePath
	}
}

function New-Item-IfNotExist {
	param (
		[Parameter(Mandatory=$True)]
		[string]$Path
	)
    
	If (!(Test-Path "$Path")) {
        $Index = $Path.LastIndexOf("\")
        If ($Index -eq -1) {
            return $False;
        }
        if (New-Item-IfNotExist $Path.Substring(0, $Index)) {
    		New-Item -Path $Path | Out-Null
        }
		else {
            return $False;
        }
	}
    return $True
}

function Install-App {
	param (
		[Parameter(Mandatory=$True)]
		$FilePath,
		[Parameter(Mandatory=$False)]
        [switch]$Wait,
        [switch]$Permission,
        $MatchAttr = "PSChildName",
		$Regex = $null,
        $ArgumentList
	)

    $args = @{}
    $args.Add('FilePath', $FilePath)
	if($ArgumentList) {$args.Add('ArgumentList', $ArgumentList)};
    if($Permission) { $args.Add('Verb', "RunAs") }
    if($Wait) { $args.Add('Wait',$true) }

	Write-Host "Installing `'$FilePath`'..."
	If (!(Is-AppInstalled -MatchAttr $MatchAttr -Regex $Regex)) {
		Start-Process @args
		Write-Host  'Install Finished.';
	}
	Else {
	    Write-Host 'Installed Already, Skip.';
    }
}

# Start Process By Passing Path And Wait until it exit.
function Start-Process-AndWait {
	param (
		[Parameter(Mandatory=$True)]
		$FilePath,
		[Parameter(Mandatory=$False)]
        [switch]$Permission,
        $ArgumentList
	)
#  $PSBoundParameters
    $args = @{}
    $args.Add('FilePath', $FilePath)
	if($ArgumentList) {$args.Add('ArgumentList', $ArgumentList)};
    if($Permission) { $args.Add('Verb', "RunAs") }
    $args.Add('Wait',$true)

	Write-Host "Starting" `'$FilePath`'"..."
    Start-Process @args
}

function Execute-WhatIf-Command {
	param (
		[Parameter(Mandatory=$True)]
		$Command
	)
	
	Write-Host "Press Y to execute: " $Command"..."
    $key = [Console]::Readkey($True);
    switch ($key.key) {
        Y {
            Write-Host "命令执行..."
		    Invoke-Command -scriptblock $Command
            return $True;
        }
        default {
            Write-Host "取消命令执行"
            return $False;
        }
    }
}

Function UninstallApps {
	param (
		[Parameter(Mandatory=$True)]
		$apps
	)
	
	foreach ($app in $apps) {
		$package = Get-AppxPackage -Name $app -AllUsers
		if ($package) {
		    Write-Host "Trying to uninstall `'$app`'..."
			Remove-AppxPackage -Package $package.PackageFullName
			Get-AppXProvisionedPackage -Online | Where-Object DisplayName -EQ $app |`
				Remove-AppxProvisionedPackage -Online | Out-Null
		}
	}
}

Function Pin-App  { 
    param (
            [string]$appname,
            [switch]$unpin
    )
    try {
        if ($unpin.IsPresent) {
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'From "Start" UnPin|Unpin from Start'} | %{$_.DoIt()}
            return "App '$appname' unpinned from Start"
        }
		else {
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'To "Start" Pin|Pin to Start'} | %{$_.DoIt()}
            return "App '$appname' pinned to Start"
        }
    }
	catch {
        Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
    }
}


Function End-Process {
}