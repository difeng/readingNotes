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
4. scala脚本
将scala语句写入一个脚本命名为name.scala。name自己定，然后使用scala name。scala来运行脚本。

5.使用while循环；使用if判断
```scala
var i = 0
while (i < args.length) {
  println(args(i))
  i += 1
}
```

6. 使用佛foreach和for迭代
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
:::是list的一个连接方法。
结果：
```scala
List(1, 2) and List(3, 4) were not mutated.
Thus, List(1, 2, 3, 4) is a new list.
```

```scala  
val twoThree = List(2, 3)
val oneTwoThree = 1 :: twoThree
println(oneTwoThree)

结果：
List(1, 2, 3)
```

::前置一个元素到已存在的列表，返回结果列表

















