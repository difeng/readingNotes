1.先在master上创建一个用户用来复制。
mysql> grant replication slave,replication client on *.* to repl@'%' identified by 'repl' with grant option
mysql> flush privileges;
master的my.cnf配置文件配置如下：
server_id = 1
log_bin = mysql-bin
从服务器的my.cnf配置如下：
log_bin = mysql-bin
server_id = 2
relay_log = mysql-relay-log
log_slave_updates = 1
read_only = 1
在从服务器上执行如下命令：
```sh
mysql> change master to master_host='cherry',
    -> master_user = 'repl',
    -> master_password='repl',
    -> master_log_file='mysql-bin.000001',
    -> master_log_pos=0;
```
启动slave：
```sh
mysql> start slave;
Query OK, 0 rows affected (0.00 sec)
```
查看slave状态:
```sh
mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: cherry
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000001
          Read_Master_Log_Pos: 107
               Relay_Log_File: mysql-relay-log.000002
                Relay_Log_Pos: 253
        Relay_Master_Log_File: mysql-bin.000001
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
```
查看复制线程：
```sh
mysql> show processlist\G;
*************************** 1. row ***************************
     Id: 40
   User: root
   Host: localhost
     db: NULL
Command: Query
   Time: 0
  State: NULL
   Info: show processlist
*************************** 2. row ***************************
     Id: 41
   User: system user
   Host: 
     db: NULL
Command: Connect
   Time: 185
  State: Waiting for master to send event
   Info: NULL
```
在master上新建一个数据库test;
```sh
mysql> show databases;
+-------------------------+
| Database                |
+-------------------------+
| information_schema      |
| dbtest                  |
| mysql                   |
| performance_schema      |
| qualityinsight          |
| qualityinsight_wireless |
+-------------------------+
6 rows in set (0.00 sec)

mysql> create database test;
Query OK, 1 row affected (0.00 sec)
```
在slave上查看：
```sh
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
3 rows in set (0.00 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| test               |
+--------------------+
4 rows in set (0.00 sec)```
###下载并安装mysql-proxy
 去mysql官网下载mysql-proxy的二进制安装文件
将其解压到
/usr/local下然后将其添加到系统path中去
例如:
下载的包为mysql-proxy-0.8.5-linux-glibc2.3-x86-64bit.gz
```sh
 cd /usr/local
 tar -xvf mysql-proxy-0.8.5-linux-glibc2.3-x86-64bit.gz
```
解压后为：
```sh
    /usr/local/mysql-proxy-0.8.5-linux-glibc2.3-x86-64bit
```
配置系统path,编辑/etc/profile文件，在其中添加path。
```sh
    PATH=$PATH:/usr/local/mysql-proxy-0.8.5-linux-glibc2.3-x86-64bit/bin
```
使path生效
```sh
    source /etc/profile
```
使用命令：
```sh
    mysql-proxy --help
```
```sh
mysql> grant all on *.* to 'proxy'@'cherry' identified by 'proxy';
Query OK, 0 rows affected (0.07 sec)

mysql> flush privileges;
Query OK, 0 rows affected (0.02 sec)
```
启动mysql-proxy，并加载读写分离脚本splitting.lua
```sh
mysql-proxy --proxy-address=cherry:4040 --proxy-backend-addresses=cherry:3306 --proxy-read-only-backend-addresses=dizi:3306 --proxy-lua-script=/usr/local/mysql-proxy/share/doc/mysql-proxy/rw-splitting.lua
2015-06-28 00:12:50: (critical) plugin proxy 0.8.5 started
```
测试读写分离

1.连接代理 
```sh
~$ mysql -uproxy -p -h cherry -P 4040

mysql> create database test;
Query OK, 1 row affected (0.02 sec)

mysql> use test
Database changed

mysql> create table `test_webpage`(   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表id', `name` varchar(50) DEFAULT NULL,    KEY `id` (`id`) );ERROR 1050 (42S01): Table 'test_webpage' already exists
mysql> create table `student`(   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表i', `name` varchar(50) DEFAULT NULL,    KEY `id` (`id`) );
Query OK, 0 rows affected (0.10 sec)

mysql> insert into student values(1,'apple');
Query OK, 1 row affected (0.12 sec)

mysql> select * from student;
+----+-------+
| id | name  |
+----+-------+
|  1 | apple |
+----+-------+
1 row in set (0.00 sec)

```

2.登上slave
```sh
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| test               |
+--------------------+
3 rows in set (0.00 sec)

mysql> use test
Database changed

mysql> show tables;
+----------------+
| Tables_in_test |
+----------------+
| student        |
+----------------+
1 rows in set (0.00 sec)

mysql> select * from student;
+----+-------+
| id | name  |
+----+-------+
|  1 | apple |
+----+-------+
1 row in set (0.00 sec)


```
3.停掉slave上的复制线程
```shell
mysql> slave stop;
Query OK, 0 rows affected (0.09 sec)

```
4.在连接的代理端，向student表中添加一条数据
```sh
mysql> insert into student values(2,'cherry');
Query OK, 1 row affected (0.12 sec)

```
5.到student中查看
```sh
mysql> select * from student;
+----+-------+
| id | name  |
+----+-------+
|  1 | apple |
+----+-------+
1 row in set (0.00 sec)

```
说明写是在master上执行的

在代理端查询

```sh
mysql> select * from test.student;
+----+-------+
| id | name  |
+----+-------+
|  1 | apple |
+----+-------+
1 row in set (0.00 sec)
```
说明是从从服务器上查的
