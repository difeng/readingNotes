Mongodb��ʹ��
Mongdb������https://www.mongodb.org
Mongodb��飺
һ.mongodb�İ�װ(linuxƽ̨)
1.�������µİ汾
 wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.4.tgz 
2.��ѹ
 tar -zxvf mongodb-linux-x86_64-3.0.4.tgz
3.����mongodb��Ŀ¼������ѹ��mongodb���ļ���������Ŀ¼�£�����ֱ�ӽ�mongodb��ѹ����Ŀ¼�¡�
 cp  -R -n mongodb-linux-x86_64-3.0.4/ mongodb
4.����path
 ��mongodb�ӵ�path��,�༭~/.bashrc�ļ���
�����������,��path���У�������ӵ�path�о���
export PATH=<mongodb-install-directory>/bin:$PATH 
<mongodb-install-directory> ��mongodb�İ�װĿ¼
�������
 source  ~/.bashrc

����mongodb
1.����������ݵ�Ŀ¼
 Mongodb��Ĭ��Ŀ¼��/data/db,���߿����Խ����Ŀ¼��������
 ����Ĭ��֤mongodb��Ŀ¼��Ȩ�ޣ�����Ҫͨ������
 mongod --dbpath /������Ŀ¼ ,
 ����Ĭ��Ŀ¼
 mkdir -p /data/db
 Ҳ�ɴ���logĿ¼ͨ��
mongod --logpath /logĿ¼
������log��Ŀ¼
2.����mongodb
���
mongod
3.����mongodb����mongodb�������пͻ��˲鿴mongodb����Ϣ
ֱ�������
mongo
�ͻ���뵽mongodb

�鿴db
show dbs

����db
�л����ݿ�
use test
������һ������(table)��ʱ����Զ�������ǰ���ݿ�
db.createCollection("test")

show dbs

��������
db.test.insert({"name":"hello girl"})



