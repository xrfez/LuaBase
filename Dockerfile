# Dockerfile for Lua Programming Language Development Environment
# This creates a complete development environment for Lua using:
# - Lua 5.4 (latest stable version)
# - LuaJIT 2.1 (high-performance JIT compiler)
# - LuaRocks (package manager for Lua)
# - Lua Language Server for LSP support
# - StyLua for code formatting
# - Modern development tools (ripgrep, fd, bat, fzf, eza, neovim, tmux)
# - Docker-in-Docker support for running services
# - Build tools (GCC, make, cmake) for compiling native Lua modules

# Base image: Debian Bookworm (stable, lightweight)
FROM debian:bookworm-slim

# Build arguments for customizable installation paths
ARG LUABASE=/opt/lua
ARG LUAJITBASE=/opt/luajit

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    # Lua installation paths
    LUABASE=${LUABASE} \
    LUAJITBASE=${LUAJITBASE} \
    # LuaRocks configuration
    LUA_PATH="/root/.luarocks/share/lua/5.4/?.lua;/root/.luarocks/share/lua/5.4/?/init.lua;${LUABASE}/share/lua/5.4/?.lua;${LUABASE}/share/lua/5.4/?/init.lua;./?.lua;./?/init.lua" \
    LUA_CPATH="/root/.luarocks/lib/lua/5.4/?.so;${LUABASE}/lib/lua/5.4/?.so;./?.so" \
    # Set PATH to include Lua, LuaJIT, LuaRocks, and other binaries
    PATH=${LUABASE}/bin:${LUAJITBASE}/bin:/root/.luarocks/bin:$PATH

# Install system dependencies and build tools
# - build-essential: GCC and essential build tools (make, g++, etc.)
# - libreadline-dev: For Lua interactive console
# - cmake: Modern build system generator
# - git: Required for LuaRocks and package management
# - curl, wget: Download tools
# - ca-certificates: SSL support
# - libssl-dev: OpenSSL development files
# - unzip: For extracting archives
# - ripgrep, fd-find: Modern search tools
# - bat: Cat with syntax highlighting
# - fzf: Fuzzy finder
# - eza: Modern ls replacement
# - neovim: Modern vim
# - tmux: Terminal multiplexer
# - valgrind, gdb, strace: Debugging tools
RUN apt-get update && apt-get install -y \
    build-essential \
    libreadline-dev \
    cmake \
    git \
    curl \
    wget \
    ca-certificates \
    libssl-dev \
    unzip \
    gnupg \
    lsb-release \
    ripgrep \
    fd-find \
    bat \
    fzf \
    neovim \
    tmux \
    valgrind \
    gdb \
    strace \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Create symlinks for fd and bat (Debian uses different names)
RUN ln -sf /usr/bin/fdfind /usr/local/bin/fd && \
    ln -sf /usr/bin/batcat /usr/local/bin/bat

# Install eza (modern ls replacement) from GitHub releases
RUN TEMP_DEB="$(mktemp)" && \
    wget -O "$TEMP_DEB" 'https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz' && \
    tar -xzf "$TEMP_DEB" -C /usr/local/bin && \
    rm -f "$TEMP_DEB"

# Configure tmux with sensible defaults
RUN mkdir -p /root/.config/tmux && \
    { \
    echo '# Tmux Configuration - Minimal Sensible Defaults'; \
    echo ''; \
    echo '# Change prefix from Ctrl+b to Ctrl+a (easier to reach)'; \
    echo 'unbind C-b'; \
    echo 'set-option -g prefix C-a'; \
    echo 'bind-key C-a send-prefix'; \
    echo ''; \
    echo '# Enable mouse support for easier window/pane management'; \
    echo 'set -g mouse on'; \
    echo ''; \
    echo '# Vi-style copy mode'; \
    echo 'setw -g mode-keys vi'; \
    echo 'bind-key -T copy-mode-vi v send-keys -X begin-selection'; \
    echo 'bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel'; \
    echo ''; \
    echo '# Split panes using | and -'; \
    echo 'bind | split-window -h'; \
    echo 'bind - split-window -v'; \
    echo 'unbind '"'"'"'; \
    echo 'unbind %'; \
    echo ''; \
    echo '# Reload config with r'; \
    echo 'bind r source-file ~/.tmux.conf \; display "Config reloaded!"'; \
    echo ''; \
    echo '# Start window numbering at 1'; \
    echo 'set -g base-index 1'; \
    echo 'setw -g pane-base-index 1'; \
    echo ''; \
    echo '# Better colors'; \
    echo 'set -g default-terminal "screen-256color"'; \
    } > /root/.tmux.conf

# Configure Neovim with minimal sensible defaults
RUN mkdir -p /root/.config/nvim && \
    { \
    echo '-- Neovim Configuration - Minimal Sensible Defaults'; \
    echo ''; \
    echo '-- Basic settings'; \
    echo 'vim.opt.number = true          -- Show line numbers'; \
    echo 'vim.opt.relativenumber = true  -- Relative line numbers'; \
    echo 'vim.opt.mouse = "a"            -- Enable mouse support'; \
    echo 'vim.opt.clipboard = "unnamedplus"  -- Use system clipboard'; \
    echo 'vim.opt.expandtab = true       -- Use spaces instead of tabs'; \
    echo 'vim.opt.tabstop = 2            -- 2 spaces for tab'; \
    echo 'vim.opt.shiftwidth = 2         -- 2 spaces for indentation'; \
    echo 'vim.opt.smartindent = true     -- Smart auto-indenting'; \
    echo 'vim.opt.wrap = false           -- No line wrapping'; \
    echo 'vim.opt.ignorecase = true      -- Ignore case in search'; \
    echo 'vim.opt.smartcase = true       -- Unless uppercase is used'; \
    echo 'vim.opt.termguicolors = true   -- Better colors'; \
    echo 'vim.opt.signcolumn = "yes"     -- Always show sign column'; \
    echo ''; \
    echo '-- Key mappings'; \
    echo 'vim.g.mapleader = " "          -- Space as leader key'; \
    echo ''; \
    echo '-- File explorer (netrw)'; \
    echo 'vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file explorer" })'; \
    echo ''; \
    echo '-- Better window navigation'; \
    echo 'vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })'; \
    echo 'vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })'; \
    echo 'vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })'; \
    echo 'vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })'; \
    echo ''; \
    echo '-- Save and quit shortcuts'; \
    echo 'vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })'; \
    echo 'vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })'; \
    echo ''; \
    echo '-- Clear search highlighting'; \
    echo 'vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })'; \
    } > /root/.config/nvim/init.lua

# Install Docker CLI for Docker-in-Docker support
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# Install Lua 5.4 from source
RUN mkdir -p ${LUABASE} && \
    cd /tmp && \
    LUA_VERSION="5.4.7" && \
    curl -fSL "https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz" -o lua.tar.gz && \
    tar -xzf lua.tar.gz && \
    cd lua-${LUA_VERSION} && \
    make linux && \
    make install INSTALL_TOP=${LUABASE} && \
    cd / && \
    rm -rf /tmp/lua*

# Install LuaJIT 2.1 from source
RUN mkdir -p ${LUAJITBASE} && \
    cd /tmp && \
    git clone https://github.com/LuaJIT/LuaJIT.git && \
    cd LuaJIT && \
    make && \
    make install PREFIX=${LUAJITBASE} && \
    cd / && \
    rm -rf /tmp/LuaJIT

# Install LuaRocks (package manager for Lua)
RUN cd /tmp && \
    LUAROCKS_VERSION="3.11.1" && \
    curl -fSL "https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz" -o luarocks.tar.gz && \
    tar -xzf luarocks.tar.gz && \
    cd luarocks-${LUAROCKS_VERSION} && \
    ./configure --prefix=/usr/local --with-lua=${LUABASE} && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/luarocks*

# Install Lua Language Server (for LSP support in editors)
RUN cd /tmp && \
    git clone https://github.com/LuaLS/lua-language-server.git && \
    cd lua-language-server && \
    git submodule update --init --recursive && \
    cd 3rd/luamake && \
    ./compile/install.sh && \
    cd ../.. && \
    ./3rd/luamake/luamake rebuild && \
    mkdir -p /usr/local/lua-language-server && \
    cp -r bin /usr/local/lua-language-server/ && \
    cp -r main.lua /usr/local/lua-language-server/ && \
    cp -r debugger.lua /usr/local/lua-language-server/ && \
    cp -r locale /usr/local/lua-language-server/ && \
    cp -r meta /usr/local/lua-language-server/ && \
    cp -r script /usr/local/lua-language-server/ && \
    echo '#!/bin/bash' > /usr/local/bin/lua-language-server && \
    echo 'exec /usr/local/lua-language-server/bin/lua-language-server "$@"' >> /usr/local/bin/lua-language-server && \
    chmod +x /usr/local/bin/lua-language-server && \
    cd / && \
    rm -rf /tmp/lua-language-server

# Install StyLua (Lua code formatter) from GitHub releases
RUN cd /tmp && \
    STYLUA_VERSION="0.20.0" && \
    curl -fSL "https://github.com/JohnnyMorganz/StyLua/releases/download/v${STYLUA_VERSION}/stylua-linux-x86_64.zip" -o stylua.zip && \
    unzip stylua.zip && \
    chmod +x stylua && \
    mv stylua /usr/local/bin/ && \
    cd / && \
    rm -rf /tmp/stylua*

# Install common Lua packages via LuaRocks
RUN luarocks install luacheck && \
    luarocks install luasocket && \
    luarocks install luafilesystem && \
    luarocks install penlight && \
    luarocks install busted

# Install Oh My Posh for modern cross-platform prompt theming
RUN curl -s https://ohmyposh.dev/install.sh | bash -s

# Configure Oh My Posh with markbull theme for zsh
RUN mkdir -p /root/.config && \
    { \
    echo '# Zsh history configuration - persist in volume'; \
    echo 'export HISTFILE=/root/.zsh_history_persistent/.zsh_history'; \
    echo 'export HISTSIZE=10000'; \
    echo 'export SAVEHIST=10000'; \
    echo 'setopt SHARE_HISTORY'; \
    echo 'setopt HIST_IGNORE_DUPS'; \
    echo 'setopt HIST_FIND_NO_DUPS'; \
    echo ''; \
    echo '# Oh My Posh initialization for Lua development'; \
    echo 'eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/markbull.omp.json)"'; \
    echo ''; \
    echo '# VS Code shell integration for better terminal experience'; \
    echo '[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)" 2>/dev/null || true'; \
    echo ''; \
    echo '# Custom aliases for Lua development'; \
    echo "alias luai='lua -i'"; \
    echo "alias luajit='${LUAJITBASE}/bin/luajit'"; \
    echo "alias luajiti='${LUAJITBASE}/bin/luajit -i'"; \
    echo "alias lr='luarocks'"; \
    echo "alias lri='luarocks install'"; \
    echo "alias lrs='luarocks search'"; \
    echo "alias lrl='luarocks list'"; \
    echo ''; \
    echo '# Source local customizations if they exist (persists across rebuilds)'; \
    echo 'if [ -f /root/.zsh_persistent/.zshrc.local ]; then'; \
    echo '    source /root/.zsh_persistent/.zshrc.local'; \
    echo 'fi'; \
    echo ''; \
    echo '# Show Lua development environment info on startup'; \
    echo 'echo "======================================"'; \
    echo 'echo "  Lua Development Environment"'; \
    echo 'echo "  with Oh My Posh (markbull theme)"'; \
    echo 'echo "======================================"'; \
    echo 'echo "Lua:        $(lua -v)"'; \
    echo 'echo "LuaJIT:     $(${LUAJITBASE}/bin/luajit -v)"'; \
    echo 'echo "LuaRocks:   $(luarocks --version | head -n1)"'; \
    echo 'echo "Git:        $(git --version)"'; \
    echo 'echo "Docker:     $(docker --version)"'; \
    echo 'echo ""'; \
    echo 'echo "Package Manager: LuaRocks"'; \
    echo 'echo "Formatter:       StyLua"'; \
    echo 'echo "Language Server: lua-language-server"'; \
    echo 'echo ""'; \
    echo 'echo "Workspace: /projects/LuaBase"'; \
    echo 'echo "======================================"'; \
    } > /root/.zshrc_custom

# Create persistent zsh config directory and default .zshrc.local
RUN mkdir -p /root/.zsh_persistent && \
    { \
    echo '# Persistent Zsh Configuration'; \
    echo '# This file is stored in a Docker volume and persists across container rebuilds'; \
    echo '# Add your custom aliases, functions, and environment variables here'; \
    echo ''; \
    echo '# Example customizations:'; \
    echo '# export MY_VAR="value"'; \
    echo '# alias myalias="command"'; \
    } > /root/.zsh_persistent/.zshrc.local && \
    # Create directories for persistent history files \
    mkdir -p /root/.bash_history_persistent /root/.zsh_history_persistent /root/.cache/oh-my-posh && \
    # Configure bash history to use file in persistent directory \
    echo 'export HISTFILE=/root/.bash_history_persistent/.bash_history' >> /root/.bashrc && \
    # Ensure UTF-8 locale is set for bash scripts (for emoji and Unicode support) \
    echo 'export LANG=C.UTF-8' >> /root/.bashrc && \
    echo 'export LC_ALL=C.UTF-8' >> /root/.bashrc

# Create workspace directory (will be overridden by volume mount)
RUN mkdir -p /workspace

# Set working directory (updated by devcontainer to /projects/LuaBase)
WORKDIR /projects/LuaBase

# Default shell is bash for Linux container
SHELL ["/bin/bash", "-c"]

# Set up bash prompt with version information
RUN echo 'export PS1="\[\e[1;32m\][lua-dev]\[\e[0m\] \w $ "' >> /root/.bashrc \
    && echo 'echo "======================================"' >> /root/.bashrc \
    && echo 'echo "  Lua Development Environment"' >> /root/.bashrc \
    && echo 'echo "======================================"' >> /root/.bashrc \
    && echo 'echo "Lua:        $(lua -v)"' >> /root/.bashrc \
    && echo 'echo "LuaJIT:     $(${LUAJITBASE}/bin/luajit -v)"' >> /root/.bashrc \
    && echo 'echo "LuaRocks:   $(luarocks --version | head -n1)"' >> /root/.bashrc \
    && echo 'echo "Git:        $(git --version)"' >> /root/.bashrc \
    && echo 'echo "GCC:        $(gcc --version | head -n1)"' >> /root/.bashrc \
    && echo 'echo "CMake:      $(cmake --version | head -n1)"' >> /root/.bashrc \
    && echo 'echo "Docker:     $(docker --version)"' >> /root/.bashrc \
    && echo 'echo ""' >> /root/.bashrc \
    && echo 'echo "Package Manager: LuaRocks"' >> /root/.bashrc \
    && echo 'echo "Formatter:       StyLua"' >> /root/.bashrc \
    && echo 'echo "Language Server: lua-language-server"' >> /root/.bashrc \
    && echo 'echo ""' >> /root/.bashrc \
    && echo 'echo "Workspace: /workspace"' >> /root/.bashrc \
    && echo 'echo "======================================"' >> /root/.bashrc \
    && echo 'echo "Tip: Type '\''zsh'\'' for Oh My Posh shell"' >> /root/.bashrc

# Expose common ports for development
# 8080: Common development server port
# 3000: Web development server
EXPOSE 8080 3000

# Default command: start bash shell
CMD ["/bin/bash"]
