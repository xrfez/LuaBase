# Lua Development Environment with Docker

A complete, plug-and-play Docker-based development environment for the Lua programming language. This setup provides a consistent development experience across different machines and integrates seamlessly with VS Code's Dev Containers extension.

## 🎯 Features

- **Lua 5.4**: Latest stable version of Lua
- **LuaJIT 2.1**: High-performance JIT compiler for performance-critical code
- **LuaRocks**: Package manager for Lua modules
- **Language Server**: lua-language-server for IDE features (autocomplete, go-to-definition, etc.)
- **Code Formatter**: StyLua for automatic code formatting
- **Build Tools**: GCC, Make, CMake for compiling native Lua modules
- **Pre-installed Packages**: luacheck, luasocket, luafilesystem, penlight, busted
- **Docker-in-Docker**: Run Docker commands inside the container for databases, services, etc.
- **Modern CLI Tools**: ripgrep, fd, bat, fzf, eza for enhanced productivity
- **Text Editors**: Neovim with Lua LSP support and sensible defaults
- **Terminal Tools**: tmux with mouse support and vi-style keybindings
- **Debugging Tools**: GDB, Valgrind, strace for comprehensive debugging
- **VS Code Integration**: Full Dev Containers support with recommended extensions
- **Persistent Storage**: Volumes for package cache and shell history
- **Git Integration**: Automatic SSH key and credential sharing from Windows host
- **Oh My Posh**: Modern cross-platform prompt theme engine with customizable themes

## 📋 Prerequisites

### Required
- **Windows 11** with WSL2 installed
- **Docker Desktop** for Windows (with WSL2 backend enabled)
- **VS Code** with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Recommended (for best terminal experience)
- **Nerd Font** installed on Windows for proper Oh My Posh theme rendering
  - Download: [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
  - Popular choices: FiraCode Nerd Font, MesloLGS NF, Hack Nerd Font
  - Install on Windows, then configure VS Code to use it

### Optional
- Git for version control
- Basic knowledge of Docker and containers

## 🚀 Quick Start

### Clone Location Flexibility

You can clone this repository **anywhere** on your system. The container will automatically mount the parent directory, giving you access to sibling projects:

```powershell
# Example locations:
#   C:\Users\YourName\Dev\LuaBase
#   D:\Programming\LuaBase
#   E:\Projects\Docker\LuaBase
```

The container mounts the **parent directory** to `/projects`, so you'll have access to:
- LuaBase at `/projects/LuaBase` (workspace folder)
- Any other projects in the parent directory at `/projects/OtherProject`

### Option 1: Using VS Code Dev Containers (Recommended)

1. **Navigate to the LuaBase directory**:
   ```powershell
   cd path\to\LuaBase
   ```

2. **Open in VS Code**:
   ```powershell
   code .
   ```

3. **Reopen in Container**:
   - Press `F1` to open the command palette
   - Type and select: `Dev Containers: Reopen in Container`
   - Wait for the container to build (first time takes 5-10 minutes)
   - VS Code will reload inside the container

4. **Start coding**:
   - Open the integrated terminal (`` Ctrl+` ``)
   - You're now in a fully configured Lua environment!

### Option 2: Using Docker Compose Directly

1. **Build and start the container**:
   ```powershell
   docker-compose up -d
   ```

2. **Enter the container**:
   ```powershell
   docker-compose exec lua-dev zsh
   ```

3. **Verify installation**:
   ```bash
   lua -v
   luajit -v
   luarocks --version
   lua-language-server --version
   stylua --version
   ```

## 📁 Project Structure

```
LuaBase/
│
├── .devcontainer/
│   └── devcontainer.json         # VS Code Dev Container configuration
│
├── examples/
│   ├── hello_world/              # Basic Lua example
│   │   ├── hello.lua
│   │   └── README.md
│   └── luarocks_demo/            # LuaRocks package example
│       ├── demo.lua
│       └── README.md
│
├── Dockerfile                    # Docker image definition
├── docker-compose.yml            # Docker Compose orchestration
├── .dockerignore                 # Files to exclude from Docker context
├── .editorconfig                 # Editor configuration
├── .gitignore                    # Git ignore patterns
├── manage.ps1                    # PowerShell management script
├── README.md                     # This file (comprehensive guide)
├── QUICKSTART.md                 # Quick reference guide
└── LICENSE                       # MIT License

# Persistent Data (Docker Volumes):
# - lua-dev-luarocks-cache        # LuaRocks package cache
# - lua-dev-lua-cache             # Lua runtime cache
# - lua-dev-bash-history          # Bash history
# - lua-dev-zsh-history           # Zsh history
# - lua-dev-zsh-config            # Zsh customizations (.zshrc.local)
```

## 🛠️ Usage Guide

### Creating a New Lua Project

Inside the container (or Dev Container terminal):

```bash
# Navigate to your projects directory
cd /projects

# Create a new project directory
mkdir my-lua-project
cd my-lua-project

# Create main Lua file
cat > main.lua << 'EOF'
#!/usr/bin/env lua

print("Hello from Lua!")
EOF

# Make it executable
chmod +x main.lua

# Run it
lua main.lua
```

### Managing Dependencies with LuaRocks

```bash
# Search for packages
luarocks search json

# Install a package
luarocks install lua-cjson

# Install specific version
luarocks install lua-cjson 2.1.0

# List installed packages
luarocks list

# Remove a package
luarocks remove lua-cjson

# Show package info
luarocks show lua-cjson
```

### Using LuaJIT for Performance

```bash
# Run with LuaJIT
luajit myscript.lua

# JIT compilation information
luajit -jv myscript.lua

# JIT dump (advanced)
luajit -jdump myscript.lua
```

### Running and Testing Lua Code

```bash
# Run a Lua script
lua script.lua

# Interactive Lua REPL
lua -i

# Run with LuaJIT
luajit script.lua

# Interactive LuaJIT REPL
luajit -i

# Run tests with Busted
busted spec/
```

### Code Formatting with StyLua

```bash
# Format a single file
stylua myfile.lua

# Format all Lua files in current directory
stylua .

# Check if files need formatting (dry run)
stylua --check .

# Format specific files
stylua src/ tests/
```

### Code Linting with Luacheck

```bash
# Check a single file
luacheck myfile.lua

# Check all Lua files
luacheck .

# Check with specific standards
luacheck --std=max myfile.lua

# Check with custom configuration
luacheck --config .luacheckrc .
```

## 🎨 Oh My Posh Customization

The container comes with Oh My Posh pre-installed with the `markbull` theme. You can customize it:

### Changing Themes

```bash
# List available themes
oh-my-posh config theme list

# Preview a theme
eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/gruvbox.omp.json)"

# Make it permanent - edit your .zshrc.local
echo 'eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/gruvbox.omp.json)"' > /root/.zsh_persistent/.zshrc.local
```

Popular themes:
- `markbull` (default) - Clean and minimal
- `gruvbox` - Retro groove color scheme
- `powerlevel10k_rainbow` - Colorful and informative
- `atomic` - Compact and fast
- `catppuccin` - Soothing pastel theme

## 🐛 Debugging

### Using print() for debugging

```lua
-- Simple debug output
print("Debug:", variable)

-- Pretty print tables
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

print(dump(mytable))
```

### Using GDB with Lua

```bash
# Compile Lua with debug symbols (if needed)
gdb lua
(gdb) run myscript.lua
```

### Using Valgrind for memory leaks

```bash
valgrind --leak-check=full lua myscript.lua
```

## 📦 Common Lua Packages

Pre-installed packages:
- **luacheck** - Static analyzer and linter
- **luasocket** - Network support (TCP, UDP, HTTP, FTP, SMTP)
- **luafilesystem** - File system operations
- **penlight** - Batteries included (string, table, functional utilities)
- **busted** - Unit testing framework

Popular packages to install:
```bash
luarocks install lua-cjson      # Fast JSON encoding/decoding
luarocks install lpeg           # Pattern matching library
luarocks install luasec         # SSL/TLS support
luarocks install lsqlite3       # SQLite bindings
luarocks install http           # HTTP client/server
```

## 🔧 Customization

### Persistent Zsh Configuration

Your custom aliases and settings persist across container rebuilds:

```bash
# Edit persistent configuration
nvim /root/.zsh_persistent/.zshrc.local

# Add custom aliases, functions, environment variables
# Example:
export MY_PROJECT_PATH="/projects/my-project"
alias mytest="lua tests/run.lua"
```

### VS Code Settings

The `.devcontainer/devcontainer.json` file contains VS Code settings. Customize:
- Extensions
- Editor settings
- Terminal preferences
- Lua language server configuration

## 🌐 Working with Docker-in-Docker

Run databases and services inside the container:

```bash
# Run PostgreSQL
docker run -d --name postgres -e POSTGRES_PASSWORD=secret -p 5432:5432 postgres

# Run Redis
docker run -d --name redis -p 6379:6379 redis

# Run MongoDB
docker run -d --name mongo -p 27017:27017 mongo

# Check running containers
docker ps
```

## 🚨 Troubleshooting

### Container won't start

```powershell
# Check Docker is running
docker ps

# Rebuild from scratch
.\manage.ps1 clean-all
.\manage.ps1 build
```

### Permission errors

```bash
# Fix permissions in mounted directory
sudo chown -R root:root /projects/LuaBase
```

### Lua package not found

```bash
# Reinstall LuaRocks packages
luarocks list
luarocks install <package-name>

# Check Lua paths
lua -e "print(package.path)"
lua -e "print(package.cpath)"
```

## 📝 Management Script Commands

```powershell
# Start container
.\manage.ps1 start

# Stop container
.\manage.ps1 stop

# Restart container
.\manage.ps1 restart

# Rebuild container
.\manage.ps1 build

# Enter shell
.\manage.ps1 shell

# View logs
.\manage.ps1 logs

# Show status
.\manage.ps1 status

# Clean up (keeps volumes)
.\manage.ps1 clean

# Clean everything (removes volumes)
.\manage.ps1 clean-all

# Open in VS Code
.\manage.ps1 vscode

# Show help
.\manage.ps1 help
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Lua team for the amazing language
- LuaJIT project for the JIT compiler
- LuaRocks team for the package manager
- lua-language-server for excellent LSP support
- StyLua for code formatting
- Oh My Posh for beautiful shell prompts
- Docker for containerization technology

## 🔗 Useful Links

- [Lua Official Website](https://www.lua.org/)
- [LuaJIT](https://luajit.org/)
- [LuaRocks](https://luarocks.org/)
- [Lua Language Server](https://github.com/LuaLS/lua-language-server)
- [StyLua](https://github.com/JohnnyMorganz/StyLua)
- [Oh My Posh](https://ohmyposh.dev/)
- [Awesome Lua](https://github.com/LewisJEllis/awesome-lua) - Curated list of Lua packages

## 📊 Version Information

- Lua: 5.4.7
- LuaJIT: 2.1 (latest)
- LuaRocks: 3.11.1
- StyLua: 0.20.0
- Base Image: Debian Bookworm (stable)

---

**Happy Lua coding! 🌙✨**
