##svm算法特点
1.训练好的模型的算大负载度是有支持向量的个数决定的，而不是由数据的维度决定的。所以SVM不太容易产生overfitting

2.SVM训练出来的模型完全依赖于支持向量(Support Vectors),即使去掉训练集里面的非支持向量，重复训练，依然会得到完全一样的模型

3.一个SVM如果训练得出的支持向量个数比较小，SVM训练出来的模型比较容易泛化

线性不可分的情况的处理：

1.利用非线性映射把原始数据集中的向量点转化到更高维空间中

2.在高维空间中操一个线性的超平面

##核函数

常用核函数(kernel functions)

h度多项式核函数(polynomial of degree h): 
$$ K(X_i,X_j)=(X_i \cdot X_j + 1)^h$$

高斯径向基核函数(Gaussian radial basis function kernel):
$$ K(X_i,X_j)=e^{-{||x_i-X_j||}^2/2\sigma^2}$$

S型核函数(Sigmoid function kernel):
$$ K(X_i,X_j)=tanh(\kappa X_i \cdot X_j - \sigma)$$

如何选择使用哪一个kernel?
通常，比如图像分类，使用RBF，文字不使用RBF
尝试不同的kernel，根据结果准确度而定

##皮尔逊相关系数(Person Correlation Coefficient)
衡量两个线性相关度的量

取值范围[-1,1]

正向相关:>0,负向相关：<0,无相关性:=0

计算公式:

$$ \rho=Cor(X,Y)=\frac{Cov(X,Y)}{\sqrt{Var(X)Var(Y)}} $$

$$ \sideset{}{_{xy}}r= \frac {\sum(x-\overline{x})(y-\overline{y})} {\sqrt{\sum{(x-\overline{x})^2} \sum{(y-\overline{y})^2} } }$$

##SVM扩展可解决多个类别分类问题
对于每个类，有一个当前类和其他类的二类分类器（one-vs-rest)



