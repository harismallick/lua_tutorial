--[[
Lua tutorial.
Learning Lua to be able to create config files for nvim and wezterm.

Tutorial source: https://www.youtube.com/watch?v=1srFmjt1Ib0
Source 2:        https://www.youtube.com/watch?v=zi-svfdcUc8
]]

-- 1. Working with strings

print("Hello world!")
-- Two dashes are used to create a single line comment.
--[[
This is how you create
a multi line comment in Lua.
]]

-- String concatenation is Lua is done with two dots, not using the + operator.
print("Hello" .. " John" .." Doe")

-- 2. Data types in Lua and general syntax

--[[
    Data types in Lua:
    nil -> Null
    number -> integers or floats
    string -> character arrays
    boolean -> true false
    table -> arrays

    Lua is dynamically-typed, so don't need to declare datatype being stored
    in the variable.

    Lua style guide suggests naming local variables and local functions with lowercase first letter.
    Global variables and global functions need to be named with a capital first letter.
    VScode linter throws errors if this naming convention is not followed.
]]

-- lua is snake case like Python

local num_1 = 5
print(num_1)
local num_1 = "hello"
print(num_1)
local num_1 = true
print(num_1)
-- datatype stored in a variable can be changed.
-- By default, variables are global in Lua. 
-- You explicitly make a variable local by using the local key word.
-- Example below shows how the variable test can be accessed outside the function.

function Scope_test()
    Test = "John Doe"
    -- local test = "Local John"
    print(Test)
end
Scope_test()
print(Test) -- The output is nil if test is local in the function above.

-- Lua supports writing code with indentation or by separating each code block
-- in a single line using a semicolon.

local semicolon_test = "Hello semicolon"; print(semicolon_test)

-- Variable injection into strings:
-- You have to use the string concatenation syntax of .. to insert variables.

Name = "John Doe"
Age = 35

print(Name .. " is " .. Age .. " years old.")
Multiline_string = [[
This is a multi-line string.
It is similar to using triple quotes in Python.
]]

-- 3. Tables and built-in functions

-- The table datatype is used to instantiate arrays and hash tables in Lua.
-- The table is instantiated using curly braces.

---@type table
local food_table = {"apple", "banana", "juice", "chicken"}
-- Type hinting in Lua is done using the "---@type" wrapper.

print(food_table[1])
-- This will print apple because Lua is 1-indexed, not 0-indexed!

-- Get the length of an interable using the '#' operator.
local fname = "Jamie"
print(fname .. " has " .. #fname .. " characters.")
print("There are " .. #food_table .. " items in the list.")

-- Built-in functions for strings and tables can be studied in detail here:
-- https://www.lua.org/manual/5.4/

-- Like Python, multiple variables can be declared on a single line.

local full_name = "Jake Sullivan"
local Start, End = string.find(full_name, "Sulli")
print(full_name .. ' has pattern "Sulli" at ' .. Start .. " to " .. End)

-- 4. Math in Lua
--[[
    The basic operation can be done using:
    + - Add
    - - Subtract
    * - Multiply
    / - Divide
    ^ - Exponent
    % - Modulus
    For all other operations, like floor or ceiling divide, or sine cosine,
    need to use the math library built into Lua.
]]

print(4+4)
print(4-4)
print(4*4)
print(4/4)
print(4^4)
print(4%4)
print(math.ceil(4/3)) -- 2

-- 5. do-end blocks in Lua

-- This is a way to encapsulate certain lines of code into their own local scope
-- without having to declare a function.

do
    local fname = "Jonathan"
    print("Inside the do-end block, fname is: " .. fname)
end
print("Outside the do-end block, fname is: " .. fname)
-- The "Jonathan" was encapsulated in its scope. Outside the block, fname value
-- of "Jamie" from the previously defined scope was used.


-- 6. Functions and for loops in Lua

-- Functions are global scope by default.
-- Local function declarations need to be preceded by 'local'
-- Why create local functions? Functions not meant to be exported from modules should
-- be declared as local functions.
--[[
    for loop syntax in lua:
    for k, v in pairs(iterable) do BLOCK end
    or 
    for i, v in ipairs(iterable) do BLOCK end
    
    pairs() returns a generator for the iterable
    ipairs() returns an array of tuples of the iterable: (1, iterable[1]), (2, iterable[2]), ..., (n, iterable[n]) 
]]

local function print_name(name)
    print("Hi " .. name .. "!")
end
print_name("Jane Doe")

-- Passing in variable number of arguments to a function
-- This is similar to *args functionality in Python.
-- In Lua, variable number of arguments for a function is declared using '...'

function Greet_users(...)

    local args = {...}
    for k, name in pairs(args) do
        print("Hello " .. name .. "!")
    end
end

Greet_users("John", "Jane", "Bob", "Sally")


-- 7. Conditionals in Lua

-- Like functions, and loops, even conditions need to be succeeded with 'end'.
-- Otherwise Lua will throw a syntax error.

local function can_get_drivers_license(age)
    if age > 18 and age < 30 then
        print("You are eligible for a driver's license")
    elseif age > 30 then
        print("You're eligible for a license and comprehensive insurance.")
    else
        print("You're not eligible for a driver's license yet.")
    end
end
can_get_drivers_license(20)
can_get_drivers_license(31)
can_get_drivers_license(15)


-- 8. while loops and repeat-until loops

-- repeat-until is do-while from C. It will execute atleast one even if the condition isn't met.

local num = 0
while num < 10 do
    print(num)
    num = num + 1
end

repeat
    print(num)
    num = num + 1
until num > 9
print("Value of num after while and repeat loops:" .. num)
-- Even though num = 10 after the while loop, the repeat-until loop was executed until the termination condition was met.

-- 9. User input

-- IO is handled using the builtin IO library

-- io.write("Enter you name: ")
-- local input_name = io.read()
-- print("The name you've input is: " .. input_name)


-- 10. More table operations

local names_list = {
    "Aerith",
    "Tifa",
    "Red XIII",
    "Cloud"
}
table.sort(names_list)
-- This is an inplace operation.

-- print the order of sorted items:
for i, v in ipairs(names_list) do
    print(v)
end

-- 11. Importing functions from other modules

local helper = require("helper")

-- local nums = {1,2,3,4,5}
local sum = helper.Add_nums(1,2,3,4,5)
print("The sum of the array is: " .. sum)


-- 12. Working with files

local f_object = io.open("lua_test.txt", "a")
if f_object then 
    f_object:write("Hello world\n")
end
io.close(f_object)
f_object = nil

-- 13. OOP in Lua

-- Classes are not built into Lua.
-- But if you wanted to do OOP, you could use tables and functions.

function Employee(name, position, salary)
    return {
        name = name,
        position = position,
        salary = salary
    }
end

local e1 = Employee("John Doe", "Accountant", 50000)
local e2 = Employee("Jane Doe", "Sales", 40000)
local e3 = Employee("Bob Doe", "Research", 60000)

print("Employee 1's name:\t" .. e1.name)
print("Employee 2's position:\t" .. e2.position)
print("Employee 3's salary:\t" .. e3.salary)

-- Proper way of doing OOP in Lua:

Employee2 = {}
Employee2.__index = Employee2

function Employee2.new(name, position, salary)
    local instance = setmetatable({}, Employee2)
    instance.name = name
    instance.position = position
    instance.salary = salary
    return instance
end

function Employee2:display_employee()
    print("Name:\t" .. self.name)
    print("Position:\t" .. self.position)
    print("Salary:\t" .. self.salary)
end

local em1 = Employee2.new("John Doe", "Accountant", 50000)
local em2 = Employee2.new("Jane Doe", "Sales", 40000)
local em3 = Employee2.new("Bob Doe", "Research", 60000)

print(em1:display_employee())
print(em2:display_employee())
print(em3:display_employee())