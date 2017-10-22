# Win10-Init-All

整个脚本项目实现了基本上完全的自动化，在重装 Windows 10 后只需要运行 apply-all.ps1（右击 PowerShell 运行） ，稍作等待，即可恢复相关设定、安装软件等操作。

本项目融合了非常多开源项目的内容，并且在这些项目的基础上做了一些优化，从中提取了自己需要用到的设定功能，以及增加了一些设定功能，这个项目的代码设计实现风格基于非常赞的 GitHub 开源项目[**Win10-Initial-Setup-Script**](https://github.com/Disassembler0/Win10-Initial-Setup-Script)，由于改动较大，不做 Fork 了，但仍然感谢该项目负责人的开发。

如果后续有朋友同样想要进行优化开发，请同样按照 [README](https://github.com/Disassembler0/Win10-Initial-Setup-Script/blob/master/README.md) 所示来进行提交修改，谢谢。

（参照代码风格项目的 README 链接以后有时间后会重新按照本项目再写一下，外加可能做个中文翻译。）

项目结构、文件解释如下

```
.
├──  apply-all.ps1                  一键运行应用所有设定
├──  batchs                         一些以前写的 bat 文件,转到 pw 麻烦故留存
│   ├──  achive                     弃用的一些 bat 文件
│   │   ├──  environment_path.bat   
│   │   └──  old_achive.bat
│   ├──  context_menu_tweaks.bat    右键菜单优化
│   └──  sound_tweaks.bat           声音方案改为无声
├──  modules
│   ├──  apps_tweaks.psm1           系统 App 优化模块
│   ├──  environment_utils.psm1
│   ├──  install_apps.ps1           用于 App 安装，需要自定义
│   ├──  install_apps_tweaks.psm1   用于安装 App 的优化，需要自定义
│   ├──  install_drives.ps1         用于驱动安装，需要自定义
│   ├──  network_tweaks.psm1        网络设定优化模块
│   ├──  set_environments.ps1       用于设置环境变量，需要自定义
│   ├──  Set-BlueLight.psm1
│   ├──  system_tweaks.psm1         系统设定优化模块
│   ├──  tweak_default.ps1          默认优化调用，可自定义
│   ├──  ui_tweaks.psm1             系统 UI 设定优化模块
│   ├──  utils.psm1
│   └──  wallpapaer_utils.psm1
├──  README.md
├──  resources
│   ├──  configurations
│   │   ├──  notepad++               Notepad++ 个人主题及设定
│   │   │   ├──  config.xml
│   │   │   └──  npp_scruel.xml
│   │   └──  potplayer               PotPlayer 个人皮肤及设定
│   │       ├──  myZune.dsf
│   │       └──  PotPlayerMini64.ini
│   ├──  install                     office 安装选项模板文件 "/admin" 生成
│   │   ├──  office.MSP
│   │   └──  office.MSP.xml          
│   ├──  startmenu.xml               开始菜单，Export-StartLayout 导出
│   └──  TaskBar                     任务栏设定
│       ├──  lnks
│       │   ├──  desktop.ini
│       │   ├──  File Explorer.lnk
│       │   ├──  Firefox Developer Edition.lnk
│       │   ├──  Google Chrome.lnk
│       │   └──  Nightly.lnk
│       └──  taskbar.reg
└──  test.ps1                        默认引入所有模块，个人测试单个方法时用
```



```

```