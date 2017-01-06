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
####柯里化currying)