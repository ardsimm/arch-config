return {
	-- Auto close pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true, -- use treesitter to check pairs
			})
			-- Integrate with cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Git signs in signcolumn
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
				},
				on_attach = function(buf)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
					end

					map("]g", require("gitsigns").next_hunk, "Next git hunk")
					map("[g", require("gitsigns").prev_hunk, "Prev git hunk")
					map("<leader>gs", require("gitsigns").stage_hunk, "Stage hunk")
					map("<leader>gr", require("gitsigns").reset_hunk, "Reset hunk")
					map("<leader>gp", require("gitsigns").preview_hunk, "Preview hunk")
					map("<leader>gb", require("gitsigns").blame_line, "Blame line")
				end,
			})
		end,
	},

	-- Which-key: show available keymaps
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				delay = 500, -- ms before popup appears
			})

			-- Register key groups
			require("which-key").add({
				{ "<leader>f", group = "Find (Telescope)" },
				{ "<leader>g", group = "Git" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>s", group = "Splits" },
				{ "<leader>t", group = "Toggle" },
			})
		end,
	},

	-- TODO/FIXME/NOTE highlights
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()

			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next TODO" })
			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Prev TODO" })
		end,
	},

	-- Multi-cursor
	{
		"mg979/vim-visual-multi",
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			-- Disable default mappings that conflict
			vim.g.VM_default_mappings = 0
			vim.g.VM_maps = {
				["Find Under"] = "<C-d>", -- select word under cursor (like VSCode Ctrl+D)
				["Find Subword Under"] = "<C-d>",
				["Add Cursor Down"] = "<A-Down>",
				["Add Cursor Up"] = "<A-Up>",
				["Add Cursor At Pos"] = "<A-/>",
			}
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					typescript = { "prettier" },
					javascript = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					json = { "prettier" },
					c = { "c_formatter_42" },
					bash = { "shfmt" },
				},
				-- Custom formatters
				formatters = {
					c_formatter_42 = {
						inherit = false,
						command = "c_formatter_42",
						args = { "$FILENAME" },
					},
				},
			})
		end,
		vim.keymap.set("n", "<leader>cf", function()
			require("conform").format({ async = true })
		end, { desc = "Format file" }),
	},
    {
      "Diogo-ss/42-header.nvim",
      cmd = { "Stdheader" },
      keys = { "<F1>" },
      opts = {
        default_map = true, -- Default mapping <F1> in normal mode.
        auto_update = true, -- Update header when saving.
        user = "smenard", -- Your user.
        mail = "smeanrd@student.42lyon.fr",
    },
      config = function(_, opts)
        require("42header").setup(opts)
      end,
    }
}
