#Trait

trait是scala中代码重用的最基础的单元。trait封装方法和域的定义。使用trait的最常用的两种方式。
扩大薄接口为富接口。定义可堆叠的修改。

###Trait如何工作

trait定义：
```scala
trait Philosophical {
  def philosophize() {
    println("I consume memory,therefore I am!")
  }
}
```
此trait的名字是Philosophical。它有默认的父类型AnyRef。它定义了一个具体的方法philosophize。

trait可以使用extends或者with关键字混合进一个类中。混合不同于多继承。
```scala
class Frog extends Philosophical {
  override def toString = "green"
}
```
使用trait的方法就像使用从父类继承的类的方法一样。