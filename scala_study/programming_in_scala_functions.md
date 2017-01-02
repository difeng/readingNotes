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
###7.6不使用break和continue
使用其他方式替代break和continue
###7.7 变量作用域