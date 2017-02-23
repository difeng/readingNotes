##模式的种类(Kinds of patterns)
###通配符模式
通配符模式(_)可以匹配任何对象。
通配符可以用来忽略你不关心的对象的部分。

###常量模式
常量只可以匹配自己本身。任何字面量可以用作常量。
如下:
```scala
def describe(x: Any) = x match {
  case 5 => "five"
  case true => "truth"
  case "hello" => "hi!"
  case Nil => "the empty list"
  case _ => "something else"
}
```

###变量模式
变量模式可以匹配任何对象，就像一个通配符一样。
```scala
expr match {
  case 0 => "zero"
  case somethingElse => "not zero: "+ somethingElse
}
```
###构造器模式
构造器模式是模式匹配变得更加强大。

###元组模式
```scala
def tupleDemo(expr: Any) =
  expr match {
  case (a, b, c) => println("matched "+ a + b + c)
  case _ =>
}
```

###类型匹配(Typed patterns)
```scala
def generalSize(x: Any) = x match {
  case s: String => s.length
  case m: Map[_, _] => m.size
  case _ => -1
}
```
###变量绑定(variable binding)

###模式保护(pattern guards)
