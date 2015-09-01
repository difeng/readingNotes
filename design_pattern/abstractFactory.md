#抽象工厂模式
标签（空格分隔）： 抽象工厂模式
####意图：
提供一个创建一系列相关或相互依赖对象的接口，而无需指定它们的具体类
####适用性：
> *一个系统要独立于他的产品的创建，组合和表示时
> * 一个系统要由多个产品中的一个来配置时
> * 当你强调一系列相关的产品对象的设计以便进行联合使用时
> * 当你提供一个产品类库，而只想显示它们的接口而不是实现时
 
####结构图实现：
![img](http://7xawio.com1.z0.glb.clouddn.com/design_pattern_abstractFactory.png)
---

```java
/**
* 声明一个创建抽象产品对象的操作接口
*/
public abstract class AbstractFactory {
	
       public  abstract AbstractProductA createProductA();
       
       public  abstract AbstractProductB createProductB();
}
```

```java
/**
*具体工厂1
*/
public class ConcreteFactory1 extends AbstractFactory{

	@Override
	public AbstractProductA createProductA() {
		// TODO Auto-generated method stub
		return new ProductA1();
	}

	@Override
	public AbstractProductB createProductB() {
		// TODO Auto-generated method stub
		return new ProductB1();
	}
     
}
```
```java
/**
*具体工厂2
*/
public class ConcreteFactory2 extends AbstractFactory {

	@Override
	public AbstractProductA createProductA() {
		// TODO Auto-generated method stub
		return new ProductA2();
	}

	@Override
	public AbstractProductB createProductB() {
		// TODO Auto-generated method stub
		return new ProductB2();
	}

}
```
```java
/**
*产品族AbstractProductA
*/
public class AbstractProductA {
       
}
```
```java
/**
*产品族AbstractProductB
*/
public class AbstractProductB {

}
```
```java
/**
*产品族AbstractProductA的具体产品ProductA1
*/
public class ProductA1 extends AbstractProductA {
       public ProductA1(){
    	   System.out.println("this is ProductA1");
       }
}
```
```java
/**
*产品族AbstractProductA的具体产品ProductA2
*/
public class ProductA2 extends AbstractProductA {
	 public ProductA2(){
  	   System.out.println("this is ProductA2");
     }
}
```
```java
/**
*产品族AbstractProductB的具体产品ProductB1
*/
public class ProductB1 extends AbstractProductB{

	public ProductB1(){
		System.out.println("this is ProductB1");
	}

}
```
```java
/**
*产品族AbstractProductB的具体产品ProductB2
*/
public class ProductB2 extends AbstractProductB{
	
	public ProductB2(){
		System.out.println("this is ProductB2");
	}
}
```





