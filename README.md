Win10-Init-All
==============
**Win10-Init-All** 是一个基于 PowerShell 的脚本项目，旨在一键运行脚本后自动完成安装软件、恢复相关设置等操作。喝杯咖啡稍作等待，即可以最纯净的方式，尽情开始你的工作。

重装系统很简单，而安装软件，恢复系统设置等过程却非常耗时且恼人，有时配置失误又会导致一些意外问题。企业级部署已另有软件，而个人方面没有很好的软件，所以在一顿折腾后，编写了这个项目。

本项目暂仅支持 windows 10 操作系统，贡献代码请按照 [README](https://github.com/Disassembler0/Win10-Initial-Setup-Script/blob/master/README.md) 所示，谢谢。

项目编写时只选取、增改了个人需要的部分功能，由于改动较大，上文中提及的 README 在个人时间充裕后会根据本项目重新再优化、完善、翻译。(当然欢迎贡献/(ㄒoㄒ)/~~))



使用说明
--------

1. 克隆/下载本项目
2. 根据[项目结构](https://github.com/scruel/win10-init-all#项目结构)说明进行自定义
3. 右键 apply-all 以 PowerShell 运行

PS：自动安装软件部分需要安装包提供静默安装参数，无法完成静默安装的使用到了AutoHotKey等脚本软件。




项目结构
--------
```
.
├──  apply-all.ps1                一键应用
├──  batchs                       旧的 batch 文件
│   ├──  context_menu_tweaks.bat  右键菜单优化
│   └──  sound_tweaks.bat         声音方案改为无声方案
├──  modules
│   ├──  apply_tweaks_default.ps1 应用优化设置               可自定义
│   ├──  install_apps.ps1         App 安装                  需自定义
│   ├──  install_apps_tweaks.psm1 安装 App 的设置与优化      需自定义
│   ├──  install_drives.ps1       驱动程序安装               需自定义
│   ├──  set_environments.ps1     系统环境变量设置           需自定义
│   ├──  network_tweaks.psm1
│   ├──  system_apps_tweaks.psm1  
│   ├──  system_tweaks.psm1       
│   ├──  ui_tweaks.psm1           
│   ├──  utils.psm1
│   ├──  environment_utils.psm1
│   ├──  Set-BlueLight.psm1
│   └──  wallpapaer_utils.psm1
├──  README.md
├──  resources
│   ├──  configurations
│   │   ├──  notepad++            Notepad++ 个人主题及设置
│   │   │   ├──  config.xml
│   │   │   └──  npp_scruel.xml
│   │   └──  potplayer            PotPlayer 个人皮肤及设置
│   │       ├──  myZune.dsf
│   │       └──  PotPlayerMini64.ini
│   ├──  install                  office 安装选项模板文件("/admin"生成)
│   │   ├──  office.MSP
│   │   └──  office.MSP.xml          
│   ├──  startmenu.xml            开始菜单备份(由 Export-StartLayout 导出)
│   └──  TaskBar                  任务栏设置
│       ├──  lnks
│       │   ├──  desktop.ini
│       │   ├──  File Explorer.lnk
│       │   ├──  Firefox Developer Edition.lnk
│       │   ├──  Google Chrome.lnk
│       │   └──  Nightly.lnk
│       └──  taskbar.reg
└──  test.ps1                     默认引入所有模块，用于测试方法
```

许可协议
--------
[MIT License](https://github.com/scruel/win10-init-all/blob/master/LICENSE)

如不特殊注明，所有模块都以此协议授权使用。若有意愿软件化本项目，欢迎联系。



### 鸣谢

- 代码风格基于开源项目: [**Win10-Initial-Setup-Script**](https://github.com/Disassembler0/Win10-Initial-Setup-Script)

- PowerShell 中文博客


编写过程中参考了许多优秀开源项目及网络资源，无法一一致谢，在此统一聊表谢意。



作者 scruel

联系邮箱: scruel@vip.qq.com

2017年11月29日