## 1.Storm总体结构

* Stream是被处理的数据
* Spout是数据源
* Bolt封装了数据处理逻辑
* Worker是工作进程
* Excutor是运行Spout或者Bolt的处理逻辑的线程
* Task是Strom中最小的处理单元。一个Excutor中可以包含一个或者多个Task,消息的分发都是从一个Task到另一个Task。
* Stream Grouping定义了消息分发策略，定义了Bolt节点以何种方式接收数据
* Topology是有消息分组方式连接起来的Spout和Bolt节点网络，它定义了运算处理的拓扑结构，处理的是不断流动的消息。除非杀掉Topology，否则他将永远运行下去。

![](http://7xawio.com1.z0.glb.clouddn.com/storm_structure.png)

Storm中消息来源节点被称为Spout，消息处理节点被称为Bolt。在系统中可存在多个Spout和Bolt

![](http://7xawio.com1.z0.glb.clouddn.com/storm_spout_bolt.png)

Storm在zookeeper中的元数据

![](http://7xawio.com1.z0.glb.clouddn.com/storm_metadata.png)

Storm在zookeeper中的元数据的交互

![](http://7xawio.com1.z0.glb.clouddn.com/storm_metadata_use.png)

## 2.Storm中的一些基础概念

### 1.Fields定义
Fields用于存储消息的字段名列表，其所需参数为其所有字段名集合。

### 2.Tuple接口
Tuple是Storm中主要的数据结构。在发送接收消息的过程中，每一条消息实际上都是一个Tuple对象。

### 3.常用声明接口
配置声明接口
ComponentConfigurationDeclarer定义了一些和组件相关的配置项。可级联使用。
输入声明接口
InputDeclarer，可级联使用。
输出字段声明接口
OutputFieldsDeclarer
组件声明接口
SpoutDeclarer和BoltDeclarer

### 4.Spout输出收集器
输出收集器的接口ISpoutOutputCollector
默认实现SpoutOutputCollector

### 5.Bolt输出收集器
Bolt处理好的消息都是通过输出收集器发送出去的，不同类型的Bolt所使用额输出收集器是不同的

* IRichBolt：使用OutputCollector输出收集器，该收集器实现的是IoutputCollector接口
* IBasicBolt:使用BasicOutputCollector输出收集器，实现的是IBasicOutputCollector
* IBatchBolt:使用BatchOutputCollector

### 6.组件接口
组件接口IComponent定义了如下两个方法
* declareOutputFields方法：用于定义组件的Schema
* getComponentConfiguration方法:用来描述一些与组件相关的配置

### 7.Spout接口
* ISpout
* IRichSpout:同时实现了ISpout和IComponent接口

### 8.Bolt接口
* IBolt
* IRichBolt：常用来定义Topology组件接口。灵活可控制Ack、Fail和Anchor操作
* IBasicBolt：简单逻辑的Topology组件接口，Storm内置实现了Ack、Fail和Anchor的机制

* IBatchBolt：处理批量数据的接口。用于事务Topology中，是Storm实现事务Topology的基础

Bolt是storm中的基础运行单位，当其启动并有消息输入时，将调用execute方法来进行处理。IBolt对象再提交时也会被序列化为字节数组，具体执行节点通过反序列化的方法得到该对象，并调用prepare回调方法

### 9.Storm数据结构

#### GlobalStreamId
消息的渠道。每种类型的消息可以用一个流来表示。组件可以向多个流发送消息，也可以从多个流接收消息。

#### 消息分组方式
分组方式Grouping决定了组件发送的消息将以何种方式到达接收端。
例如，使用随机分组，节点可以发送一组消息到下游的多个节点，每个节点收到这组消息的一部分，而且这些节点可以分布在不同的机器上，从而达到了并行处理的目的。

#### StreamInfo
有两个成员：

* 输出字段的列表
* 是否为直接流字段

#### ShellComponent
用于与非java语言交互，目前通过标准输入输出来交换数据

#### ComponentObject




