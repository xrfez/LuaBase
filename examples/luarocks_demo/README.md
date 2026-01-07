# LuaRocks Demo

This example demonstrates using packages installed via LuaRocks, Lua's package manager.

## Prerequisites

The following packages are pre-installed in the container:
- `luasocket` - Network support
- `luafilesystem` - File system operations
- `penlight` - Utilities library

## Running the Demo

```bash
cd /projects/LuaBase/examples/luarocks_demo
lua demo.lua
```

## What This Example Demonstrates

### 1. LuaSocket
Network operations and time functions:
```lua
local socket = require("socket")
print(socket.gettime())
```

### 2. LuaFileSystem
File and directory operations:
```lua
local lfs = require("lfs")
print(lfs.currentdir())
```

### 3. Penlight
Comprehensive utility library:
```lua
local pl = require("pl.import_into")()
pl.stringx.strip(text)
pl.tablex.sort(table)
```

## Managing Packages

### Search for Packages
```bash
luarocks search json
luarocks search http
```

### Install Packages
```bash
# Install latest version
luarocks install lua-cjson

# Install specific version
luarocks install lua-cjson 2.1.0
```

### List Installed Packages
```bash
luarocks list
```

### Remove Packages
```bash
luarocks remove lua-cjson
```

### Show Package Information
```bash
luarocks show lua-cjson
```

## Popular Packages to Try

### JSON Processing
```bash
luarocks install lua-cjson
```
```lua
local cjson = require("cjson")
local json_str = cjson.encode({key = "value"})
local data = cjson.decode(json_str)
```

### HTTP Client
```bash
luarocks install http
```
```lua
local http = require("http.request")
local req = http.new_from_uri("https://api.github.com")
local headers, stream = req:go()
```

### Web Framework (Lapis)
```bash
luarocks install lapis
```

### Database (SQLite)
```bash
luarocks install lsqlite3
```

### Template Engine
```bash
luarocks install lustache
```

### Async/Await
```bash
luarocks install lua-async
```

## Using Packages in Your Code

### Method 1: Direct require
```lua
local socket = require("socket")
local lfs = require("lfs")
```

### Method 2: Protected require (safer)
```lua
local ok, socket = pcall(require, "socket")
if not ok then
    print("Error: luasocket not installed")
    print("Install with: luarocks install luasocket")
    os.exit(1)
end
```

## Creating a Package Manifest

For your projects, create a rockspec file:

```bash
# Generate a rockspec template
luarocks write_rockspec
```

Example `myproject-1.0-1.rockspec`:
```lua
package = "myproject"
version = "1.0-1"
source = {
   url = "git://github.com/user/myproject"
}
dependencies = {
   "lua >= 5.1",
   "luasocket >= 3.0",
   "luafilesystem >= 1.8",
   "penlight >= 1.13"
}
build = {
   type = "builtin",
   modules = {
      myproject = "src/myproject.lua"
   }
}
```

## Troubleshooting

### Module not found
```bash
# Check if package is installed
luarocks list

# Check Lua paths
lua -e "print(package.path)"
lua -e "print(package.cpath)"
```

### Installation failed
```bash
# Update LuaRocks
luarocks update

# Install with verbose output
luarocks install <package> --verbose
```

### C module compilation failed
Make sure build tools are available (they are pre-installed in this container):
```bash
gcc --version
make --version
```

## Learn More

- [LuaRocks Website](https://luarocks.org/)
- [LuaRocks Documentation](https://github.com/luarocks/luarocks/wiki)
- [Awesome Lua](https://github.com/LewisJEllis/awesome-lua) - Curated list of packages
- [Lua Modules](http://lua-users.org/wiki/LuaModules)

## Next Steps

1. Try installing and using a new package
2. Create your own Lua module
3. Write a rockspec for your project
4. Explore the [LuaRocks package list](https://luarocks.org/modules)
