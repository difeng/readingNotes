##6.函数对象
* 添加属性
* 检查前置条件
* 私有属性和方法
* 定义操作符
* 标识符
* 方法重载
* 隐式转换

不可变对象的权衡

### 不可变对象优点：

> 
####1.没有复杂的状态和随时间变化的空间   
####2.传递方便自由，只需要将对象的副本传递给其他代码  
####3.可多线程并发访问
####4.使用安全的hash表键，如果一个可变对象再放入HashSet后发生变化，你将找不到该对象。

###缺点：
>  
####大对象复制的性能问题

## 7.内置的控制结构
scala基本的控制结构尽可能小，足以提供命令式语言的所有要点。通过允许你持有结果值来缩短代码。

###7.1.if语句

命令式的写法
```scala
var filename = "default.txt"
if (!args.isEmpty)
  filename = args(0)
```
函数式写法：
```scala
val filename = 
  if (!args.isEmpty)  args(0)
  else  "default.txt"
```
使用val的好处：

1.代码易读 

2.更好的支持等式推理。在表达式没有副作用的情况下，引入变量等于计算它的表达式。从而任何情况下，当你写变量名时，可以换一种表达方式。而不是println(filename),例如，你可以这样写:
```scala
println(if (!args.isEmpty) args(0) else "default.txt")
```
###7.2 while循环
scala中while和do while被称作循环而不是表达式，因为它们不反回任何感兴趣的值
while条件判断里不能写赋值语句因为赋值语句表达式的值是unit。
由于while循环没有返回值，因此经常被排除在纯函数式语言之外。
###7.3 for表达式
for的表达方式多样

迭代遍历集合
```scala
val filesHere = (new java.io.File(".")).listFiles
for (file <- filesHere)
println(file)
```
```scala
for (i <- 1 to 4)
  println("Iteration "+ i)


Iteration 1
Iteration 2
Iteration 3
Iteration 4
```
```scala
for (i <- 1 until 4)
  println("Iteration "+ i)
  
Iteration 1
Iteration 2
Iteration 3
```
####过滤(Filtering)
```scala
for (file <- filesHere)
  if (file.getName.endsWith(".scala"))
    println(file)
```
多个过滤器
```scala
for (
  file <- filesHere
  if file.isFile
  if file.getName.endsWith(".scala")
) println(file)
```
####内部迭代
```scala
def grep(pattern: String) =
  for (
    file <- filesHere
    if file.getName.endsWith(".scala");
    line <- fileLines(file)
    if line.trim.matches(pattern)
) println(file +": "+ line.trim)

grep(".*gcd.*")

```
####中间变量绑定
```scala
def grep(pattern: String) =
  for {
    file <- filesHere
    if file.getName.endsWith(".scala")
    line <- fileLines(file)
    trimmed = line.trim
    if trimmed.matches(pattern)
} println(file +": "+ trimmed)

grep(".*gcd.*")
```
####生成一个新集合
```scala
def scalaFiles =
  for {
    file <- filesHere
    if file.getName.endsWith(".scala")
  } yield file
```
###7.4 try表达式处理异常
#### 抛出异常(Throwing exceptions)
```scala
throw new IllegalArgumentException
```
####捕获异常(Catching exceptions)
```scala
try {
val f = new FileReader("input.txt")
// Use and close file
} catch {
case ex: FileNotFoundException => // Handle missing file
case ex: IOException => // Handle other I/O error
}
```
####finally子句
```scala
val file = new FileReader("input.txt")
try {
  // Use the file
} finally {
  file.close() // Be sure to close the file
}
```
####Yielding a value
```scala
def urlFor(path: String) =
  try {
    new URL(path)
  } catch {
    case e: MalformedURLException =>
    new URL("http://www.scala-lang.org")
  }
```
###7.5  匹配表达式
```scala
val firstArg = if (!args.isEmpty) args(0) else ""
val friend =
  firstArg match {
    case "salt" => "pepper"
    case "chips" => "salsa"
    case "eggs" => "bacon"
   case _ => "huh?"
  }
  
println(friend)
```
###7.6 不使用break和continue
使用其他方式替代break和continue
###7.7 变量作用域
###7.8 重构命令式代码风格
###7.9 结论

##8 函数和闭包
####Local function
函数式编程风格

将程序拆解为多个小的方然后做好每一个定义好的任务。私有方法经常相当小。这样的优点是编程者可以利用小的代码块组合出复杂的功能。每一个构建快应当足够简洁，可以单独理解。

local functions 示例

```scala
def processFile(filename: String, width: Int) {
  def processLine(line: String) {
    if (line.length > width)
      println(filename + ": " + line)
  }
  
  val source = Source.fromFile(filename) 
  for (line <- source.getLines())
    processLine(filename, width, line)
}
```
函数processLine在函数processFile内，可以访问processFile的filename和width

####first-class functions
可以将函数作为一个未命名的字面量，做为值来传递它。

函数字面量被编译成一个类，当在运行时初始化时是函数值
函数值是对象

函数字面量(function literals)和值(values)的区别是  function literals存在于代码中，而values存在于运行时

function values

>Every function value is an instance of some class that extends one of several FunctionN
traits in package scala, such as Function0 for functions with no parameters, Function1 for
functions with one parameter, and so on. Each FunctionN trait has an apply method used to
invoke the function.

#### function literals的简写

```scala
someNumbers.filter((x: Int) => x > 0)
```
简写后
```scala
someNumbers.filter((x) => x > 0)
```

####Placeholder syntax
可以使用下划线使代码更简
例如，筛选someNumbers中大于0的数：
```scala
someNumbers.filter(_ > 0)
```
####函数部分应用(Partially applied functions)
####Closure(闭包) 



