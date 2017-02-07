###Storm总体结构

* Stream是被处理的数据
* Spout是数据源
* Bolt封装了数据处理逻辑
* Worker是工作进程
* Excutor是运行Spout或者Bolt的处理逻辑的线程
* Task是Strom中最小的处理单元。一个Excutor中可以包含一个或者多个Task,消息的分发都是从一个Task到另一个Task。
* Stream Grouping定义了消息分发策略，定义了Bolt节点以何种方式接收数据