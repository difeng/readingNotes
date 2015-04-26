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

###使用shell进行数学运算
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
bc中设置小数精度
```shell
echo "scale=2;5/8" | bc
0.62
```
bc中进制转换
```shell
十进制转二进制
echo "obase=2;4" | bc
100
二进制转十进制
echo "obase=10;ibase=2;100" | bc
4
```
计算平方及平方根
```shell
echo "sqrt(10)" | bc
3
echo "3^3" | bc
27
```
#文件描述符和重定向
 * 1 stdin 标准输入
 * 2 stdout 标准输出
 * 3 stderr 标准错误

####文件打开的几种模式
 * 只读模式 (<)
 * 截断写入模式(>)
 * 追加写入模式(<<)

\> 先清空，再写入内容

\>> 将内容追加到文件尾部

重定向使用默认标准输出，使用特定文件操作符时如下：

\> 等同于 1>

\>> 等同于 1>>
 
使用实例
```shell
将hell字符串写到input.txt文件中
echo hello > input.txt
将操作中的错误信息写到文件input.txt中
ls - 2> input.txt
more input.txt
ls: 无法访问-: 没有那个文件或目录

使用自定义文件描述符
exec 3>input.txt 
echo hello >&3
more input.txt 
hello

exec 4< input.txt 
cat <&4
hello

文件描述符只能使用一次，若要再次使用，在重新声明

```
#数组和关联数组
数组定义的几种
```shell
arr={t1,t2,t3}
或者
arr[0]="t1"
arr[1]="t2"
arr[3]="t3"
打印数组
echo ${arr[0]}
t1
echo ${arr[*]}
t1
t2
t3

```
关联数组定义
关联数组可以用任意的文本作为数组的索引
```shell
declare -A arr
赋值
arr=([index1]=val1 [index2]=val2)
或者
arr[index1]=val1
arr[index2]=val2
输出索引
echo ${!arr[*]}
index1 index2

#获取、设置日期和延时
```shell
date
2015年 04月 25日 星期六 10:46:29 CST
date +%s
1429930002
```

#函数和参数
 定义：
```shell
function  fname(){
   statements;
}
或
fname(){
  statements;
}
调用时使用函数名即可
fname;
传参数
fname arg1 arg2;
参数接收
fname(){
 echo $1,$2; #参数1,参数2
 echo "$@"; #打印参数列表
}
```                                          


