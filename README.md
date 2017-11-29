Win10-Init-All
================

整个脚本项目实现了几乎完全的自动化，在重装 Windows 10 后只需要运行 apply-all.ps1（右击 PowerShell 运行） ，喝杯咖啡，等待 powershell 自动安装软件、恢复相关设定等，然后，尽情工作吧！

本项目参考了大量开源项目、网络资源，其中代码风格基于开源项目 [**Win10-Initial-Setup-Script**](https://github.com/Disassembler0/Win10-Initial-Setup-Script)，个人时间等原因无法一一致谢，在这里统一聊表谢意。
本人在参考的基础上完成了一些修复及优化，并选取了一些个人认为必要的部分，以及增加了一些设定及功能，如果后续有朋友同样想要进行优化开发，请同样按照 [README](https://github.com/Disassembler0/Win10-Initial-Setup-Script/blob/master/README.md) 所示来进行提交修改，谢谢。
（由于改动较大，上文中提及的 README 在个人时间充裕后会根据本项目重新再优化、完善、翻译。（当然欢迎贡献/(ㄒoㄒ)/~~））

项目结构
--------------
```
.
├──  apply-all.ps1                运行并应用所有设定
├──  batchs                       旧的 batch 文件
│   ├──  achive                   弃用的 batch 文件
│   │   ├──  environment_path.bat   
│   │   └──  old_achive.bat
│   ├──  context_menu_tweaks.bat  右键菜单优化
│   └──  sound_tweaks.bat         声音方案改为无声
├──  modules
│   ├──  apps_tweaks.psm1         系统 App 优化模块
│   ├──  environment_utils.psm1   系统环境变量设定模块
│   ├──  install_apps.ps1         用于 App 安装               需自定义
│   ├──  install_apps_tweaks.psm1 用于安装 App 的设定与优化     需自定义
│   ├──  install_drives.ps1       用于驱动安装                 需自定义
│   ├──  network_tweaks.psm1      网络设定优化模块             需自定义
│   ├──  set_environments.ps1     用于设置环境变量
│   ├──  Set-BlueLight.psm1
│   ├──  system_tweaks.psm1       系统设定优化模块
│   ├──  tweak_default.ps1        默认优化调用                 可自定义
│   ├──  ui_tweaks.psm1           系统 UI 设定优化模块
│   ├──  utils.psm1
│   └──  wallpapaer_utils.psm1
├──  README.md
├──  resources
│   ├──  configurations
│   │   ├──  notepad++            Notepad++ 个人主题及设定
│   │   │   ├──  config.xml
│   │   │   └──  npp_scruel.xml
│   │   └──  potplayer            PotPlayer 个人皮肤及设定
│   │       ├──  myZune.dsf
│   │       └──  PotPlayerMini64.ini
│   ├──  install                  office 安装选项模板文件 "/admin" 生成
│   │   ├──  office.MSP
│   │   └──  office.MSP.xml          
│   ├──  startmenu.xml            开始菜单备份，由 Export-StartLayout 导出
│   └──  TaskBar                  任务栏设定
│       ├──  lnks
│       │   ├──  desktop.ini
│       │   ├──  File Explorer.lnk
│       │   ├──  Firefox Developer Edition.lnk
│       │   ├──  Google Chrome.lnk
│       │   └──  Nightly.lnk
│       └──  taskbar.reg
└──  test.ps1                     默认引入所有模块，用于测试方法
```