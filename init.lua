require("remap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
	print("Installing lazy.nvim....")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
	print("Done.")
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{"rose-pine/neovim", name = "rose-pine"},
	{"williamboman/mason.nvim"},
	{"williamboman/mason-lspconfig.nvim"},
	{"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
	{"neovim/nvim-lspconfig"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/nvim-cmp"},
	{"L3MON4D3/LuaSnip"},
})

vim.opt.termguicolors = true
vim.cmd.colorscheme("rose-pine")

local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = {
		lua_ls = function()
			require('lspconfig').lua_ls.setup({
				settings = {
					Lua = {}
				},
				on_init = function(client)
					local uv = vim.uv or vim.loop
					local path = client.workspace_folders[1].name

					-- Don't do anything if there is a project local config
					if uv.fs_stat(path .. '/.luarc.json')
						or uv.fs_stat(path .. '/.luarc.jsonc')
						then
							return
						end

						-- Apply neovim specific settings
						local lua_opts = lsp_zero.nvim_lua_ls()

						client.config.settings.Lua = vim.tbl_deep_extend(
						'force',
						client.config.settings.Lua,
						lua_opts.settings.Lua
						)
					end,
				})
			end,
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
		},
	})
