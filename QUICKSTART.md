# Lua Development Environment - Quick Reference

## 🚀 Quick Start (First Time Setup)

1. **Clone and open**:
   ```powershell
   git clone <your-repo-url> LuaBase
   cd LuaBase
   code .
   ```

2. **Reopen in container**:
   - Press `F1`
   - Select: `Dev Containers: Reopen in Container`
   - Wait for build (5-10 minutes)

3. **Done!** Terminal opens at `/projects/LuaBase` ready to code.

---

## Container Commands

### Using Management Script (Easiest)
```powershell
# Start container
.\manage.ps1 start

# Enter container
.\manage.ps1 shell

# Stop container
.\manage.ps1 stop

# Rebuild
.\manage.ps1 build

# View status
.\manage.ps1 status

# See all commands
.\manage.ps1 help
```

### Start/Stop Container (Manual)
```powershell
# Start container
docker-compose up -d

# Stop container
docker-compose down

# Restart
docker-compose restart
```

### Enter Container
```powershell
# Using docker-compose (recommended)
docker-compose exec lua-dev zsh

# Using docker directly
docker exec -it lua-dev-container zsh

# Then navigate to your workspace
cd /projects/LuaBase
```

---

## Lua Commands

### Running Lua Code
```bash
# Run a script
lua script.lua

# Interactive REPL
lua -i

# Run with LuaJIT (faster)
luajit script.lua

# Interactive LuaJIT REPL
luajit -i
```

### LuaRocks (Package Manager)
```bash
# Search for packages
luarocks search <package>

# Install package
luarocks install <package>

# Install specific version
luarocks install <package> <version>

# List installed packages
luarocks list

# Remove package
luarocks remove <package>

# Update package
luarocks install <package> --force

# Show package details
luarocks show <package>
```

### Code Formatting
```bash
# Format single file
stylua myfile.lua

# Format all files in directory
stylua .

# Check without formatting
stylua --check .
```

### Code Linting
```bash
# Lint single file
luacheck myfile.lua

# Lint all files
luacheck .

# Lint with specific standard
luacheck --std=max .
```

### Testing
```bash
# Run tests with busted
busted

# Run specific test file
busted spec/mytest_spec.lua

# Verbose output
busted -v
```

---

## Common Aliases

Pre-configured aliases in the container:

```bash
luai          # lua -i (interactive Lua)
luajit        # LuaJIT compiler
luajiti       # luajit -i (interactive LuaJIT)
lr            # luarocks
lri           # luarocks install
lrs           # luarocks search
lrl           # luarocks list
```

---

## Quick File Creation

### Basic Lua Script
```bash
cat > script.lua << 'EOF'
#!/usr/bin/env lua

print("Hello, Lua!")
EOF

chmod +x script.lua
lua script.lua
```

### Module File
```bash
cat > mymodule.lua << 'EOF'
local M = {}

function M.greet(name)
    return "Hello, " .. name .. "!"
end

return M
EOF
```

### Test File (Busted)
```bash
cat > mymodule_spec.lua << 'EOF'
describe("mymodule", function()
    local mymodule = require("mymodule")
    
    it("should greet properly", function()
        assert.are.equal("Hello, World!", mymodule.greet("World"))
    end)
end)
EOF
```

---

## Debugging Tips

### Print Debugging
```lua
-- Simple print
print("Debug:", variable)

-- Pretty print tables
local inspect = require("inspect")
print(inspect(mytable))
```

### Using debug library
```lua
-- Print stack trace
debug.traceback()

-- Get local variables
local info = debug.getinfo(1, "nSl")
```

---

## Environment Info

```bash
# Check versions
lua -v
luajit -v
luarocks --version

# Check Lua paths
lua -e "print(package.path)"
lua -e "print(package.cpath)"

# List installed packages
luarocks list

# Show system info
uname -a
```

---

## Directory Structure

```
/projects/LuaBase/     # Your workspace (mounted from host)
/opt/lua/              # Lua installation
/opt/luajit/           # LuaJIT installation
/root/.luarocks/       # LuaRocks packages (cached in volume)
```

---

## Useful Commands

### File Operations
```bash
fd "*.lua"             # Find Lua files (modern find)
rg "function"          # Search in files (ripgrep)
bat myfile.lua         # Cat with syntax highlighting
eza -la                # List files (modern ls)
```

### Git Commands
```bash
git status
git add .
git commit -m "message"
git push
```

### Docker-in-Docker
```bash
docker ps              # List running containers
docker images          # List images
docker-compose up -d   # Start services
```

---

## VS Code Integration

### Opening Terminal
- Press `` Ctrl+` ``

### Running Lua from VS Code
1. Open a `.lua` file
2. Right-click → Run Code (if Code Runner installed)
3. Or use terminal: `lua filename.lua`

### Formatting
- Save file: Auto-formats with StyLua
- Manual: Right-click → Format Document

---

## Troubleshooting

### Module not found
```bash
# Check if package is installed
luarocks list

# Install missing package
luarocks install <package>

# Check Lua path
lua -e "print(package.path)"
```

### Permission denied
```bash
# Fix permissions
chmod +x script.lua

# Or run with lua
lua script.lua
```

### Container issues
```powershell
# Restart container
.\manage.ps1 restart

# Rebuild container
.\manage.ps1 build

# View logs
.\manage.ps1 logs
```

---

## Popular Lua Packages

```bash
# JSON
luarocks install lua-cjson

# HTTP client
luarocks install http

# Web framework
luarocks install lapis

# Template engine
luarocks install lustache

# Testing
luarocks install busted

# Linting
luarocks install luacheck

# Networking
luarocks install luasocket

# File system
luarocks install luafilesystem
```

---

## Resources

- [Lua Manual](https://www.lua.org/manual/5.4/)
- [LuaRocks](https://luarocks.org/)
- [Lua Users Wiki](http://lua-users.org/wiki/)
- [Learn Lua in 15 Minutes](http://tylerneylon.com/a/learn-lua/)

---

**Pro Tips:**
- Use `luajit` for performance-critical code
- Always version your LuaRocks dependencies
- Use `stylua` before committing code
- Run `luacheck` to catch common errors
- Use `busted` for unit testing

---

Happy Lua coding! 🌙
