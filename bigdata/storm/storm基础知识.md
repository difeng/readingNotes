###Storm总体结构

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