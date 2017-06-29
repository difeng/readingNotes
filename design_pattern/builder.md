# Builder(生成器)-对象创建型模式
#### 意图：
将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示
#### 适用性：
> * 在以下情况使用Builder模式
> * 当创建负载对象的算法应该独立于该对象的组成部分以及他们的装配方式
> * 当构造的过程必须允许被构造的对象有不同的表示时

#### 结构：
![img](http://7xawio.com1.z0.glb.clouddn.com/design_pattern_builder_demo1.png)
#### 实现：
```java
public abstract class Builder {
       public abstract void buildPart1();
       public abstract void buildPart2();
       public abstract Product  getResult();
}
```
```java
public class ConcreteBuilder extends Builder {
    private Product product = new Product();

	public Product getResult() {
		// TODO Auto-generated method stub
		return product;
	}

	@Override
	public void buildPart1() {
		product.setPart1("part1");
	}

	@Override
	public void buildPart2() {
		product.setPart2("part2");
	}

}
```
```java
public class Product {
	private Object part1;
	private Object part2;
	public Object getPart1() {
		return part1;
	}
	public void setPart1(Object part1) {
		this.part1 = part1;
	}
	public Object getPart2() {
		return part2;
	}
	public void setPart2(Object part2) {
		this.part2 = part2;
	}
}
```
```java
public class Director {
       private  Builder builder;
       public Director(Builder builder){
    	   this.builder = builder;
       }
       public Product construct(){
    	   String [] parts = {"part1","part2"};
    	   for(String part:parts){
    		  if("part1".equals(part)){
    			  builder.buildPart1();
    		  }else{
    			  builder.buildPart2();
    		  }
    	   }
    	   return builder.getResult();
       }
}
```
```java
public class Client {
	
    public static void main(String [] args){
        ConcreteBuilder concreteBuilder = new ConcreteBuilder();
        Director director = new Director(concreteBuilder);
        Product product = director.construct();
        System.out.println(product.getPart1() + "," + product.getPart2());
    }
}
```
