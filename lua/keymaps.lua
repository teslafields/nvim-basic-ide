-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = "\\"
vim.o.autochdir = false

-- FZF
vim.g.fzf_action = {
	-- ["ctrl-c"] = "",
	["ctrl-t"] = "tab split",
	["ctrl-i"] = "split",
	["ctrl-v"] = "vsplit",
	["ctrl-j"] = "preview-down",
	["ctrl-k"] = "preview-up",
}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- My personal mappings
--   PageDown/PageUp
keymap("i", "<PageDown>", "<Nop>", opts)
keymap("i", "<PageUp>", "<Nop>", opts)
keymap("n", "b", "<C-b>", opts)
keymap("n", "<Space>", "<C-f>", opts)

-- Close tab
-- keymap("n", "<C-q>", ":tabclose<CR>", opts)

--  Write to file with zz
keymap("n", "zz", ":update<CR>", opts)

-- Copy selected text to clipboard
keymap("v", "<S-c>", "\"+y", opts)

-- Copy the current file path to clipboard
keymap("n", "<Leader>cp", ":let @+=@%<CR>", opts)
-- Copy the current file name to clipboard
keymap("n", "<Leader>cf", ":let @+=expand('%:t')<CR>", opts)

-- Remove trailing white spaces
keymap("n", "<Leader>w", ":let _s=@/ <Bar> :%s/\\s\\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>", opts)
-- Select text and search-replace on it
keymap("v", "<C-s>", "\"hy:%s/<C-r>h//gc<left><left><left>")
-- Search for select text
keymap("v", "//", "y/\\V<C-R>=escape(@\",'/\')<CR><CR>")
-- Don't copy to clipboard when deleting/replacing
keymap("v", "s", '"_s', opts)
keymap("v", "d", '""d', opts)
keymap("v", "x", '"_x', opts)

-- Some tab keymaps
keymap("n", "<C-n>", ":tabnew<CR>", opts)
keymap("n", "<Leader>p", ":tabprevious<CR>", opts)
keymap("n", "<Leader>n", ":tabnext<CR>", opts)
keymap("n", "<C-Tab>", ":tabnext<CR>", opts)

-- Navigate buffers
keymap("n", "<S-Tab>", ":bnext<CR>", opts)

-- ToggleTerm
keymap("n", "<Leader>t", ":ToggleTerm<CR>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<C-PageUp>", ":vertical resize -100<CR>", opts)
keymap("n", "<C-PageDown>", ":vertical resize +100<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", "P", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Better visualization of tabs
keymap("v", "<Leader><Tab><Tab>", ":set invlist<CR>", opts)

-- Plugins --

-- Project
keymap("n", "<leader>bd", ":ProjectRoot<CR>", opts)
keymap("n", "<leader>wd", ":pwd<CR>", opts)
keymap("n", "<leader>cd", ":lcd %:h<CR>", opts)
keymap("n", "<leader>..", ":lcd ..<CR>", opts)

-- NvimTree
keymap("n", "<C-e>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<C-c>", ":NvimTreeFocus<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<C-f>", ":Telescope find_files<CR>", opts)
keymap("n", "<C-b>", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- DAP
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
