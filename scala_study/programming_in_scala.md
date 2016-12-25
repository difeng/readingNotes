##1.语言简介
scala是构建在java虚拟机上的编程语言。
* 易扩展
* 静态类型语言
* 混合函数式编程和面向对象

其他语言中对象和函数式有不同额概念，scala中函数值是一个对象。函数类型是可以被子类继承的类。这使得它有很深的扩展性。

scala里的trait和java里的interface类似，不过trait可以有实现方法。

objects是一个混合，它接受一个类的成员和添加一系列traits成员。

trait可以为未指定的超类添加功能。这使得trait比类有更好的可插拔性。而且避免了多继承中的“diamond inheritance”的问题。

函数式编程有两个主要的观点:

* 1.函数式第一类值
  函数可以作为参数传递，作为返回值返回，也可以存储在变量里，也可以不用定义函数名称，就像写一个整数42一样。
  
* 2.程序操作应该将输入值映射为输出值而不是在数据原有位置改变数据。
   从这一点看java语言里的string就是函数式的，而ruby里的string则不是。
   也就是说函数不能有任何副作用，例子：java里的raplace函数。
   
###1.3为什么scala？
compatibility, brevity, high-level abstractions, and advanced static typing.(兼容性，简洁性，高级抽象和高级静态类型。)
* 兼容性: 
  scala -> jvm字节码
  scala和java的互操作性
  scala重用了java的一些类型，并且重新装扮它们，使它们更简洁。
* 简洁性：
* 高层次抽象
* 静态类型
   
##2.1 scala基础
1.scala解释器使用
命令行输入scala即可进入命令行模式
按:quit退出

2.变量定义
变量类型：  
* val:一次赋值，一旦初始化，不能再次赋值     
* var：在变量生命周期内都可再赋值

3.函数定义：
```scala
def max(x: Int,y: Int): Int = {
    if (x > y) x
    else y
}
```
4.scala脚本

将scala语句写入一个脚本命名为name.scala。name自己定，然后使用scala name。scala来运行脚本。

5.使用while循环；使用if判断
```scala
var i = 0
while (i < args.length) {
  println(args(i))
  i += 1
}
```

6.使用佛foreach和for迭代
foreach:
```scala
args.foreach((arg: String) => println(arg))
```
更简洁的方式:
```scala
args.foreach(println)
```
for:
```scala
for (arg <- args)
  println(arg)
```
7.使用类型参数化数组
```scala
val greetStrings = new Array[String](3)
greetStrings(0) = "Hello"
greetStrings(1) = ", "
greetStrings(2) = "world!\n"
for (i <- 0 to 2)
  print(greetStrings(i))
```
8.使用list
```scala
val oneTwo = List(1, 2)
val threeFour = List(3, 4)
val oneTwoThreeFour = oneTwo ::: threeFour
println(oneTwo +" and "+ threeFour +" were not mutated.")
println("Thus, "+ oneTwoThreeFour +" is a new list.")
```
“:::”是list的一个连接方法。
结果：
```scala
List(1, 2) and List(3, 4) were not mutated.
Thus, List(1, 2, 3, 4) is a new list.
```
```scala
val twoThree = List(2, 3)
val oneTwoThree = 1 :: twoThree
println(oneTwoThree)
```
```scala
结果：
List(1, 2, 3)
```
“::“前置一个元素到已存在的列表，返回结果列表。
表达式“1 :: twoThree”, :: 是其有操作数的方法
如果一个方法在操作符符号使用，如a * b,则方法被左边的操作数调用，就像a.*(b)。如果一个方法以一个冒号结束，方法将被右边操作数调用。
1 :: twoThree twoThre调用方法::就像twoThree.::(1)


## 3.类和对象
### 3.1 类，字段和方法
```scala
class ChecksumAccumulator {
  var sum = 0
}
```
实例化两个实例：
```scala
val acc = new ChecksumAccumulator
val csa = new ChecksumAccumulator
```
内存状态：
```scala
acc,csa ---> sum ---> 0
```
给acc.sum赋值
```scala
acc.sum = 3
```
内存状态:
```scala
acc ---> sum ---> 3
csa ---> sum ---> 0
```

scala的单例对象:
```scala
object ChecksumAccumulator {
  var sum = 0
}
```
scala的到哪里对象和类有相同的名字，被称为类的伴体对象，类被称作是单例对象的伴体类。类必须在同一个源码文件中定义类和它的伴体对象。一个类和它的伴体对象可以访问彼此的private成员。

类与单类对象不同点：
类可以带参初始化，单例对象不可以

scala应用
单例对象里定义一个带Array[String]参数的方法，即可运行此程序
```scala
object Summer {
def main(args:Array[String]) {
  for (arg <- args)
    println(arg +": "+ calculate(arg))
  }
}
```
编译方法
```scala
scalac
fsc(快)
```
编译完会生成class文件

运行方法:
```scala
例如Summer应用
scala Summer of the love
```
应用程序trait
scala提供了一个特质scala.Application,可以使用如下方法运行一个应用程序
```scala
import ChecksumAccumulator.calculate
object FallWinterSpringSummer extends Application {
  for (season <- List("fall", "winter", "spring"))
    println(season +": "+ calculate(season))
}
```
## 4. 基本类型和操作
基本数据类型:

|Value type| Range|
| :----| :---- |
|Byte |8-bit signed two’s complement integer (-27 to 27 - 1, inclusive)|
|Short |16-bit signed two’s complement integer (-215 to 215 - 1, inclusive)|
|Int |32-bit signed two’s complement integer (-231 to 231 - 1, inclusive)|
|Long |64-bit signed two’s complement integer (-263 to 263 - 1, inclusive)|
|Char |16-bit unsigned Unicode character (0 to 216 - 1, inclusive)|
|String |a sequence of Chars|
|Float |32-bit IEEE 754 single-precision float|
|Double |64-bit IEEE 754 double-precision float|
|Boolean |true or false|

特殊字符使用转义序列：

|Literal |Meaning|
| :----| :---- |
|\n |line feed (\u000A)|
|\b |backspace (\u0008)|
|\t |tab (\u0009)|
|\f |form feed (\u000C)|
|\r |carriage return (\u000D)|
|\" |double quote (\u0022)|
|\' |single quote (\u0027)|
|\\ |backslash (\u005C)|

###操作符
####1.scala操作符没有特定的语法定义，任何方法都可以是操作符

####2.算术运算符
|operation |描述|
| :----| :---- |
|+| 加|
|-| 减|
|*| 乘|
|/| 除|
|%| 除余|

####3.关系和逻辑运算符
关系运算符

|operation |描述|
| :----| :---- |
|>| 大于|
|<| 小于|
|>=| 大于等于|
|<=| 小于等于|
|!| 非|

逻辑运算符

|operation |描述|
| :----| :---- |
|&&| 与|
|\|\|| 或|
|&| 短路与|
|\||断路或|

####4.位运算



































































