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
