# spark RDD
### 1.RDD概念
* 弹性分布式数据集(Resilient Distributed DataSet, 简称RDD)，在Spark上是不可变的分布式对象集合。

* RDD可被分区运行在集群中不同节点上
###Spark创建RDD

* 方式一： 使用spark的SparkContext对象读取外部数据集
* 方式二： 在驱动器中对一个集合进行并行化。使用SparkContext的parallelize方法



