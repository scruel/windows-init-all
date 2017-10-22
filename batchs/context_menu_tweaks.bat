
:: Menu Context Tweaks::
:: 清除右键菜单还原以前的版本
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>nul
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>nul
attrib -s -r -h "%userprofile%Appdatalocaliconcache.db" >nul 2>nul
del "%userprofile%Appdatalocaliconcache.db" /f /q  >nul 2>nul

:: 删除右键固定到"快速访问"
reg delete "HKEY_CLASSES_ROOT\Folder\shell\pintohome"  /f >NUL 2>NUL

:: 去掉文件夹右键"包含到库中"
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location"  /f >NUL 2>NUL

:: 为右键添加"计算机管理"
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CompMgmtLauncher" /ve /d "计算机管理" /f >NUL
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CompMgmtLauncher"  /v "Icon"  /d "C:\Windows\system32\CompMgmtLauncher.exe"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CompMgmtLauncher\command" /ve /d "C:\Windows\system32\CompMgmtLauncher.exe" /f >NUL

:: 为右键添加"组策略编辑器"
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\gpedit" /ve /d "组策略编辑器" /f >NUL
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\gpedit"  /v "Icon"  /d "C:\Windows\system32\gpedit.dll, -1"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\gpedit\command" /ve /d "C:\Windows\system32\mmc.exe gpedit.msc" /f >NUL

:: 为右键添加"命令提示符(管理员)"
reg add "HKEY_CLASSES_ROOT\Directory\shell\pcmdrunas" /ve /d "在此处打开命令窗口(管理员)(&A)" /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\shell\pcmdrunas"  /v "NoWorkingDirectory"  /d ""  /t "REG_SZ"  /f >NUL
:: 显示管理员提示盾牌
reg add "HKEY_CLASSES_ROOT\Directory\shell\pcmdrunas"  /v "HasLUAShield"  /d ""  /t "REG_SZ"  /f >NUL
:: 按住Shift加右键才出现
REM reg add "HKEY_CLASSES_ROOT\Directory\shell\pcmdrunas"  /v "Extended"  /d ""  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\shell\pcmdrunas"  /v "Icon"  /d "C:\Windows\System32\shell32.dll,24"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\shell\pcmdrunas\command" /ve /d "PowerShell -windowstyle minimized -Command \"Start-Process cmd.exe -ArgumentList '/s,/k, \"pushd \"%%V\" && title 命令提示符\"' -Verb RunAs\"" /f >NUL
reg add "HKEY_CLASSES_ROOT\Drive\shell\pcmdrunas" /ve /d "在此处打开命令窗口(管理员)(&A)" /f >NUL
reg add "HKEY_CLASSES_ROOT\Drive\shell\pcmdrunas"  /v "Icon"  /d "C:\Windows\System32\shell32.dll,24"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Drive\shell\pcmdrunas"  /v "NoWorkingDirectory"  /d ""  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Drive\shell\pcmdrunas"  /v "HasLUAShield"  /d ""  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Drive\shell\pcmdrunas\command" /ve /d "PowerShell -windowstyle minimized -Command \"Start-Process cmd.exe -ArgumentList '/s,/k, \"pushd \"%%V\" && title 命令提示符\"' -Verb RunAs\"" /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\pcmdrunas" /ve /d "在此处打开命令窗口(管理员)(&A)" /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\pcmdrunas"  /v "NoWorkingDirectory"  /d ""  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\pcmdrunas"  /v "HasLUAShield"  /d ""  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\pcmdrunas"  /v "Icon"  /d "C:\Windows\System32\shell32.dll,24"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\pcmdrunas\command" /ve /d "PowerShell -windowstyle minimized -Command \"Start-Process cmd.exe -ArgumentList '/s,/k, \"pushd \"%%V\" && title 命令提示符\"' -Verb RunAs\"" /f >NUL

:: 桌面右键添加"清空回收站"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\empty"  /v "CommandStateHandler"  /d "{c9298eef-69dd-4cdd-b153-bdbc38486781}"  /t "REG_SZ"  /f >NUL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\empty"  /v "Description"  /d "@shell32.dll,-31332"  /t "REG_SZ"  /f >NUL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\empty"  /v "Icon"  /d "shell32.dll,-254"  /t "REG_SZ"  /f >NUL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\empty"  /v "MUIVerb"  /d "@shell32.dll,-10564"  /t "REG_SZ"  /f >NUL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\empty\command"  /v "DelegateExecute"  /d "{48527bb3-e8de-450b-8910-8c4099cb8624}"  /t "REG_SZ"  /f >NUL

:: 为右键添加"管理员取得所有权菜单"
reg add "HKEY_CLASSES_ROOT\*\shell\takeAuthority" /ve /d "管理员取得所有权" /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\takeAuthority"  /v "NoWorkingDirectory"  /d ""  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\takeAuthority\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\takeAuthority\command"  /v "IsolatedCommand"  /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\exefile\shell\takeAuthority" /ve /d "管理员取得所有权" /f >NUL
reg add "HKEY_CLASSES_ROOT\exefile\shell\takeAuthority"  /v "NoWorkingDirectory"  /d ""  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\exefile\shell\takeAuthority\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f >NUL
reg add "HKEY_CLASSES_ROOT\exefile\shell\takeAuthority\command"  /v "IsolatedCommand"  /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\shell\takeAuthority" /ve /d "管理员取得所有权" /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\shell\takeAuthority"  /v "NoWorkingDirectory"  /d ""  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\shell\takeAuthority\command" /ve /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f >NUL
reg add "HKEY_CLASSES_ROOT\Directory\shell\takeAuthority\command"  /v "IsolatedCommand"  /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t"  /t "REG_SZ"  /f >NUL

:: dll/OCX 文件(反)注册
reg add "HKEY_CLASSES_ROOT\dllfile\shell\Reg" /ve /d "注册DLL" /f >NUL
reg add "HKEY_CLASSES_ROOT\dllfile\shell\Reg\Command" /ve /d "regsvr32 \"%%1\"" /f >NUL
reg add "HKEY_CLASSES_ROOT\dllfile\shell\UnReg" /ve /d "反注册DLL" /f >NUL
reg add "HKEY_CLASSES_ROOT\dllfile\shell\UnReg\Command" /ve /d "regsvr32 /u \"%%1\"" /f >NUL
reg add "HKEY_CLASSES_ROOT\ocxfile\shell" /ve /f >NUL
reg add "HKEY_CLASSES_ROOT\ocxfile\shell\Reg" /ve /d "注册OCX" /f >NUL
reg add "HKEY_CLASSES_ROOT\ocxfile\shell\Reg\Command" /ve /d "regsvr32 \"%%1\"" /f >NUL
reg add "HKEY_CLASSES_ROOT\ocxfile\shell\UnReg" /ve /d "反注册OCX" /f >NUL
reg add "HKEY_CLASSES_ROOT\ocxfile\shell\UnReg\Command" /ve /d "regsvr32 /u \"%%1\"" /f >NUL

:: 添加文件校验算法
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile"  /v "MUIVerb"  /d "Hash File(&H)"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile"  /v "SubCommands"  /d ""  /t "REG_SZ"  /f >NUL
:: MD5
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\01menu"  /v "MUIVerb"  /d "MD5"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\01menu\command" /ve /d "PowerShell [console]::windowwidth=60; [console]::windowheight=12; [console]::Bufferwidth=[console]::windowWidth; Get-FileHash -algorithm MD5 -literalpath \\\"%%1\\\" | format-list; \\\"按任意键退出...\\\"; [Console]::Readkey() | Out-Null; exit" /f >NUL
:: SHA1
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\02menu"  /v "MUIVerb"  /d "SHA1"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\02menu\command" /ve /d "PowerShell [console]::windowwidth=60; [console]::windowheight=12; [console]::Bufferwidth=[console]::windowWidth; Get-FileHash -algorithm SHA1 -literalpath \\\"%%1\\\" | format-list; \\\"按任意键退出...\\\"; [Console]::Readkey() | Out-Null; exit" /f >NUL
:: SHA256
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\03menu"  /v "MUIVerb"  /d "SHA256"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\03menu\command" /ve /d "PowerShell [console]::windowwidth=60; [console]::windowheight=12; [console]::Bufferwidth=[console]::windowWidth; Get-FileHash -algorithm SHA256 -literalpath \\\"%%1\\\" | format-list; \\\"按任意键退出...\\\"; [Console]::Readkey() | Out-Null; exit" /f >NUL
:: SHA384
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\04menu"  /v "MUIVerb"  /d "SHA384"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\04menu\command" /ve /d "PowerShell [console]::windowwidth=60; [console]::windowheight=12; [console]::Bufferwidth=[console]::windowWidth; Get-FileHash -algorithm SHA384 -literalpath \\\"%%1\\\" | format-list; \\\"按任意键退出...\\\"; [Console]::Readkey() | Out-Null; exit" /f >NUL
:: SHA512
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\05menu"  /v "MUIVerb"  /d "SHA512"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\05menu\command" /ve /d "PowerShell [console]::windowwidth=60; [console]::windowheight=12; [console]::Bufferwidth=[console]::windowWidth; Get-FileHash -algorithm SHA512 -literalpath \\\"%%1\\\" | format-list; \\\"按任意键退出...\\\"; [Console]::Readkey() | Out-Null; exit" /f >NUL
:: MACTripleDES
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\06menu"  /v "MUIVerb"  /d "MACTripleDES"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\06menu\command" /ve /d "PowerShell [console]::windowwidth=60; [console]::windowheight=12; [console]::Bufferwidth=[console]::windowWidth; Get-FileHash -algorithm MACTripleDES -literalpath \\\"%%1\\\" | format-list; \\\"按任意键退出...\\\"; [Console]::Readkey() | Out-Null; exit" /f >NUL
:: RIPEMD160
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\07menu"  /v "MUIVerb"  /d "RIPEMD160"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\07menu\command" /ve /d "PowerShell [console]::windowwidth=60; [console]::windowheight=12; [console]::Bufferwidth=[console]::windowWidth; Get-FileHash -algorithm RIPEMD160 -literalpath \\\"%%1\\\" | format-list; \\\"按任意键退出...\\\"; [Console]::Readkey() | Out-Null; exit" /f >NUL
:: ALL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\08menu"  /v "CommandFlags"  /d "0x00000020"  /t "REG_DWORD"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\08menu"  /v "MUIVerb"  /d "Show all"  /t "REG_SZ"  /f >NUL
reg add "HKEY_CLASSES_ROOT\*\shell\hashfile\shell\08menu\command" /ve /d "PowerShell [console]::windowwidth=60; [console]::windowheight=30; [console]::Bufferwidth=[console]::windowWidth; get-filehash -literalpath \\\"%%1\\\" -algorithm SHA1 | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm SHA256 | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm SHA384 | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm SHA512 | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm MACTripleDES | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm MD5 | format-list;get-filehash -literalpath \\\"%%1\\\" -algorithm RIPEMD160 | format-list; \\\"按任意键退出...\\\"; [Console]::Readkey() | Out-Null; exit" /f >NUL
