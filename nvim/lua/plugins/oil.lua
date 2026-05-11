return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("oil").setup({
				-- Display file icons
				columns = { "icon" },

				keymaps = {
					["<CR>"] = "actions.select", -- open file / enter dir
					["<BS>"] = "actions.parent", -- go to parent directory
					["-"] = "actions.parent", -- alternative
					["_"] = "actions.open_cwd", -- go to cwd
					["gs"] = "actions.change_sort", -- toggle sort
					["<leader>op"] = "actions.open_external", -- open with system app
					["g."] = "actions.toggle_hidden", -- show/hide dotfiles
					["?"] = "actions.show_help", -- help
					["q"] = "actions.close", -- close
				},

				-- Hide these files by default (toggle with g.)
				view_options = {
					show_hidden = false,
					is_hidden_file = function(name, _)
						return vim.startswith(name, ".")
					end,
				},

				-- Open oil in a floating window
				float = {
					padding = 2,
					max_width = 80,
					max_height = 30,
				},
			})

			-- Open oil in current directory
			vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open file explorer" })
			-- Open oil in a floating window
			vim.keymap.set("n", "<leader>E", function()
				require("oil").open_float()
			end, { desc = "Open file explorer (float)" })
		end,
	},
}

