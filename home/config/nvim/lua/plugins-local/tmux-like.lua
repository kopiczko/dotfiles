-- :lua require("plugins-local.tmux-like").setup()
local function is_tmux()
	return not os.getenv("TMUX") == '' or not os.getenv("TMUX") == nil
end

local function noremap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local M = {}

function M.setup()
	if is_tmux() then return end

	-- normal mode in terminal
	noremap({"t"}, [[<C-[>]], [[<C-\><C-n>]])
	noremap({"t"}, [[<C-s>[]], [[<C-\><C-n>]])
	noremap({"t"}, [[<F1>]], [[<C-\><C-n>]]) -- so can be pressed twice for F1
	noremap({"t"}, [[<F2>]], [[<C-\><C-n>]]) -- so can be pressed twice for F2
	noremap({"t"}, [[<F3>]], [[<C-\><C-n>]]) -- so can be pressed twice for F3
	noremap({"t"}, [[<F4>]], [[<C-\><C-n>]]) -- so can be pressed twice for F4
	noremap({"t"}, [[<F5>]], [[<C-\><C-n>]]) -- so can be pressed twice for F5
	noremap({"t"}, [[<F6>]], [[<C-\><C-n>]]) -- so can be pressed twice for F6
	noremap({"t"}, [[<F7>]], [[<C-\><C-n>]]) -- so can be pressed twice for F7
	noremap({"t"}, [[<F8>]], [[<C-\><C-n>]]) -- so can be pressed twice for F8
	noremap({"t"}, [[<F9>]], [[<C-\><C-n>]]) -- so can be pressed twice for F9
	noremap({"t"}, [[<F10>]], [[<C-\><C-n>]]) -- so can be pressed twice for F10
	noremap({"t"}, [[<F11>]], [[<C-\><C-n>]]) -- so can be pressed twice for F11
	noremap({"t"}, [[<F12>]], [[<C-\><C-n>]]) -- so can be pressed twice for F12
	noremap({"t"}, [[<F13>]], [[<C-\><C-n>]]) -- so can be pressed twice for F13
	noremap({"t"}, [[<F14>]], [[<C-\><C-n>]]) -- so can be pressed twice for F14

	-- splits
	noremap({"n"}, [[<C-s>s]], [[:sp<CR>]])
	noremap({"n"}, [[<C-s>v]], [[:vsp<CR>]])
	noremap({"t"}, [[<C-s>s]], [[<C-\><C-n>:sp<CR>]])
	noremap({"t"}, [[<C-s>v]], [[<C-\><C-n>:vsp<CR>]])

	-- navigate splits
	noremap({"n"}, [[<M-h>]], [[<C-w>h]])
	noremap({"n"}, [[<M-j>]], [[<C-w>j]])
	noremap({"n"}, [[<M-k>]], [[<C-w>k]])
	noremap({"n"}, [[<M-l>]], [[<C-w>l]])
	noremap({"t"}, [[<M-h>]], [[<C-\><C-n><C-w>h]])
	noremap({"t"}, [[<M-j>]], [[<C-\><C-n><C-w>j]])
	noremap({"t"}, [[<M-k>]], [[<C-\><C-n><C-w>k]])
	noremap({"t"}, [[<M-l>]], [[<C-\><C-n><C-w>l]])
	noremap({"t"}, [[<M-l>]], [[<C-\><C-n><C-w>l]])

	-- tabs
	noremap({"n"}, [[<C-s>c]], [[:tabnew %<CR>]])
	noremap({"t"}, [[<C-s>c]], [[<C-\><C-n>:tabnew %<CR>]])

	-- navigate tabs
	noremap({"n"}, [[<C-s><C-s>]], [[g<Tab>]]) -- alternate tab
	noremap({"t"}, [[<C-s><C-s>]], [[<C-\><C-n>g<Tab>]])
	noremap({"n"}, [[<C-s>1]], [[:1tabnext<CR>]]) -- go to tab 1
	noremap({"n"}, [[<C-s>2]], [[:2tabnext<CR>]])
	noremap({"n"}, [[<C-s>3]], [[:3tabnext<CR>]])
	noremap({"n"}, [[<C-s>4]], [[:4tabnext<CR>]])
	noremap({"n"}, [[<C-s>5]], [[:5tabnext<CR>]])
	noremap({"n"}, [[<C-s>6]], [[:6tabnext<CR>]])
	noremap({"n"}, [[<C-s>7]], [[:7tabnext<CR>]])
	noremap({"n"}, [[<C-s>8]], [[:8tabnext<CR>]])
	noremap({"n"}, [[<C-s>9]], [[:9tabnext<CR>]])
	noremap({"t"}, [[<C-s>1]], [[<C-\><C-n>:1tabnext<CR>]])
	noremap({"t"}, [[<C-s>2]], [[<C-\><C-n>:2tabnext<CR>]])
	noremap({"t"}, [[<C-s>3]], [[<C-\><C-n>:3tabnext<CR>]])
	noremap({"t"}, [[<C-s>4]], [[<C-\><C-n>:4tabnext<CR>]])
	noremap({"t"}, [[<C-s>5]], [[<C-\><C-n>:5tabnext<CR>]])
	noremap({"t"}, [[<C-s>6]], [[<C-\><C-n>:6tabnext<CR>]])
	noremap({"t"}, [[<C-s>7]], [[<C-\><C-n>:7tabnext<CR>]])
	noremap({"t"}, [[<C-s>8]], [[<C-\><C-n>:8tabnext<CR>]])
	noremap({"t"}, [[<C-s>9]], [[<C-\><C-n>:9tabnext<CR>]])

	-- terminal buffer settings
	vim.cmd([[
		augroup my_terminal
			autocmd!
			autocmd TermOpen * :lua require('plugins-local.tmux-like').setup_terminal()
		augroup END
	]])
end

function M.setup_terminal()
	if not vim.api.nvim_buf_get_option(0, "buftype") == "terminal" then
		return
	end

	vim.cmd.setlocal("nonumber")

	-- pass trough in terminal buffer normal mode
	local current_buffer =  { buffer = 0 }
	--noremap({"n"}, [[<C-d>]], [[i<C-d>]], current_buffer) -- I don't remap <C-d> because of scrolling down in normal mode.
	noremap({"n"}, [[<C-c>]], [[i<C-c>]], current_buffer)
end

return M
