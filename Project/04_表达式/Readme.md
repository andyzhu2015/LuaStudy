# 表达式

### 1. 算数操作符

* 包括:+	-	*	/	^	%	-(取负)
* 幂运算:
  * 倒数:x^-1
  * 平方:x^2
  * 平方根:x^0.5
  * 立方根:x^(1/3)
* 取模运算:
  * X%1:获取小数部分
  * x-x%1:获取整数部分
  *  x-x%0.1:精确到小数点后一位

### 2. 关系操作符

* 包括:<	>	<=	>=	==	～=
* 返回结果true,false
* 比较需要类型相同,不同类型比较返回false:比如number与string比较
* nil只能和自己相等
* Lua比较数字按数字大小进行比较,比较字符串按字母的顺序进行

### 3. 逻辑操作符

* 包括:and	or	not
* 逻辑操作符认为false与nil为假,其他为真,包括0与空字符串
* and与or返回结果非true,false,而是与它相关的两个操作数
* and与or均实用为短路求值,只在需要的时候评估第二个参数
``` lua
a and b 	--如果a为false,返回a,否则返回b
a or b 		--如果a为true,返回a,否则返回b
```
* 实用技巧:如果x为false或者nil,则给x赋默认值v
``` lua
x=x or v

--等价于

if	not x then
	x=v
end
``` lua
* and优先级高于or
* C语言三元运算符在Lua中实现
``` lua
a?b:c	--C语言三元运算符

(a and b) or c	--三元运算符在Lua中的实现
```
* not的结果返回true或者false
``` lua
print(not nil)		--> true
print(not false)	--> true
print(not 0)		--> false
```

### 4. 连接运算符
