-- LuaRocks packages path
package.path = package.path
	.. ";"
	.. vim.fn.expand("$HOME")
	.. "/.luarocks/share/lua/5.1/?.lua;"
	.. vim.fn.expand("$HOME")
	.. "/.luarocks/share/lua/5.1/?/init.lua"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.lazy")
require("config.keymaps")
