-- https://neovim.io/doc/user/lua-guide.html

vim.cmd.set("clipboard+=unnamedplus")
vim.cmd.set("number")

-- terminal colors
vim.opt.termguicolors = true
vim.opt.background = 'light'

vim.g.mapleader = "m" -- Make sure to set `mapleader` before lazy so your mappings are correct

-------------------------------------------------------------------------------
--
-- lazy.nvim
-- https://github.com/folke/lazy.nvim
--
-------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- latest stable release
    "git@github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-------------------------------------------------------------------------------
--
-- custom plugins
--
-------------------------------------------------------------------------------

require("plugins-local.tmux-like").setup()

-------------------------------------------------------------------------------
--
-- TODO
--
--   - https://github.com/crispgm/nvim-tabline
--   - https://github.com/nvim-neo-tree/neo-tree.nvim
--   
--   - nvr -c "exec 'f term://'.b:term_title.'/-/zsh'" || nvr -c "exec 'f term://'.fnamemodify(fnamemodify(getcwd(), ':h'), ':t').'/'.fnamemodify(getcwd(), ':t').'/-/zsh'"
--   - Zoom: https://stackoverflow.com/a/26551079/3087441
--
-------------------------------------------------------------------------------
