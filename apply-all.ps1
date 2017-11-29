# Script Execution must be enabled
# import util functions
Import-Module -DisableNameChecking $PSScriptRoot\modules\utils.psm1
# Ask for elevated permissions if required
RequireAdmin -Path $PSCommandPath -Args $args -WorkingDirectory $PSScriptRoot

#region    ########## Init ##########
Write-Host "Initing..."
New-Item-IfNotExist "HKCU:\SOFTWARE\Scruel"
#endregion ##########

# 安装默认驱动
. "$PSScriptRoot\modules\install_drives.ps1"

# 安装默认软件
. "$PSScriptRoot\modules\install_apps.ps1"

# 设定默认优化
. "$PSScriptRoot\modules\apply_tweaks_default.ps1"

# 设定环境变量
. "$PSScriptRoot\modules\set_environments.ps1"

WaitForKey
