# Getting Started with LuaBase

Welcome to LuaBase! This guide will help you get up and running quickly with your Lua development environment.

## 🎬 First-Time Setup (5 minutes)

### Step 1: Open the Project

```powershell
cd path\to\LuaBase
code .
```

### Step 2: Start the Dev Container

1. VS Code will prompt: "Folder contains a Dev Container configuration file. Reopen folder to develop in a container?"
2. Click **"Reopen in Container"** (or press `F1` → "Dev Containers: Reopen in Container")
3. Wait 5-10 minutes for the initial build

### Step 3: Verify Installation

Once the container is ready, open a terminal (`` Ctrl+` ``) and run:

```bash
# Check Lua
lua -v

# Check LuaJIT
luajit -v

# Check LuaRocks
luarocks --version

# Check installed packages
luarocks list
```

### Step 4: Run Your First Example

```bash
cd examples/hello_world
lua hello.lua
```

You should see:
```
Hello, World!
Welcome to Lua development! 🌙
...
```

## 🚦 Quick Commands

### Running Lua Code

```bash
# Standard Lua interpreter
lua script.lua

# High-performance LuaJIT
luajit script.lua

# Interactive REPL
lua -i
```

### Package Management

```bash
# Search for packages
luarocks search http

# Install a package
luarocks install lua-cjson

# List installed packages
luarocks list
```

### Code Quality

```bash
# Format code
stylua myfile.lua

# Lint code
luacheck myfile.lua

# Run tests
busted spec/
```

## 📂 Project Organization

Recommended structure for your Lua projects:

```
my-lua-project/
├── src/               # Source code
│   ├── main.lua
│   └── modules/
│       └── mymodule.lua
├── spec/              # Tests (for busted)
│   └── mymodule_spec.lua
├── examples/          # Usage examples
├── .luacheckrc        # Luacheck configuration
├── stylua.toml        # StyLua configuration
└── README.md
```

## 🎯 Common Tasks

### Create a New Module

```lua
-- src/modules/mymodule.lua
local M = {}

function M.greet(name)
  return "Hello, " .. name .. "!"
end

function M.add(a, b)
  return a + b
end

return M
```

### Use the Module

```lua
-- src/main.lua
local mymodule = require("modules.mymodule")

print(mymodule.greet("World"))
print("2 + 3 =", mymodule.add(2, 3))
```

### Write a Test

```lua
-- spec/mymodule_spec.lua
describe("mymodule", function()
  local mymodule = require("modules.mymodule")
  
  it("should greet correctly", function()
    assert.are.equal("Hello, World!", mymodule.greet("World"))
  end)
  
  it("should add numbers", function()
    assert.are.equal(5, mymodule.add(2, 3))
  end)
end)
```

### Run Tests

```bash
busted spec/
```

## 🌐 Web Development

### Using LuaSocket

```lua
local socket = require("socket")

-- Create a simple HTTP server
local server = socket.bind("*", 8080)
local client = server:accept()

-- Read request
local line = client:receive()
print(line)

-- Send response
client:send("HTTP/1.1 200 OK\r\n")
client:send("Content-Type: text/html\r\n")
client:send("\r\n")
client:send("<h1>Hello from Lua!</h1>")
client:close()
```

## 🔍 Debugging Tips

### Print Debugging

```lua
-- Simple debug output
print("Debug:", variable)

-- Inspect tables with penlight
local pl = require("pl.pretty")
pl.dump(mytable)
```

### Error Handling

```lua
-- Protected call
local ok, result = pcall(function()
  return risky_function()
end)

if not ok then
  print("Error:", result)
end

-- Assert with message
assert(value ~= nil, "Value cannot be nil")
```

## 🎨 Shell Customization

The container uses Oh My Posh with the `markbull` theme. To customize:

```bash
# Edit persistent configuration
nvim /root/.zsh_persistent/.zshrc.local

# Add your aliases and functions
echo 'alias myalias="lua myscript.lua"' >> /root/.zsh_persistent/.zshrc.local

# Reload shell
source ~/.zshrc_custom
```

## 📚 Learning Resources

### Official Documentation
- [Lua 5.4 Reference Manual](https://www.lua.org/manual/5.4/)
- [Programming in Lua (PIL)](https://www.lua.org/pil/)
- [LuaRocks Documentation](https://github.com/luarocks/luarocks/wiki)

### Tutorials
- [Learn Lua in 15 Minutes](http://tylerneylon.com/a/learn-lua/)
- [Lua Tutorial](https://www.tutorialspoint.com/lua/)
- [Lua Users Wiki](http://lua-users.org/wiki/)

### Community
- [Lua Mailing List](https://www.lua.org/lua-l.html)
- [r/lua on Reddit](https://www.reddit.com/r/lua/)
- [Lua Discord](https://discord.gg/lua)

## 🔧 Troubleshooting

### Container Won't Start

```powershell
# Check Docker is running
docker ps

# Rebuild container
.\manage.ps1 build
```

### Module Not Found

```bash
# Check if installed
luarocks list

# Check Lua paths
lua -e "print(package.path)"

# Install missing module
luarocks install <module-name>
```

### Permission Errors

```bash
# Fix permissions (inside container)
chmod +x script.lua
```

## 🎓 Next Steps

1. ✅ Complete the [examples/hello_world](examples/hello_world/README.md) tutorial
2. ✅ Try the [examples/luarocks_demo](examples/luarocks_demo/README.md)
3. ✅ Create your first project in `/projects`
4. ✅ Install packages you need with LuaRocks
5. ✅ Read the [QUICKSTART.md](QUICKSTART.md) for command reference
6. ✅ Explore the [README.md](README.md) for detailed information

## 💡 Pro Tips

1. **Use LuaJIT for performance** - It's significantly faster than standard Lua
2. **Always format with StyLua** - Keep your code consistent
3. **Run luacheck before commits** - Catch errors early
4. **Write tests with Busted** - Ensure code quality
5. **Use the REPL for experimentation** - Quick feedback loop
6. **Leverage LuaRocks** - Don't reinvent the wheel

## 🎉 You're Ready!

Your Lua development environment is fully configured and ready to use. Happy coding! 🌙

Need help? Check:
- [README.md](README.md) - Complete documentation
- [QUICKSTART.md](QUICKSTART.md) - Command reference
- [STATUS.md](STATUS.md) - Feature list and status

---

**Questions?** Open an issue on GitHub or check the Lua community resources.
