#Dubbo框架的使用
###1. 构建dubbo的源码开发环境
从github上将整个dubbo项目全克隆下来
```shell
   git clone https://github.com/alibaba/dubbo.git
```
往eclipse中导入dubbo工程时要保证eclipse已经安装好了maven插件，并且你本地也已经装了maven。
在eclipse中通过import maven project将dubbo导入到eclipse中的工作空间中。导入好的dubbo项目如下图所示，有些项目中有红叉是因为xml中关于dubbo的前缀不识别的问题。
Dubbo整个大项目结构如下：

![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_1.png)
源码环境建好后，我们可以将dubbo的管理平台admin工程打包成war包供我们以下使用。
dubbo官网建议使用zookeeper作为注册中心。所以我们得上apache官网下载，下载链接如下：
http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz

###2. 搭建注册中心
1. 将下载好的zookeeper解压，将解压后的config目录下的zoo_sample.cfg的配置文件重命名为zoo.cfg。
启动注册中心：
进入到zookeeper的bin目录下
Windows下直接输入：zkServer.cmd 
Linux下: sh  zkServer.sh  start
启动后可以看到如下信息,至于日志和配置文件的路径和其中参数调整就不多说了，可以参考样例进行调整。
 ![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_2.png)
###3. 管理平台的服务启动
将打包好的dubbo-admin.war放到tomcat6的webapp下，启动tomcat6，tomcat6的启动就不多说了。
admin启动后：
访问admin可以被看到如下的admin界面：
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_3.png)
输入用户名：root,密码root，具体用户配置可去admin的配置文件dubbo.properties里
去配置

登陆后dubbo的首页
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_4.png)
这时去看提供者和消费者列表，可以看到都是空的。



###4. 启动服务监控者
在eclipse中启动给出额dubbo-monitor-simple，注意该项目是放在jetty中运行的。
在test下启动监控服务之前，先修改jetty的端口以免和之前的admin的服务端口冲突。
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_7.png)
监控服务启动后,访问地址如下：
http://127.0.0.1:8081/
进入到监控服务
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_8.png)
###5. 启动服务提供者
在eclipse中启动dubbo给出的dubbo-demo-provider，
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_9.png)
启动provider之前得改一test下的dubbo.properties文件中的注册中心的地址，修改为本地的zookeeper的地址。
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_10.png)
启动服务提供者后，可以看到服务注册到zookeeper上：
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_11.png)
到admin平台可看到此服务
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_12.png)

###6. 启动服务消费者

在eclipse中启动dubbo给出的dubbo-demo-consumer，
启动之前和服务提供者一样，先修改一下服务注册方的地址为本地zookeeper的地址
在test下启动consumer,可以看到消费者成功调用服务提供者的服务。

![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_13.png)
此时可以到admin平台看到此消费者
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_14.png)
到监控平台可以看到所有的服务提供者，消费者，监控者等等信息。
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_8.png)
可以看到注册中心的信息
![](http://7xawio.com1.z0.glb.clouddn.com/dubbo_16.png)
