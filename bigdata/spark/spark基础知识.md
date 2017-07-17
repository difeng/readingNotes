# spark RDD
### 1. RDD概念
* 弹性分布式数据集(Resilient Distributed DataSet, 简称RDD)，在Spark上是不可变的分布式对象集合。

* RDD可被分区运行在集群中不同节点上
### 2. Spark创建RDD

* 方式一： 使用spark的SparkContext对象读取外部数据集
* 方式二： 在驱动器中对一个集合进行并行化。使用SparkContext的parallelize方法

### 3. RDD转化和操作
基本转化操作 map、flatMap、filter、union等

Spark使用lineage graph(谱系图)记录通过转化得到新的RDD与原RDD的关系，以便在数据丢失时恢复数据

对RDD基本的转化操作

| 函数名 | 目的 |
|:----:|:----:|
|map()| 将函数应用于RDD中的每个元素，将返回结果构成新的RDD|
|flatMap()|相当于将map的结果扁平化|
|filter()| 返回一个通过传给filter()的函数的元素组成的RDD|
|distinct()|去重|
|sample(writeReplacement, fraction, [seed])|对RDD采样，以及是否替换|

针对两个RDD的转化操作

| 函数名 | 目的 |
|:----:|:----:|
|union| 生成一个包含两个RDD中所有元素的RDD|
|intersection()|求了个RDD共同的RDD|
|subtract()| 移除一个RDD中的内容|
|cartesian()|与另一个RDD的笛卡尔积|

对RDD的行动操作

| 函数名 | 目的 |
|:----:|:----:|
|collect()| 返回RDD中的所有元素|
|count()|RDD的个数|
|countByValue()| 各元素在RDD中出现的次数|
|take(num)|从RDD中返回num个元素|
|take(num)|从RDD中返回num个元素|
|take(num)|从RDD中返回num个元素|
|take(num)|从RDD中返回num个元素|
|take(num)|从RDD中返回num个元素|
|take(num)|从RDD中返回num个元素|














































