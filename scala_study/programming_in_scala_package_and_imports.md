#package and imports

scala中两种包定义方式

方式一：
```scala
package bobsrockets.navigation
class Navigator
```
方式二:
```scala
package bobsrockets.navigation {
  class Navigator
}
```
多个包定义在一个文件中
```scala
package bobsrockets {
  package navigation {
    // In package bobsrockets.navigation
    class Navigator
    package tests {
      // In package bobsrockets.navigation.tests
      class NavigatorSuite
    }
 }
}
```
import语句可以出现在任何地方出现

访问修饰：
private
```scala
class Outer {
  class Inner {
    private def f() { println("f") }
    class InnerMost {
      f() // OK
    }
  } 
  (new Inner).f() // error: f is not accessible
}
```

Protected

scala 中访问Protected成员比java中更为严格，scala中一个protected成员只能被其子类访问。
```scala
package p {
  class Super {
    protected def f() { println("f") }
  }
  class Sub extends Super {
    f()
  }
  class Other {
    (new Super).f() // error: f is not accessible
  }
}
```
