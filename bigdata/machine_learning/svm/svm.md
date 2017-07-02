##核函数

常用核函数(kernel functions)

h度多项式核函数(polynomial of degree h): 
$$ K(X_i,X_j)=(X_i \cdot X_j + 1)^h$$

高斯径向基核函数(Gaussian radial basis function kernel):
$$ K(X_i,X_j)=e^{-{||x_i-X_j||}^2/2\sigma^2}$$

##皮尔逊相关系数(Person Correlation Coefficient)
衡量两个线性相关度的量

取值范围[-1,1]

正向相关:>0,负向相关：<0,无相关性:=0

计算公式:

$$ \rho=Cor(X,Y)=\frac{Cov(X,Y)}{\sqrt{Var(X)Var(Y)}} $$

$$ \sideset{}{_{xy}}r= \frac {\sum(x-\overline{x})(y-\overline{y})} {\sqrt{\sum{(x-\overline{x})^2} \sum{(y-\overline{y})^2} } }$$


