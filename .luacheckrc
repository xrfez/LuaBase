# .luacheckrc - Configuration for luacheck linter

-- Ignore some common warnings
ignore = {
    "212", -- Unused argument
    "213", -- Unused loop variable
}

-- Set the standard Lua version
std = "lua54+busted"

-- Add custom globals that are okay to use
globals = {
    "vim", -- For Neovim/Vim Lua scripts
}

-- Files to exclude from checking
exclude_files = {
    ".luarocks/",
    "lua_modules/",
    "build/",
}

-- Maximum line length
max_line_length = 120

-- Maximum cyclomatic complexity
max_cyclomatic_complexity = 15
