@echo off
%1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" REM","","runas",1)(window.close)&&exit

echo 正在执行中...
:: (一)系统设置选项 ::
:: 关机强杀后台进程服务
:: 声音方案

:: (二)UI Tweaks ::
:: 修改 win10 边框为0（AeroLite 自定义样式才需要）
REM To use the default window border width again, set BorderWidth to -15 and PaddedBorderWidth to -60.
REM reg add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics"  /v "PaddedBorderWidth"  /d "0"  /t "REG_DWORD"  /f >NUL
REM reg add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics"  /v "BorderWidth"  /d "0"  /t "REG_DWORD"  /f >NUL

:: 桌面和资源管理器进程分离 ::
REM reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "DesktopProcess" /d "0x0000001" /t "REG_DWORD" /f >NUL

:: 开始菜单显示主颜色
REM reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /d "0x0000001" /t "REG_DWORD" /f >NUL

:: 重启 explorer
REM taskkill /f /im explorer.exe >NUL
REM start %systemroot%\explorer >NUL

:: (五)Application Tweaks ::
:: ECHO 去除安装exe文件时的安全警告
REM reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v ModRiskFileTypes /t REG_SZ /d .exe;.bat;.vbs /f
REM gpupdate /force

:: (六)增补优化 ::
:: 禁用无用服务 ::

:: 小键盘开关
REM [HKEY_CURRENT_USER\Control Panel\Keyboard]
REM "InitialKeyboardIndicators"="80000002"

:: ;当资源管理器崩溃时则自动重启资源管理器
REM [HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Winlogon]
REM "AutoRestartShell"=dword:00000001

:: 关闭视频预览
REM [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.avi\-ShellEx\{3D1975AF-0FC3-463d-8965-4DC6B5A840F4}]
REM @=""
REM [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.wmv\-ShellEx\{3D1975AF-0FC3-463d-8965-4DC6B5A840F4}]
REM @=""
REM [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.mpg\-ShellEx\{3D1975AF-0FC3-463d-8965-4DC6B5A840F4}]
REM @=""
REM [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.mpeg\-ShellEx\{3D1975AF-0FC3-463d-8965-4DC6B5A840F4}]
REM @=""

:: 关闭音乐预览
REM [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.mp3\-ShellEx\{e357fccd-a995-4576-b01f-234630154e96}]
REM @="{9DBD2C50-62AD-11D0-B806-00C04FD706EC}"
REM [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.mp3\-ShellEx\{BB2E617C-0920-11D1-9A0B-00C04FC2D6C1}]
REM @="{9DBD2C50-62AD-11D0-B806-00C04FD706EC}"
REM [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.flac\-ShellEx\{e357fccd-a995-4576-b01f-234630154e96}]
REM ;@="{9DBD2C50-62AD-11D0-B806-00C04FD706EC}"
REM [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.flac\-ShellEx\{BB2E617C-0920-11D1-9A0B-00C04FC2D6C1}]
REM @="{9DBD2C50-62AD-11D0-B806-00C04FD706EC}"
 

:: A0953C92-50DC-43bf-BE83-3742FED03C9C 视频
:: 374DE290-123F-4565-9164-39C4925E467B 下载
:: B4BFCC3A-DB2C-424C-B029-7FE99A87C641 桌面
:: A8CDFF1C-4878-43be-B5FD-F8091C1C60D0 文档
:: 3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA 图片
:: 1CF1260C-4DD0-4ebb-811F-33C572699FDE 音乐
REM reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >nul 2>nul
REM reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>nul
REM reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>nul

:: 已经设置过了
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Scruel" /v "optimize" /t REG_SZ /d "1" /f >nul
echo 完毕！
echo.
REM pause