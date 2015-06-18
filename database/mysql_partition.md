#mysql的分区的使用
###myswql分区的类型有如下几种：
####1.range分区
按变化的区间将表分成不同区块，使用VALUES LESS THAN操作符来进行定义变化的区间，这些区间要连续且不重复
例如：
```mysql
create table `student`(
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(3),
  `store_id` int(11)
)
partition by range(`id`)(
    PARTITION p0 VALUES LESS THAN (6),
    PARTITION p1 VALUES LESS THAN (11),
    PARTITION p2 VALUES LESS THAN (16),
    PARTITION p3 VALUES LESS THAN (21)
);
```
最好做法是再分一个最小上界的分区,当数据范围不在前面的分区时，将数据放到此分区下，以后通过重新分区再将此分区分为几个固定区间和一个最小上界区间。
```sql
create table `student`(
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(3),
  `store_id` int(11)
)
partition by range(`id`)(
    PARTITION p0 VALUES LESS THAN (6),
    PARTITION p1 VALUES LESS THAN (11),
    PARTITION p2 VALUES LESS THAN (16),
    PARTITION p3 VALUES LESS THAN (21),
    PARTITION pmax VALUES LESS THAN MAXVALUE 
);
```
####2.LIST分区
list分区是基于列值去匹配一个离散集合中的值来进行选择。
离散集合也可以用一个表达式来确定。
例如：
```sql
create table `student`(
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(3),
  `store_id` int(11)
)
PARTITION BY LIST(store_id) (
    PARTITION pNorth VALUES IN (3,5,6,9,17),
    PARTITION pEast VALUES IN (1,2,10,11,19,20),
    PARTITION pWest VALUES IN (4,12,13,14,18),
    PARTITION pCentral VALUES IN (7,8,15,16)
);
```
####3.columns分区
与range和list不同的是columns允许分区键使用多个列，columns配合range和list使用的。
例如：
```sql
create table `student`(
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(3),
  `store_id` int(11)
)
partition by range columns(`id`,`store_id`)(
    PARTITION p0 VALUES LESS THAN (6,10),
    PARTITION p1 VALUES LESS THAN (11,20),
    PARTITION p2 VALUES LESS THAN (16,30),
    PARTITION p3 VALUES LESS THAN (21,40),
    PARTITION pmax VALUES LESS THAN (MAXVALUE,MAXVALUE)
);
```
####4.hash分区
通过指定规则，将数据均匀地分布到各个区中



###mysql子分区使用
####1.建表：
```sql
CREATE TABLE `test_sub_partition` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '表id',
  `other_key` BIGINT(20) NOT NULL,
  `value` BIGINT(20) NOT NULL,
  `test_time` DATETIME DEFAULT NULL,
   KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1058080 DEFAULT CHARSET=utf8
  PARTITION BY RANGE (TO_DAYS(`test_time`))
  SUBPARTITION BY HASH(other_key%10)
  SUBPARTITIONS 10
  (
 PARTITION p20150616 VALUES LESS THAN (736130),
 PARTITION pmax VALUES LESS THAN MAXVALUE) 
```
 主分区以“test_time”进行range分区，一天分一个区，在每个主分区下再以(other_key%10)进行子分区，是数据均匀放到每个子分区,也就是说other_key%10余几就放到哪个分区里。
分区后可以去mysql的数据库目录下进行查看，由于上面为指定子分区名称，所以子分区名称组织是这样的：主分区名称+sp+序号

通过从数据库schema里面也可查出相关此表的分区信息
```sql
SELECT table_name,partition_name,subpartition_name,partition_method,subpartition_method,partition_expression,subpartition_expression,partition_description FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME='test_sub_partition';  
```

####2.插入数据
```sql
INSERT INTO `test_sub_partition`(other key,test_time) VALUES(0,'2015-06-16'),(1,'2015-06-17'),(2,'2015-06-16'),(3,'2015-06-17'),(4,'2015-06-16'),(5,'2015-06-17'),(6,'2015-06-16'),(7,'2015-06-17'),(8,'2015-06-16'),(9,'2015-06-17'),(10,'2015-06-16'),(11,'2015-06-17'),(12,'2015-06-16'),(13,'2015-06-17'),(14,'2015-06-16'),(15,'2015-06-17'),(16,'2015-06-16'),(17,'2015-06-17'),(18,'2015-06-16'),(19,'2015-06-17'),(20,'2015-06-16'),(21,'2015-06-17'),(22,'2015-06-16'),(23,'2015-06-17'),(24,'2015-06-16'),(25,'2015-06-17'),(26,'2015-06-16'),(27,'2015-06-17'),(28,'2015-06-16'),(29,'2015-06-17'),(30,'2015-06-16'),(31,'2015-06-17'),(32,'2015-06-16'),(33,'2015-06-17'),(34,'2015-06-16'),(35,'2015-06-17'),(36,'2015-06-16'),(37,'2015-06-17'),(38,'2015-06-16'),(39,'2015-06-17'),(40,'2015-06-16'),(41,'2015-06-17'),(42,'2015-06-16'),(43,'2015-06-17'),(44,'2015-06-16'),(45,'2015-06-17'),(46,'2015-06-16'),(47,'2015-06-17'),(48,'2015-06-16'),(49,'2015-06-17'),(50,'2015-06-16'),(51,'2015-06-17'),(52,'2015-06-16'),(53,'2015-06-17'),(54,'2015-06-16'),(55,'2015-06-17'),(56,'2015-06-16'),(57,'2015-06-17'),(58,'2015-06-16'),(59,'2015-06-17'),(60,'2015-06-16'),(61,'2015-06-17'),(62,'2015-06-16'),(63,'2015-06-17'),(64,'2015-06-16'),(65,'2015-06-17'),(66,'2015-06-16'),(67,'2015-06-17'),(68,'2015-06-16'),(69,'2015-06-17'),(70,'2015-06-16'),(71,'2015-06-17'),(72,'2015-06-16'),(73,'2015-06-17'),(74,'2015-06-16'),(75,'2015-06-17'),(76,'2015-06-16'),(77,'2015-06-17'),(78,'2015-06-16'),(79,'2015-06-17'),(80,'2015-06-16'),(81,'2015-06-17'),(82,'2015-06-16'),(83,'2015-06-17'),(84,'2015-06-16'),(85,'2015-06-17'),(86,'2015-06-16'),(87,'2015-06-17'),(88,'2015-06-16'),(89,'2015-06-17'),(90,'2015-06-16'),(91,'2015-06-17'),(92,'2015-06-16'),(93,'2015-06-17'),(94,'2015-06-16'),(95,'2015-06-17'),(96,'2015-06-16'),(97,'2015-06-17'),(98,'2015-06-16'),(99,'2015-06-17')
```
3.验证
```sql
EXPLAIN PARTITIONS SELECT * FROM test_sub_partition WHERE test_time= '2015-06-16' AND other_key IN (1,11,21,31,41,51,61,71,81,91)
 
EXPLAIN PARTITIONS SELECT * FROM test_sub_partition WHERE test_time= '2015-06-16' AND other_key IN (2,12,22,32,42,52,62,72,82,92)

