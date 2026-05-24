local opt = vim.opt

-- ========================= LINE NUMBERS =================================
opt.number         = true
opt.relativenumber = false   -- vim config: off by default

-- F3 toggles relative line numbers
vim.keymap.set("n", "<F3>", function()
    opt.relativenumber = not opt.relativenumber:get()
end, { desc = "Toggle relative numbers" })

-- ========================= INDENTATION ==================================
opt.tabstop     = 4
opt.shiftwidth  = 4
opt.expandtab   = false      -- vim config: real tabs, not spaces
opt.smartindent = true
opt.autoindent  = true       -- vim config
opt.cindent     = true       -- vim config: C-style indentation

-- ========================= DISPLAY ======================================
opt.wrap          = false
opt.scrolloff     = 8
opt.sidescrolloff = 8
opt.signcolumn    = "yes"
opt.colorcolumn   = "80"
opt.cursorline    = true
opt.termguicolors = true
opt.ruler         = true     -- vim config
opt.laststatus    = 2        -- vim config: always show statusbar
opt.textwidth     = 80       -- vim config

-- ========================= SPECIAL CHARS ================================
opt.listchars = { tab = "→ ", space = "·" }
opt.list = true              -- vim config: show tabs and spaces

-- ========================= SEARCH =======================================
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = false
opt.incsearch  = true

-- ========================= BEHAVIOR =====================================
opt.mouse     = "a"
opt.clipboard = "unnamed,unnamedplus"  -- vim config: both * and + registers
opt.splitbelow  = true
opt.splitright  = true
opt.undofile    = true
opt.swapfile    = false
opt.backup      = false
opt.backspace   = { "indent", "eol", "start" }  -- vim config

-- ========================= PERFORMANCE ==================================
opt.updatetime = 250
opt.timeoutlen = 300

-- ========================= CURSOR SHAPE =================================
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- ========================= PATH / AUTOCOMPLETE ==========================
opt.path:append("**")       -- vim config: search in subdirectories
opt.wildmenu = true         -- vim config

-- ========================= BELLS ========================================
opt.errorbells = false
opt.visualbell = false

-- ========================= COLORSCHEME ==================================
vim.cmd.colorscheme("elflord")

vim.api.nvim_set_hl(0, "StatusLine",   { ctermfg = "White", ctermbg = "DarkBlue" })
vim.api.nvim_set_hl(0, "StatusLineNC", { ctermfg = "Gray",  ctermbg = "DarkBlue" })
vim.api.nvim_set_hl(0, "SpecialKey",   { ctermfg = "DarkGray", fg = "DarkGray" })
vim.api.nvim_set_hl(0, "TabLineFill",  { ctermfg = "Gray",     ctermbg = "DarkGray" })
vim.api.nvim_set_hl(0, "TabLine",      { ctermfg = "Cyan",     ctermbg = "DarkGray" })
vim.api.nvim_set_hl(0, "TabLineSel",   { ctermfg = "White",    ctermbg = "DarkBlue" })

vim.g.netrw_winsize      = 18
vim.g.netrw_banner       = 0
vim.g.netrw_liststyle    = 3
vim.g.netrw_browse_split = 4

-- ========================= KEYMAPS ======================================
vim.keymap.set("n", "<C-s>", ":w<CR>",       { desc = "Save (normal mode)" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save (insert mode)" })

-- ========================= AUTOCMDS =====================================
-- Correct commentstring for HTML
vim.api.nvim_create_autocmd("FileType", {
    pattern  = { "html" },
    callback = function()
        vim.bo.commentstring = "<!-- %s -->"
    end,
})

-- Strip trailing whitespace on save for C files
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern  = { "*.c", "*.h" },
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
    desc = "Remove trailing whitespace in C/H files",
})

