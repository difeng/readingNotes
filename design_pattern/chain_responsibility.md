# Chain of Responsibility(责任连模式)-行为模式
标签（空格分隔）： 设计模式
意图：
使多个对象都有机会处理请求，避免请求发送者和请求接受这之间的耦合。把接收对象连成一条链，请求沿着链条传递，直到一个对象处理它。
适用场景：
> * 不止一个对象处理请求,处理也没有优先级，在运行时刻自动处理
> * 想在不明确接收者的情况下，向多个对象中的一个提交请求
> * 可处理一个请求的对象集合，可以被动态指定

#### 结构图
![img](http://7xawio.com1.z0.glb.clouddn.com/design_pattern_chainOfResponsibility.png)

```java
public abstract class Handler {
	protected Handler handlerSuccessor;

	public Handler getHandlerSuccessor() {
		return handlerSuccessor;
	}

	public void setHandlerSuccessor(Handler handlerSuccessor) {
		this.handlerSuccessor = handlerSuccessor;
	}

	public abstract void HandleRequest();
}
```
```java
public class ConcreteHandler1 extends Handler {

	@Override
	public void HandleRequest() {
		if(getHandlerSuccessor() != null){
			System.out.println("ConcreteHandler1处理请求完毕，转发到下一个责任对象处理");
			getHandlerSuccessor().HandleRequest();
		}else{
			System.out.println("ConcreteHandler1处理请求");
		}
	}

}
```
```java
public class ConcreteHandler2 extends Handler {

	@Override
	public void HandleRequest() {
		if(getHandlerSuccessor() != null){
			System.out.println("ConcreteHandler2处理请求完毕，转发到下一个责任对象处理");
			getHandlerSuccessor().HandleRequest();
		}else{
			System.out.println("ConcreteHandler2处理请求");
		}
	}

}
```
```java
public class Client {
       public static void main(String [] args){
    	   Handler handler1 = new ConcreteHandler1();
    	   Handler handler2 = new ConcreteHandler2();
    	   //设置handler1的下个责任对象为handler2
    	   handler1.setHandlerSuccessor(handler2);
    	   //提交请求
    	   handler1.HandleRequest();
       }
}
```
demo1：
uml图:
![img](http://7xawio.com1.z0.glb.clouddn.com/design_pattern_chainOfResponsibilitydemo1.png)
```java
/**
*定义过滤器的接口
*/
public interface Filter {
	
       public void doFilter(Object request);
       
}
```
```java
/**
* 具体过滤器1
*/
public class ConcreteFilter1 implements Filter {
	
	public void doFilter(Object request) {
		System.out.println("请求经过ConcreteFilter1");
	}
	
}
```
```java
/**
* 具体过滤器2
*/
public class ConcreteFilter2 implements Filter {
	
	public void doFilter(Object request) {
		System.out.println("请求经过ConcreteFilter1");
	}
	
}
```
```java
/**
* 具体过滤器链
*/
public class FilterChain implements Filter {
	private List<Filter> filterChain = new ArrayList<Filter>();
    /**
     * 
     */
	public void doFilter(Object request) {
		for(Filter filter:filterChain){
			filter.doFilter(request);
		}
	}
	
	/**
	 * add filter
	 * @param filter
	 * @return current FilterChain instance 
	 */
	public FilterChain addFilter(Filter filter){
		filterChain.add(filter);
		return this;
	}

}
```






