#java性能监控工具Btrace的使用

###1.btrace的简介
BTrace是java平台上一种安全的，动态的跟踪工具。BTrace可用于动态跟踪运行中的Java程序。Btrace可以在目标程序的字节码中中注入跟踪代码(字节码跟踪)。

###2.btrace的安装（以linux平台为例）
去Btrace的官网下载Btrace安装包btrace-bin.tar.gz，这里下的是1.2.5.1的版本
```shell
[root@localhost ~]# wget https://kenai.com/projects/btrace/downloads/download/releases/release-1.2.5.1/btrace-bin.tar.gz
```
将下载下来的btrace解压到目标文件夹。
```shell
[root@localhost ~]# mkdir /usr/local/btrace
[root@localhost ~]# tar -zxvf btrace-bin.tar.gz -C /usr/local/btrace
```
然后配置BTRACE_HOME，编辑/etc/profile文件，在path中加入btrace。
BTRACE_HOME的值
```
export BTRACE_HOME=/usr/local/btrace
```
将btrace加入到path中。
```shell
$BTRACE_HOME/bin
```
配置完成后在命令行输入btrace，即可看到如下信息。
```sh
[root@localhost ~]# btrace
Usage: btrace <options> <pid> <btrace source or .class file> <btrace arguments>
where possible options include:
  -classpath <path> Specify where to find user class files and annotation processors
  -cp <path>        Specify where to find user class files and annotation processors
  -I <path>         Specify where to find include files
  -p <port>         Specify port to which the btrace agent listens for clients
```
3.编写待监控的程序。
```java
package com;

import java.util.Random;

public class Case1 {
	public static void main(String[] args) throws Exception {
		CaseObject caseObject = new CaseObject();
		Random random = new Random();
		boolean ret = true;
        while(ret){
        	caseObject.execute(random.nextInt(1000));
        	Thread.sleep(1000);
        }
	}
}

class CaseObject{
	public boolean execute(int sleepTime)throws Exception{
		System.out.println("sleep:" + sleepTime);
		Thread.sleep(sleepTime);
		return true;
	}
}
```
###4.写监控脚本
a.获取类CaseObject的方法exute调用时传的参数，返回值。
```java
import static com.sun.btrace.BTraceUtils.*;
import com.sun.btrace.annotations.*;
@BTrace public class CaseTraceMethodArgsAndReturn{
@OnMethod(
clazz="com.CaseObject",
method="execute",
location=@Location(Kind.RETURN)
)
public static void traceExecute(int     sleepTime,@Return boolean result){
   println("call CaseObject.execute");
   println(strcat("sleepTime is:",str(sleepTime)));
   println(strcat("return value is:",str(result)));
   }
}
```

b.获取excute执行耗时
```java
import com.sun.btrace.annotations.*;
import static com.sun.btrace.BTraceUtils.*;
@BTrace public class  CaseTraceMethodExcuteTime{
   @OnMethod(clazz = "com.CaseObject", method = "execute",location =       @Location(Kind.RETURN))
    public static void onExecuteReturn(@Duration long durationL) {
        int duration = (int) durationL / 1000000;
        println(strcat("excute method time is ",strcat(str(duration)," ms ")));
    }
}
```
c.获取方法的调用者
```java
import com.sun.btrace.annotations.*;
import static com.sun.btrace.BTraceUtils.*;
@BTrace public class CaseTraceMethodInvoker{
   @OnMethod(clazz = "com.CaseObject", method = "execute")
    public static void getInvoker() {
       println("who call CaseObject.execute :");
       jstack();
    }
}
```
###5.运行监控脚本
a.编译被监测程序
```shell
[root@localhost demo]# javac com/Case1.java 
```
b.监控程序启动
```shell
[root@localhost demo]# java com/Case1
[root@localhost demo]# java com/Case1
sleep:426
sleep:160
sleep:515
```
c.通过jps获取被监控程序的进程号
```shell
[root@localhost btrace]# jps
19354 Jps
19272 Case1
```
d.执行监控脚本
获取方法执行参数和返回值
```shell
[root@localhost btrace]# btrace -cp build/ -p 2021 19272 CaseTraceMethodArgsAndReturn.java  
call CaseObject.execute
sleepTime is:578
return value is:true
```
获取方法的执行时间
```shell
[root@localhost btrace]# btrace -cp build/ -p 2021 19272 CaseTraceMethodExcuteTime.java 
excute method time is 282 ms 
excute method time is 81 ms 
```
获取方法的调用者
```shell
[root@localhost btrace]# btrace -cp build/ -p 2021 19272 CaseTraceMethodInvoker.java 
who call CaseObject.execute :
com.CaseObject.execute(Case1.java)
com.Case1.main(Case1.java:11)
```