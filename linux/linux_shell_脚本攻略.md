##初识脚本
打开终端，就会出现命令提示符。如下
```shell
username@hostname$
或者
username@hostname#
```
$表示普通用户，#表示管理员用户root。root是linux中权限最高的用户。

##脚本编写
shell脚本规范写法如下：
```shell
#!/bin/bash
```
上面为shell脚本的开头
/bin/bash是解释器命令路径。
脚本运行的两种方式：
  1.将脚本作为bash的命令参数
  2.给脚本赋予可执行权限将其变为可执行文件

bash中命令或是命令序列通过使用分号或换行符来分割。
bash中注释以#开始

终端打印
基本命令echo

