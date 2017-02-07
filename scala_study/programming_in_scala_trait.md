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

trait也定义了一个类型。

薄接口和父接口，trait的主要作用是自动地添加方法到一个类中。trait可以使薄接口变成富接口。

Ordered trait
比较两个同类型的有序对象时，可以让该类型extends ordered trait并实现compare方法。

```scala
abstract class IntQueue {
  def get(): Int
  def put(x: Int)
}

import scala.collection.mutable.ArrayBuffer
class BasicIntQueue extends IntQueue {
   private val buf = new ArrayBuffer[Int]
   def get(): Int = buf.remove(0)
   def put(x: Int) { buf += x }
}

trait Doubling extends IntQueue {
  abstract override def put(x: Int) { super.put(2 * x) }
}

class MyQueue extends BasicIntQueue with Doubling

trait Incrementing extends IntQueue {
  abstract override def put(x: Int) { super.put(x + 1) }
}

trait Filtering extends IntQueue {
  abstract override def put(x: Int) {
    if (x >= 0) super.put(x)
  }
}
```
调用顺序是从右向左
```scala
scala> val queue = (new BasicIntQueue
with Filtering with Incrementing)
queue: BasicIntQueue with Filtering with Incrementing...
scala> queue.put(-1); queue.put(0); queue.put(1)
scala> queue.get()
res17: Int = 0
scala> queue.get()
res18: Int = 1
scala> queue.get()
res19: Int = 2
```
什么时候使用trait

当行为可以在多个毫不相关的类中重用的使用可以使用trait，因为只有trait可以被混合进类的不同部分中去。


当trait中添加或者删除成员时，所有继承于此triat的类不管有没有发生变化都得重新编译。而抽象类没有此问题。如果外部客户端只是调用其行为则使用trait是比较合适的。










