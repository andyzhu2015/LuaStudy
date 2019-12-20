--计算一个数的阶层
function fact(n)
	if n==0 then
		return 1
	else
		return n*fact(n-1)	--递归调用
	end
end

print("enter a number")
a=io.read("*number")
print(fact(a))

--[[多行
注释]]

--[[
多行注释
--]]

---[[
print("取消多行注释")
--]]

---[[
print("取消多行注释")
]]
