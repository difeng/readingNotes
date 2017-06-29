# proxy(代理模式)
### 意图：
提供一个供其他对象使用的代理对象
### 适用场景：
> *1.远程代理
> *2.虚拟代理
> *3.保护代理
> *4.智能指针

结构图：
![img](http://7xawio.com1.z0.glb.clouddn.com/design_pattern_proxy.png)
实现:
Proxy和Realsubject定义的公共接口
```java
/***
 * 为 Proxy和Realsubject定义的公共接口
 */
public abstract class Subject {
       public abstract void request();
}
```
实际服类RealSubject
```java
/***
 * 实际服务的类
 */
public class RealSubject extends Subject {
	@Override
	public void request() {
		System.out.println("I am RealSubject,request is ok");
	}
	
}
```
代理类：
```java
/***
 * 代理类
 */
public class Proxy extends Subject {
    private  RealSubject realSubject = new RealSubject();
	@Override
	public void request() {
		System.out.println("I am Proxy,resquest is Ok!");
		realSubject.request();
	}

}
```
客户端调用
```java
public class Client {
	public static void main(String [] args){
		Proxy proxy = new Proxy();
		proxy.request();
	}
}
```





