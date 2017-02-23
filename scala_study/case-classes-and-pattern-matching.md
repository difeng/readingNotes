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
