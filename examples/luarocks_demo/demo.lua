#!/usr/bin/env lua

-- LuaRocks Demo
-- Demonstrates using packages installed via LuaRocks

print("=== LuaRocks Package Demo ===\n")

-- 1. Using luasocket for networking
print("1. LuaSocket Example:")
local socket = require("socket")
print("   Current time (Unix timestamp): " .. socket.gettime())

-- 2. Using luafilesystem for file operations
print("\n2. LuaFileSystem Example:")
local lfs = require("lfs")
print("   Current directory: " .. lfs.currentdir())

-- List files in current directory
print("   Files in this directory:")
for file in lfs.dir(".") do
    if file ~= "." and file ~= ".." then
        local attr = lfs.attributes(file)
        if attr then
            print(string.format("     - %s (%s)", file, attr.mode))
        end
    end
end

-- 3. Using penlight for utilities
print("\n3. Penlight Example:")
local pl = require("pl.import_into")()

-- String utilities
local text = "  hello, lua!  "
print("   Original: '" .. text .. "'")
print("   Trimmed:  '" .. pl.stringx.strip(text) .. "'")
print("   Title:    '" .. pl.stringx.title(text) .. "'")

-- Table utilities
local numbers = {5, 2, 8, 1, 9, 3}
print("\n   Original numbers: " .. pl.pretty.write(numbers, ""))
pl.tablex.sort(numbers)
print("   Sorted numbers:   " .. pl.pretty.write(numbers, ""))

-- 4. Simple JSON example using penlight
print("\n4. JSON Example:")
local data = {
    name = "Lua Developer",
    skills = {"Lua", "LuaJIT", "LuaRocks"},
    experience = 5,
    active = true
}

-- Note: For production, use lua-cjson which is faster
-- Install with: luarocks install lua-cjson
local json_str = pl.pretty.write(data)
print("   Data as Lua table:")
print("   " .. json_str)

-- 5. Path utilities
print("\n5. Path Utilities:")
local path = require("pl.path")
print("   Path separator: " .. path.sep)
print("   Is absolute path '/opt/lua': " .. tostring(path.isabs("/opt/lua")))
print("   Basename of '/projects/LuaBase/demo.lua': " .. path.basename("/projects/LuaBase/demo.lua"))

print("\n✅ All LuaRocks packages working correctly!")
print("\nInstalled packages used in this demo:")
print("  - luasocket:      Network support")
print("  - luafilesystem:  File system operations")
print("  - penlight:       Batteries-included utilities")

print("\nTo install more packages:")
print("  luarocks search <name>")
print("  luarocks install <name>")
