#!/usr/bin/env lua

-- Hello World in Lua
-- This is a simple example to verify your Lua environment is working

print("Hello, World!")
print("Welcome to Lua development! 🌙")

-- Demonstrate some basic Lua features
local function greet(name)
    return string.format("Hello, %s!", name)
end

-- Print a personalized greeting
print(greet("Lua Developer"))

-- Show Lua version
print("\nRunning on: " .. _VERSION)

-- Demonstrate table (Lua's main data structure)
local person = {
    name = "John",
    age = 30,
    languages = {"Lua", "Python", "JavaScript"}
}

print("\nPerson info:")
print("  Name: " .. person.name)
print("  Age: " .. person.age)
print("  Languages: " .. table.concat(person.languages, ", "))

-- Simple math
local a, b = 10, 20
print("\nMath example:")
print(string.format("  %d + %d = %d", a, b, a + b))
print(string.format("  %d * %d = %d", a, b, a * b))

-- Demonstrate iterator
print("\nCounting to 5:")
for i = 1, 5 do
    print("  " .. i)
end

print("\n✅ Lua environment is working correctly!")
