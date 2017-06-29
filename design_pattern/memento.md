# memento（备忘录）-对象行为模式
#### 意图：
在不破坏分装性的前提下，捕获一个对象的内部状态，并在改对象的外部保存。
#### 适用性：
> * 必须保存一个对象在某一个时刻的（部分）状态，这样以后需要时它才能恢复到先前之前的状态。
> * 如果一个用接口来让其他对象直接得到这些状态，将会暴漏对象的实现细节并破坏对象的封装性。

结构：
![img](http://7xawio.com1.z0.glb.clouddn.com/design_pattern_memento.png)
#### 原发者:
原发者，也就是需要备忘录的一类对象
```java
public class Originator {
   //原发者的状态
	Object state;
	public void setMemento(Memento memento){
		this.state = memento.getState();
	}
    //创建备忘录
	public Memento  createMemento(){
		return new Memento(state);
	}
}
```
#### 备忘录：
用来记录原发者的内部状态
```java
public class  Memento {
      private Object state;
      public Memento(Object state){
    	  this.state = state;
      }
      public Object getState(){
    	  return this.state;
      }
      public void setState(Object state){
    	  this.state = state;
      }
}
```
#### 守护者：
使用备忘录记录原发者的信息
```java
public class Caretaker {
	Memento memento = new Memento(); 
	public void setMemento(Memento memento){
     	this.memento = memento;
	}
	public Memento getMemento(){
		return stack.pop();
	}
}
```
#### 客户端
```java
public class Client {
	public static void main(String[] args){
	    //创建状态守护者
        Caretaker taker = new Caretaker();
        //创建原发者
        Originator orig = new Originator();
        //原发者设置状态
        orig.state = "open";
        System.out.println("origin's state  is " + orig.state);
        //守护者保存原发者的状态
        taker.save(orig.createMemento());
        //守护者恢复原发者的状态
        orig.setMemento(taker.resume());
        System.out.println("after resume,originator's state  is " + orig.state);
	}
}

```





