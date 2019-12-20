# 值与类型
[TOC]
------

## 1. Lua中类型和值

1. Lua为动态类型语言,变量不需要类型定义.

2. Lua中类型及值如下:
    * nil(空)
    * boolean(布尔)
    * number(数值)
    * string(字符串)
    * table(表)
    * function(函数)
    * userdata(自定义类型)
    * thread(线程)
3. type():获取变量类型

``` lua
print(type("Hello Lua"))	-->string
print(type(5*3))			-->number
print(type(print))			-->function
print(type(type))			-->function
print(type(true))			-->boolean
print(type(nil))			-->nil
print(type(type(x)))		-->string
```

4. 变量没有预定义类型,每个变量都可能包含任意一种类型的值
``` lua
print(type(a))		-->nil
a=10
print(type(a))		-->number
a="Hello Lua"
print(type(a))		-->string
a=print			
a(type(a))			-->function
```
* 如上,function函数可以作为其他值一样使用
* 一般情况下同意变量代表不懂类型的值会造成混乱,不推荐像上面一样使用

### 1. nil
* Lua中特殊类型,只有一个值:nil
* 一个全局变量未被赋值前默认值为nil
* 给全局变量赋nil可以删除该变量

### 2. boolean
* 包含false与true两个取值
* Lua中任何值都可以作为条件
* 除了false与nil为假,其他均为真,0与空字符也为真

### 3. number
* 表示实数,Lua中没有整数
* Lua可以用nunber处理任何长整数不用担心误差
* 数字常量的小数部分和整数部分是可选的

``` lua
4		0.4		4.57e-3		0.3e12		5e+20	
```

### 4. string
1. 指字符的序列
2. Lua是8位字节,字符串可以包含任何数值类型,意味着可以存储任意二进制数据在一个字符串中
3. Lua字符串不可修改,只能用新变量存储需要的字符串
```
a="one string"
b=string.gsub(a,"one","another")	--不能修改字符串,用新变量存需要的字符串
print(a)	-->one string
print(b)	-->another string
```
4. string与其他对象一样,Lua自动进行内存分配与释放;
5. 一个string可以只包含一个字符,也可以包含很长的文本,Lua可以高效处理长字符串
6. 字符串可以用单引号或者双引号表示(必须成对,不能混用)
	1. 为了风格统一,最好使用一种
	2. 字符串内可以嵌套使用另一种引号(如果是单引号,可以包含双引号,如果是双引号可以包含单引号)
``` lua
a="it's a book"
print(a)		-->it's a book
b='it"s a book'	
print(b)		-->it"s a book
```
7. 转义符
|符号|含义|
|---|---|
|\a|响铃|
|\b|后退|
|\f|换页|
|\n|换行|
|\r|回车|
|\t|水平制表|
|\v|垂直制表|
|\\|反斜杠|
|\"|双引号|
|\'|单引号|
|\[|左中括号|
|\]|右中括号|
8. 可用\<ddd>表示字母(ddd为三位十进制数字)
``` lua
print("\97")		-->a
print("\049")		-->1
print("\10")		-->换行
```
9. 可以使用[[..]]表示多行字符串
	1. 	可以包含多行
	2. 	不会解释转义序列
	3. 	第一个字符为换行会被自动忽略掉
	4. 	通常用来用来包含一段代码

``` lua
page=[[
<HTML>
<Body>
Lua is \n Best
</Body>
</HTML>
]]

io.write(page)	-->原样输出[[]]中括号内包含的内容
```

10. Lua会在string与number之间自动进行类型转换
	1. 当一个字符串进行算术操作时,会被转换为数字
	2. 当期望一个string而实际为数字时,会将数字转换为string
	3. 如果类型转换失败,会报错
``` lua
print("10"+1)		-->11
print("Hello"+1)	-->Error(强转失败)
print("Hello"..1991)-->Hello1991
```

11. 字符串连接符`..`
	* 用于连接两个字符串
	* 一个数字后面用连接符时,必须加上空格防止被解释错
``` lua
print("Hello".." Lua")	-->Hello Lua
print(10..20)	-->Error:malformed number near '10..20'
print(10 .. 20)	-->1020
```

12. string与number显示转换
	1. string显示转换number:tonumber()函数
	2. number显示转换string:tostring()函数
```
--输入一个数字的检测
line=io.read()
n=tonumber(line)
if n==nil then
	error(line.." is not a valid numnber")
else
	print(n)
end
```

### 5. table
* table类型实现了关联数组
* 关联数组是具有特殊索引方式的数组,可以通过整数索引,也可以通过字符串或者其他的值来索引
* 没有固定大小,可以动态添加任意元素到table中
* table是Lua中主要且仅有的数据结构,可以一种简单统一且高效的方式实现普通数组,符号表,集合,记录,队列和其他数据结构
* Lua中通过Table表示模块,包和对象

1. table既不是值,也不是变量,而是对象(动态分配的对象),程序仅有对其的引用
```
a={}	--创建一个Table,{}为构造表达式
k="x"
a[k]=10		--key="x",value=10
a[20]="great"	--key=20,value="great"
```

2. table是匿名的,一个table变量与table自身之间没有固定的关系
	* 当table没有被引用时,table会被Lua垃圾收集器回收,删除此table,内存被回收
```
a={}
a["x"]=10
b=a
print(b["x"])		-->10,a,b均引用table
a=nil
print(b["x"])		-->10,a为nil,b引用table
b=nil
print(b["x"])		-->Error,a,b均为nil,table没被引用,被垃圾收集器回收
```

3. table元素访问
	* 通过下标访问
	* 语法糖`Table.Key`方式访问
```
a={}	--创建一个table
a["X"=10]
print(a["x"])		-->10
print(a.x)			-->10
```

4. table长度操作符`#`:获取table长度
	* #table:获取table长度
	* table[#table]:获取table最末尾一个元素值
```
a={}
for i=1,1000 do
	a[i]=i*2
end

print(#a)		-->1000
```

### 6. 数组
* 数组是相同数据类型的元素按一定顺序排列的集合,可以是一维数组和多维数组
* Lua数组的索引键值可以使用整数表示,且默认索引从1开始,数组的大小不固定
* Lua通过Table实现数组

1. 一维数组
	* 数组构造时,如果没有指定下标,下标从1开始递增 
	* 一维数组是最简单的数组,其逻辑结构为线性表.可以使用for循环遍历数组元素
```
array={"lua","array"}

for i=1,2 do
	print(array[i])
end
```
	* 如果有指定下标,按指定下标分配
```
array={}
for i=-2,2 do
	array[i]=i*2
end
```
	* 没事指定下标元素,返回nil,同理要删除某个元素,将其赋值nil

2. 多维数组
多维数组即数组中包含数组或一维数组的索引键对应一个数组
``` lua
array={}
--数组元素为数组
for	i=1,3 do
	array[i]={} 
		for	j=1,3 do
			array[i][j]=i*j
		end
end
--索引键对应一个数组
maxRows=3
maxColumns=3
for	row=1,maxRows do
	for col=1,maxColums do
		array[row*maxColums+col]=row*col
	end
end
```

### 7. function
* 函数是第一类值,和其他变量相同
* 函数可以存储在变量中,可以作为参数传递给其他函数,还可以作为返回值
* 程序可以重新定义函数,
* 可以调用Lua的标准函数,也可以调用其他C预言编写的函数
* Lua标准函数都是C编写的,包括table的操作,输入输出,操作系统,调试库

### 8. userdata与thread
* userdata可以将C数据春芳在lua变量中
* userdata在Lua中除了赋值和相等比较外,没有预定义的操作
* userdata用来描述应用程序或者使用C实现的库创建的新类型




