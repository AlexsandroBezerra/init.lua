require('remap')

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

require('lazy').setup({
	{ "rose-pine/neovim", name = "rose-pine" },
	{"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
	{"neovim/nvim-lspconfig"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/nvim-cmp"},
	{"L3MON4D3/LuaSnip"},
})

vim.opt.termguicolors = true
vim.cmd.colorscheme("rose-pine")

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('lspconfig').tsserver.setup({})
