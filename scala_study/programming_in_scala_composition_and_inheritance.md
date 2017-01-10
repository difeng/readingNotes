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
###实现sbave，bedide，和toString
###定义一个工厂对象
##12.特质（Trait）
trait可以使用extends或者with
