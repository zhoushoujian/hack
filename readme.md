# Intersting-tools

```注意：本仓库所有程序仅用作技术交流，严禁用于破坏他人文档或程序```
```仓库地址: https://github.com/zhoushoujian/intersting-tools```

由于bat脚本默认使用GB2312的编码,如果你的编辑器默认使用utf-8,则会出现乱码,转换到GB2312编码即可

## folder-tree

可以将当前文件目录生成一张网页,运行```一键生成网页目录树\recursion.js```可以将当前目录及其子文件夹目录递归的生成相应的网页

注意: 脚本不能在中文目录下运行

## love

精简版的勒索病毒,使用bat+nodejs编写,默认加密桌面上Email文件夹里的内容,所以在运行之前需要在桌面上新建文件夹,名称为Email

```该程序入口文件为love/main.bat```,支持加密的文件类型有:

```.jpg .bmp .zip .exe .mp3 .wmv .doc .ppt .htm .xls .docx .png .gif .rar .txt .wma .mp4 .xls .pdf .lnk .pptx .html```

在加密之前先备份一下需要加密的文件,因为如果调试加密程序失误,很可能导致文件无法恢复

解密 => node love/decrypt.js

此程序除了可以加密文件,还可以关联加密文件的图标和更改桌面壁纸.所有加密都支持相应的解密

这里的加密只是做了些简单的混调,属于对称加密,想学习非对称加密的同学请戳这里```https://github.com/zhoushoujian/RSA-encrypt```

## prompt

这是一个可以让操作系统不停地弹错误提示框之类的程序，基于bat + nodejs, 弹框结束后会自动调用清理命令，将所有弹框清除掉。

入口文件: ```prompt\launch.bat```

## 一键获取U盘数据

一款可以窃取局域网内U盘数据的程序,提供bat版本和nodejs版本.

只要把程序运行在别人电脑上,程序会自动开机自启,然后轮训U盘是否插入.

如果发现有u盘接入,程序会自动拷贝u盘里的文件到局域网内指定的电脑上

## 百变壁纸锁屏

入口文件: ```壁纸锁屏.bat```

一款可以每次开机都使用不同的桌面背景和锁屏壁纸的软件,一共提供10张壁纸图片.

同时,锁屏壁纸和桌面壁纸同步更新,每次都使用相同的图片

## greetings

一款可以给出问候语的bat程序,前提是要知道对方的ip地址

当然,我们也可以不使用ip来判断对方的身份

## joke

一款可以让windows弹出提示框的程序,提示框的内容可以自定义

## 一键修复系统

一款可以自动修复系统文件损坏的程序

## 偷天换日

这是一个简易版的勒索病毒，实现原理是先创建一个叫jiaqq123456的windows账户，然后将其权限提升为系统管理员

然后更改当前使用的账户的密码为789(当然，中招的用户不会知道被改后的密码是什么)

最后，当用户重启电脑再次登录的时候就会提示密码错误，而且会有一个加qq123456的账户进行引导用户

## 双击一下你就知道

这是一个无限重启的病毒程序，实现原理是先用批处理写一个名称叫run.bat的脚本到此程序所在的文件夹，

脚本内容为shutdown -g，也就是倒计时一分钟重启，这里的时间是可以设置的。

写完后将run.bat复制到开机启动的文件夹内，并将刚刚源文件删除，

最后通过call命令调用刚刚复制到开机启动的文件夹内的run.bat文件
