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
几种用法
```shell
$ echo hello world
hello world
$ echo "hello world"
hello world
$ echo 'hello world'
hello world

```
注意：
> * 使用不带引号的echo时,没法在所要显示的文本中使用分号(;)
> * 变量替换在单引号中无效

另一个终端命令printf，使用方法与c语言中的printf方法类似
其中的格式替换符如下
%s,%c,%d,%f
默认为右对齐方式，若要左对齐%-

echo默认会在其末尾加上换行符
echo -e "包含转义序列的字符串"

###变量与环境变量
查看进程中运行时的环境变量
```shell
cat /pro/$PID/environ
```
变量赋值
var=value
var 为变量
value 为变量值
value中包含空格时必须用双引号

通过变量UID的值可以判断当前用户类型
root用户为0
其他用户大于0
可以输出UID的值echo $UID的值来判断

###使用shelljinxing数学运算
用let 命令执行基本的算术操作
```shell
 #!/bin/bash
 n1=1;
 b2=3;
 let n3=n1+n2;
 let n1++;
 let n2--;
 let n1+=3;
```
使用bc工具进行数学运算
使用例子
```shell
echo "12*2" | bc
24
n1=20;
result=`echo "$n1 * 2" | bc`
echo $result
40
```