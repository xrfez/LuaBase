# Hello World Example

This is a basic Lua example to verify your development environment is working correctly.

## Running the Example

### Using Lua

```bash
cd /projects/LuaBase/examples/hello_world
lua hello.lua
```

### Using LuaJIT (faster)

```bash
cd /projects/LuaBase/examples/hello_world
luajit hello.lua
```

### Making it executable

```bash
chmod +x hello.lua
./hello.lua
```

## Expected Output

```
Hello, World!
Welcome to Lua development! 🌙
Hello, Lua Developer!

Running on: Lua 5.4

Person info:
  Name: John
  Age: 30
  Languages: Lua, Python, JavaScript

Math example:
  10 + 20 = 30
  10 * 20 = 200

Counting to 5:
  1
  2
  3
  4
  5

✅ Lua environment is working correctly!
```

## What This Example Demonstrates

- Basic print statements
- Function definitions
- String formatting
- Tables (Lua's primary data structure)
- Basic arithmetic
- For loops
- String concatenation

## Next Steps

1. Modify the script to print your own message
2. Add more functions
3. Try creating your own Lua modules
4. Check out the `luarocks_demo` example for package management

## Learn More

- [Lua Manual](https://www.lua.org/manual/5.4/)
- [Learn Lua in 15 Minutes](http://tylerneylon.com/a/learn-lua/)
- [Lua Tutorial](https://www.tutorialspoint.com/lua/)
