function Set-Environment
{
	param
	(
		[Parameter(Mandatory=$true)]
		$Name,
		$VariableValue
	)
	gwmi win32_environment -filter "Name=`"$Name`" and username=`"<system>`"" -ea SilentlyContinue | Set-Wmiinstance -Argument @{VariableValue="$VariableValue"}
}

# Enhance wallpaper quality (between 60 and 100)
function Get-Environment
{
	param
	(
		[Parameter(Mandatory=$true)]
		$Name
	)
	return (gwmi win32_environment -filter "Name=`"$Name`" and username=`"<system>`"" -ea SilentlyContinue).VariableValue
}

function Add-PathEnvironment
{
	param
	(
		[Parameter(Mandatory=$true)]
		$VariableValue
	)
	$PathValue = Get-PathEnvironment-IfNameNotExists $VariableValue
	if ($PathValue)
	{
        Write-Host "Adding '" + $VariableValue + "' to Path..." 
		$PathValue += ";" + $VariableValue
		Set-Environment -Name "Path" -VariableValue $PathValue
	}
}

function Get-PathEnvironment-IfNameNotExists
{
	param
	(
		[Parameter(Mandatory=$true)]
		$VariableValue
	)
	
	$PathValue = Get-Environment -Name "Path"
	$Values = $PathValue.Split(";")
    $Result = $false
	$Values | ForEach-Object {
	    $ExpandValue = [Environment]::ExpandEnvironmentVariables($_)
        If($_ -eq $VariableValue -Or $ExpandValue -eq $VariableValue){
            $Result = $true
	    }
    }

	if (!$Result)
	{
		return $PathValue
	}
}
