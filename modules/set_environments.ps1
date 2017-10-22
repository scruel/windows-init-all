##########
# Environment Setter
# Author: Scruel <scruel@vip.qq.com>
# Date: 2017-10-22
# Source: https://github.com/scruel
# 
# This is a simple file, if you want to use it for yourself,
# please modify it and choose the applications that you want to install.
##########

# import util functions
Import-Module -DisableNameChecking $PSScriptRoot\utils.psm1
Import-Module -DisableNameChecking $PSScriptRoot\environment_utils.psm1

# Ask for elevated permissions if required
RequireAdmin -Path $PSCommandPath -Args $args -WorkingDirectory $PSScriptRoot

###############  Default preset  ###############
$PathVariables = @(
    "%JAVA_HOME%\bin"
    "%ENVIRONMENT_HOME%\gradle\bin"
    "%ENVIRONMENT_HOME%\webDev\mysql-5.7.13-winx64\bin"
    "%ENVIRONMENT_HOME%\PortableGit\bin"
    "%ENVIRONMENT_HOME%\PortableGit\mingw64\libexec"
    "%ENVIRONMENT_HOME%\apache-maven-3.3.9\bin"
    "%ENVIRONMENT_HOME%\solr-6.6.0\bin"
)

#region
Set-Environment -Name "JAVA_HOME" -VariableValue "C:\Program Files\Java\jdk-9"
Set-Environment -Name "ENVIRONMENT_HOME" -VariableValue "K:\Program\Development\environment"
Set-Environment -Name "CATALINA_HOME" -VariableValue "%ENVIRONMENT_HOME%\webDev\apache-tomcat-8.5.5"
#endregion

# Call the desired tweak functions
$PathVariables | ForEach { Add-PathEnvironment $_ }


# WaitForKey