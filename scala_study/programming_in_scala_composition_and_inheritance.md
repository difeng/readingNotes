##10 组合和继承(composition and inheritance)
主要内容：抽象类，无参数的方法，继承类，重写方法和域，参数域，调用超类的构造方法，多态和动态绑定，final的成员和类，工厂对象和方法。


###抽象类
scala中抽象类中的抽象方法不需要加abstract修饰，只要方法不实现就行。
```scala
abstract class Element { 
  def contents: Array[String]
}
```
###多态和动态绑定
 
###定义final的成员
使用final修饰的成员不可被子类重写
###使用组合和继承
###实现sbove，beside，和toString
###定义一个工厂对象
##scala的类体系架构

![](http://7xawio.com1.z0.glb.clouddn.com/class-hierarchy-of-scala.png)

最顶层的是类Any,Any定义了如下方法
```scala
final def ==(that: Any): Boolean
final def !=(that: Any): Boolean
def equals(that: Any): Boolean
def ##: Int
def hashCode: Int
def toString: String
```

Any类有两个子类AnyVal和AnyRef，AnyVal是scala中每一个内建值类型的父类型，scala中有九种值类型：Byte,Short,Char,Int,Long,Float,Double,Boolean,Unit
前八个是java的基本数据类型，而且它们的值以java的基本类型重现于java的运行时。Unit对应java的void类型。

Bottom types
在继承层次的最底层可以看到两个类型scala.Null和scala.Nothing。类Null是所有引用类的子类。Null不与值类型兼容。例如不能赋值给一个Integer变量。

类型Nothing在scala类层次的非常最底层，是每一个其它类型的子类型。没有该类型的任何值。





