Mongodb的使用
Mongdb官网：https://www.mongodb.org
Mongodb简介：
一.mongodb的安装(linux平台)
1.下载最新的版本
 wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.4.tgz 
2.解压
 tar -zxvf mongodb-linux-x86_64-3.0.4.tgz
3.建立mongodb的目录，将解压好mongodb的文件拷贝到此目录下，或者直接将mongodb解压到此目录下。
 cp  -R -n mongodb-linux-x86_64-3.0.4/ mongodb
4.配置path
 将mongodb加到path里,编辑~/.bashrc文件。
添加如下内容,若path已有，将其添加到path中就行
export PATH=<mongodb-install-directory>/bin:$PATH 
<mongodb-install-directory> 是mongodb的安装目录
配置完后
 source  ~/.bashrc

运行mongodb
1.创建存放数据的目录
 Mongodb的默认目录是/data/db,或者可以自建别的目录，但必须
 创建默保证mongodb有目录的权限，并且要通过命令
 mongod --dbpath /创建的目录 ,
 创建默认目录
 mkdir -p /data/db
 也可创建log目录通过
mongod --logpath /log目录
来设置log的目录
2.运行mongodb
命令：
mongod
3.连接mongodb，在mongodb的命令行客户端查看mongodb的信息
直接用命令：
mongo
就会进入到mongodb

查看db
show dbs

创建db
切换数据库
use test
当创建一个集合(table)的时候会自动创建当前数据库
db.createCollection("test")

show dbs

插入数据
db.test.insert({"name":"hello girl"})



