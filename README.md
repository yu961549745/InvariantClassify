# InvariantClassify
采用不变量方法对偏微分方程生成元的李代数空间进行分类。
整个过程分为分支和合并两大步骤。
+   分支过程：即从生成不变量的偏微分方程出发，逐个建立不变量方程进行求解，对于每个不变量方程的解，
    一个不变量方程的解对应一个InvSol对象，取一个形式简单的解作为代表元，并通过求解变换方程来验证是否能够成为代表元。
+   合并过程：对于求解成功的InvSol对象，按照代表元进行分类，生成RepSol对象，一个代表元对应一个RepSol对象。
    每个RepSol对象对应多个成立条件，成立条件由不变量方程以及解的附加条件构成。然后通过人工的验证补充和删除，
    确定最终的代表元。

## 综述
本算法主要包含以下工作：
+ 计算基本信息：交换子表、伴随变换矩阵、广义伴随变换矩阵，以及生成不变量的的线性偏微分方程组。
+ 采用分支的方法，建立不变量方程，计算代表元解对象InvSol，伴随着求解新的代表元。
+ 采用合并化简的思路，生成RepSol对象。
+ 考虑到解方程的不完备性，预留人工操作接口用于人工干预和处理。

## 基本计算：Basic.mpl
交换子表计算：
1. 计算交换子的表达式形式。
1. 将交换子用生成元进行线性表出。
1. 计算伴随变换矩阵。
1. 生成偏微分方程组，并求解不变量。

## 不变量化简：InvSimplify.mpl
不变量化简的算法如下：
1.	对于每个不变量，
    + 尝试使用其它不变量来进行表示，为了防止循环替代，以及出于化简的目的，只允许表示之后项数变少的替换。
    + 先尝试按照乘法规则进行化简，因式分解之后，删去能够成为不变量的因子。
    + 再尝试按照加法规则进行化简，展开之后，删去能够成为不变量的项。
1.	将无法化简的不变量整体替换回其表达式形式。
1.	消除不变量的系数。
1.	调整不变量的阶数为正整数。
1.	对于能够调整次数的不变量，调整其次数，例如把a[1]^3变成a[1]，把a[1]^4变成a[1]^2。
重复执行上述算法，直到不能再化简为止。

## 取特解：Fetch.mpl
变量可以划分为：
+ 自由变量：在满足非零的前提下可以全部取0。
+ 确定性变量：取值已经确定，或者由其它变量确定。
+ 有约束变量：其约束来自于解的定义域，由解的性质可知，其值不由其它变量所确定。

处理时主要处理约束条件，自由变量可以加单取0，确定性变量的值已知。在完全处理约束的前提下，无需验证是否满足约束。

至于如何处理约束：
+ 和c有关的约束：为了能够始终满足约束，特解应当和c有关，可以采取变成等式约束进行求解的方式进行处理。(注意对于单独的c的约束，直接删除)
+ 和c无关的约束：可以简单求解不等式，求解后的结果，都是单边的不等式约束，可以看情况取解。

对于求解后的结果，可以细分为：
+ 单变量约束，可以按照简单的方法取定特解。
+ 多变量约束，可以在取定其它变量的值之后，转化单变量约束进行处理。


## 参考文献
+ Hu X, Li Y, Chen Y. A direct algorithm of one-dimensional optimal system for the group invariant solutions[J]. Journal of Mathematical Physics, 2015, 56(1.: 053504 .

