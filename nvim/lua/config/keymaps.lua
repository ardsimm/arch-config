vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save / quit
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Navigate splits
map("n", "<C-h>", "<C-w>h", { desc = "Focus left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right split" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper split" })
-- Navigate splits (arrow keys alternative)
map("n", "<C-Left>", "<C-w>h", { desc = "Focus left split" })
map("n", "<C-Right>", "<C-w>l", { desc = "Focus right split" })
map("n", "<C-Down>", "<C-w>j", { desc = "Focus lower split" })
map("n", "<C-Up>", "<C-w>k", { desc = "Focus upper split" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next match centered" })
map("n", "N", "Nzzzv", { desc = "Prev match centered" })

-- Paste without overwriting register
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Splits
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal split" })

-- Open LazyGit
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- Open current file in external PDF viewer
vim.keymap.set("n", "<leader>op", function()
	local file = vim.fn.expand("%:p")
	vim.fn.jobstart({ "zathura", file }, { detach = true })
end, { desc = "Open in PDF viewer" })

-- Open cheatsheet
map("n", "<leader>?", "<cmd>e ~/Documents/neovim_cheatsheet.md<CR>", { desc = "Open cheatsheet" })
