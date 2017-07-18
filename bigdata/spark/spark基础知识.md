## spark RDD
### 1. RDD概念
* 弹性分布式数据集(Resilient Distributed DataSet, 简称RDD)，在Spark上是不可变的分布式对象集合。

* RDD可被分区运行在集群中不同节点上
### 2. Spark创建RDD

* 方式一： 使用Spark的SparkContext对象读取外部数据集
* 方式二： 在驱动器中对一个集合进行并行化。使用SparkContext的parallelize方法

### 3. RDD转化和操作
* 基本转化操作 map、flatMap、filter、union等
* RDD的转化操作都是惰性求值的，意味着当我们对RDD调用转化操作时，操作不会立即执行，Spark只是在内部记录下所要求执行的相关信息。RDD可当做通过转化构造出来的记录如何计算数据的指令列表。数据读取和转化都是惰性求值的
* Spark使用lineage graph(谱系图)记录通过转化得到新的RDD与原RDD的关系，以便在数据丢失时恢复数据

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
|top(num)|从RDD中返回最前面的num个元素|
|takeOrdered(num)(Orderring)|从RDD中按提供的顺序返回最前面的num个元素|
|takeSample(withReplacement, num, [seed])|从RDD中返回任意一些元素|
|reduce(func)|并行整合RDD中所有数据|
|fold(zero)(func)|和reduce()一样，但是需要提供初始值|
|aggregate(zeroValue)(seqOp, combOp)|和reduce()类似，但通常返回不同类型的函数|
|foreach(func)|对RDD中每个元素使用给定的函数|


### 4. 持久化
持久化作用：避免多次计算同一个RDD

故障处理： 持久化存储一个RDD时，计算RDD的节点会分别保存它们所求出的分区数据。如果一个有持久化数据的节点发生故障，Spark会在需要用到缓存数据时重算丢失的数据分区。
persist()会把数据以序列化的形式缓存在JVM堆空间上

可以使用unpersist()将持久化的数据从内存中移除

|级别|使用空间|CPU时间|是否在内存中|是否在磁盘上|备注|
|:----:||||||
|MEMORY_ONLY|高|低|是|否||
|MEMORY_ONLY_SER|低|高|是|否||
|MEMORY_AND_DISK|高|中等|部分|部分|如果数据内存中放不下，则溢出写到磁盘上|
|MEMORY_AND_DISK_SER|低|高|部分|部分|如果数据在内存中放不下，则溢出写到磁盘上。在内存中存放序列化后的数据|
|DISK_ONLY|低|高|否|是||  

数据多内存不足的情况下，Spark会使用LRU的缓存策略2最老的分区从内存中移除


## pair RDD操作

pair RDD是键值对类型的RDD

#### pair RDD的转化操作

| 函数名 | 目的 |
|:----:|:----:|
|reduceByKey()| 合并具有相同键的值|
|groupByKe()|对具有相同键的值分组|
|combineByKey(createCombiner,mergeValue,mergeCombiners,partitioner)|使用不同的返回类型合并具有相同键的值|
|mapValues(func)|对RDD中的的每个值应用func函数，键不变|
|flatMapValues(func)|对pair RDD中的每个值应用一个返回迭代器的函数，然后对返回的每个元素都生成一个对应原键的键值记录|
|keys()|返回一个仅包含键的RDD|
|values()|返回一个劲包含值的RDD|
|sortByKey()|返回一个根据键排序的RDD|

#### 针对两个pair RDD（rdd1，rdd2）的转化操作
| 函数名 | 目的 |
|:----:|:----:|
|subtractByKey()| 删掉rdd1中与rdd2中键值相同的元素|
|join|对rdd1和rdd2进行内连接|
|rightOuterJoin|对rdd1和rdd2通过键来连接，去报rdd1中的键必须存在(右外连接)|
|leftOuterJoin|对rdd1和rdd2通过键来连接，去报rdd2中的键必须存在(左外连接)|
|cogroup|将rdd1和rdd2中拥有相同键的数据分组|

#### 聚合操作

reduceByKey(func): 与reduce(func)类似，不过是对键进行归约操作
foldByKey(zero)(func): 与fold类似
