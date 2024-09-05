# <center>common</center>

--------------------------------------------------------------------------------

## 📚简介<br>

[common](https://darrenyou.cn/ohpm)
基于API12的鸿蒙工程通用基础能力库，例如：日志、文件、网络、数据库、设备信息、屏幕适配等。

## 📚下载安装<br>
查询包信息<br>
`ohpm info @darren/common --registry https://darrenyou.cn/repos/ohpm`<br><br>
---
指定私仓地址引入依赖（操作路径切换到对应modules例如：entry、otherModules目录下，模块级引入依赖而非工程级）<br>
`ohpm install @darren/common --registry https://darrenyou.cn/repos/ohpm`<br><br>
---
也可为所有项目配置该私有仓地址，例如执行以下命令：<br>
ohpm registry 官方： `https://repo.harmonyos.com/ohpm/`<br><br>
`ohpm config set registry <ohpm-repo私仓服务地址>`<br><br>
在oh-package.json5文件中添加依赖<br>
`"dependencies": {"@darren/common": "^1.0.0"}`<br><br>
操作路径切换到oh-package.json5对应的modules根目录下执行<br>
`ohpm install`
<br><br>
---
引用共享包:  [官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-har-import-0000001547293682-V5)<br>
OpenHarmony三方库中心仓-文档:   [OpenHarmony三方库中心仓-文档](https://ohpm.openharmony.cn/#/cn/help/downloadandinstall)<br>
ohpm常用命令:   [ohpm](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-ohpm-common-commands-0000001796516473-V5)<br>
<br><br>