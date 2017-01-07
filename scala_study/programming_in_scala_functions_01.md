##9.控制抽象(Control Abstraction)
###9.1减少重复代码
####高阶函数可以将函数作为参数传递
例如
```scala
def containsOdd(nums: List[Int]): Boolean = {
  var exists = false
  for (num <- nums)
    if (num % 2 == 1)
      exists = true
  exists
}
```
可写为:
```scala
def containsOdd(nums: List[Int]) = nums.exists(_ % 2 == 1)
```
####9.2柯里化currying)
未柯里化前
```scala
def plainOldSum(x: Int,y: Int) =  x + y
```
柯里化后
```scala
def plainOldSum(x: Int)(y: Int) = x + y
```
柯里化的过程：
```scala
plainOldSum(1)(2)实际过程
相当于：
val second = plainOldSum(1)_
second(2)
```
使用first函数来说明
```scala
scala> def first(x: Int) = (y: Int) => x + y
first: (x: Int)(Int) => Int

scala> val second = first(1)
second: (Int) => Int = <function1>

scala> second(2)
res6: Int = 3
```
####9.3 写新的控制结构
两次操作的控制结构
```scala
scala> def twice(op: Double => Double, x: Double) = op(op(x))
twice: (op: (Double) => Double,x: Double)Double
scala> twice(_ + 1, 5)
res9: Double = 7.0
```
loan pattern 模式的使用
 
一个常用的编码模式:打开资源,操作资源,释放资源
例子：
```scala
def withPrintWriter(file: File,op: PrintWriter => Unit) {
  val writer = new PrintWriter(file)
  try {
    op(writer)
  } finally {
    writer.close()
  }
}

调用方式
withPrintWriter(
  new File("date.txt"),
  writer => writer.println(new java.util.Date)
)
```

使代码更像内建的控制结构，scala中任何仅仅传递一个参数的函数调用都可用大括号代理括号的使用。

```scala
scala> println("Hello, Word!")

可写作:
scala> println { "Hello, Word!" }
```
柯里化后的withPrintWriter
```scala
def withPrintWriter(file: File)(op: PrintWriter => Unit) {
  val writer = new PrintWriter(file)
  try {
    op(writer)
  } finally {
    writer.close()
  }
}

调用
val file = new File("date.txt")
withPrintWriter(file) {
  writer => writer.println(new java.util.Date)
}
```
###By-name parameters
例如下面函数中的参数“writer =>” 
```scala
withPrintWriter(file) {
  writer => writer.println(new java.util.Date)
}
```

