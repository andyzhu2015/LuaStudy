--out put type
--[[
print(type("Hello Lua"))
print(type(5*3))
print(type(print))
print(type(type))
print(type(true))
print(type(nil))
print(type(type(x)))
--]]

--any type
--[[
print(type(a))
a=10
print(type(a))
a="Hello Lua"
print(type(a))
a=print			--����
a(type(a))
--]]

-- string
--[[
a="one string"
b=string.gsub(a,"one","another")
print(a)
print(b)
--]]

--[[
page=\[\[
<HTML>
<Body>
Lua is \n Best
</Body>
</HTML>
\]\]
io.write(page)
--]]

---[[
--����һ�����ֵļ��
line=io.read()
n=tonumber(line)
if n==nil then
	error(line.." is not a valid numnber")
else
	print(n)
end
--]]


