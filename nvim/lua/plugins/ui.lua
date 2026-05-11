return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "material"
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_better_performance = 1
			-- Contrast for light mode: 'soft', 'medium', 'hard'
			vim.g.gruvbox_material_light_background = "hard"
			-- Start in dark mode
			vim.o.background = "dark"
			vim.cmd("colorscheme gruvbox-material")
			-- Toggle dark / light
			vim.keymap.set("n", "<leader>tt", function()
				if vim.o.background == "dark" then
					vim.o.background = "light"
				else
					vim.o.background = "dark"
				end
				vim.cmd("colorscheme gruvbox-material")
                -- Fix vim-visual-multi cursor visibility
                vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "*",
                callback = function()
                    vim.api.nvim_set_hl(0, "VM_Extend",  { bg = "#504945", fg = "#ebdbb2" })
                    vim.api.nvim_set_hl(0, "VM_Cursor",  { bg = "#d79921", fg = "#1d2021" })
                    vim.api.nvim_set_hl(0, "VM_Insert",  { bg = "#689d6a", fg = "#1d2021" })
                    vim.api.nvim_set_hl(0, "VM_Mono",    { bg = "#cc241d", fg = "#ebdbb2" })
                end,
                })
			end, { desc = "Toggle dark/light theme" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox-material",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true, -- single statusline for all splits
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } }, -- relative path
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
