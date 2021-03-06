### 几种垃圾收集算法
#### 1.标记清除算法(Mark-Sweep)
分两阶段：
##### 标记：
  标记所有要回收的对象

##### 清除：
  将被标记的对象清除
  
> 
##### 缺点1:  
标记和清除算法效率都不高   
##### 缺点2:  
标记清除之后会产生大量不连续的内存碎片

#### 2.复制算法
把内存容量划分为大小相等的两块，每次只使用其中一块。当这一块使用完了，就将还存活的对象复制到另一块上面，然后在把已使用过的内存空间一次清除掉
> ##### 优点
实现简单，高效
##### 缺点
有效内存被缩小

#### 3.标记-整理算法(Mark-Compact)
过程：
##### 标记：
和“标记清除”的算法一样，但不做清除
##### 整理：
让所有存活对象都向一端移动，然后直接清理掉端边界以外的内存。

#### 3.分代收集算法
根据对象生存周期将内存划分为几块