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
			vim.g.gruvbox_material_light_background = "hard"

			-- Helper: apply theme from flag file
			local function apply_theme_from_flag()
				local f = io.open(vim.fn.expand("~/.config/theme/current"), "r")
				if f then
					local mode = f:read("*l"):gsub("%s+", "")
					f:close()
					if mode == "light" or mode == "dark" then
						vim.o.background = mode
						vim.cmd("colorscheme gruvbox-material")
					end
				end
			end

			-- Apply theme on startup (sync with system state)
			apply_theme_from_flag()

			-- Listen for SIGUSR1 sent by toggle.sh to live-reload
			vim.api.nvim_create_autocmd("Signal", {
				pattern = "SIGUSR1",
				callback = apply_theme_from_flag,
			})

			-- Manual toggle keymap
			vim.keymap.set("n", "<leader>tt", function()
				local next = vim.o.background == "dark" and "light" or "dark"
				vim.o.background = next
				vim.cmd("colorscheme gruvbox-material")

				-- Flag sync
				local f = io.open(vim.fn.expand("~/.config/theme/current"), "w")
				if f then
					f:write(next)
					f:close()
				end

				-- Fix vim-visual-multi cursor visibility
				vim.api.nvim_set_hl(0, "VM_Extend", { bg = "#504945", fg = "#ebdbb2" })
				vim.api.nvim_set_hl(0, "VM_Cursor", { bg = "#d79921", fg = "#1d2021" })
				vim.api.nvim_set_hl(0, "VM_Insert", { bg = "#689d6a", fg = "#1d2021" })
				vim.api.nvim_set_hl(0, "VM_Mono", { bg = "#cc241d", fg = "#ebdbb2" })
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
