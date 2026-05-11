local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true      --q tabs -> spaces
opt.smartindent = true

-- Display
opt.wrap = false           -- no soft wrap
opt.scrolloff = 8          -- keep 8 lines of context when scrolling
opt.sidescrolloff = 8
opt.signcolumn = "yes"     -- always show sign column (LSP, git...)
opt.colorcolumn = "80"     -- vertical ruler at 80 chars
opt.cursorline = true      -- highlight current line
opt.termguicolors = true   -- 24-bit colors

-- Search
opt.ignorecase = true      -- case-insensitive search...
opt.smartcase = true       -- ...unless uppercase is used
opt.hlsearch = false       -- no persistent highlight after search
opt.incsearch = true       -- live highlight while typing

-- Behavior
opt.mouse = "a"            -- enable mouse everywhere
opt.clipboard = "unnamedplus"  -- sync with system clipboard
opt.splitbelow = true      -- horizontal split goes below
opt.splitright = true      -- vertical split goes right
opt.undofile = true        -- persistent undo history across sessions
opt.swapfile = false       -- no swap file
opt.backup = false

-- Performance
opt.updatetime = 250       -- delay before CursorHold triggers (LSP)
opt.timeoutlen = 300       -- delay for key sequences

-- Cursor shape: block in normal, beam in insert
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Set correct commentstring for HTML files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html" },
  callback = function()
    vim.bo.commentstring = "<!-- %s -->"
  end,
})