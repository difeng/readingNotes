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
两次操作的
```scala
def twice(op: Double => Double,x: Double) = op(op(x))
```






