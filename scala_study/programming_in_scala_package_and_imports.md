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