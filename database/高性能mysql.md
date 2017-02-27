#1.1 mysql逻辑架构
mysql逻辑架构图:
![](http://7xawio.com1.z0.glb.clouddn.com/mysql_1_%E6%9E%B6%E6%9E%84%E5%9B%BE.png)
第一层：连接处理、授权认证、安全等等

第二层：查询解析、分析、优化、缓存以及所有内置函数，所有存储引擎的功能都在这一层实现：存储过程、触发器、视图等

第三层：存储引擎。存储引擎负责MySql中的数据的存储和提取


###服务器端缓存查询线程，每一个客户端连接上来都使用一个线程。


###使用explain查看优化器的优化过程，可通过重构查询和schema、修改配置来调优sql使之可能高效运行。


###对于select语句，在解析查询之前会先检查查询缓存(Query Cache)。如果能命中，则会直接返回其中的结果器，不必再解析查询。


###并发控制使用
读写锁

粒度锁

事务


隔离级别
  READ UNCOMMITTED(未提交读)
  READ COMMITTED(提交读)
  REPEATABLE READ(可重复读)
  SERIALIZABLE(可串行化)

![](http://7xawio.com1.z0.glb.clouddn.com/mysql_1_%E9%9A%94%E7%A6%BB%E7%BA%A7%E5%88%AB.png)