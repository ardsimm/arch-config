return {
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.10.0",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"c",
					"python",
					"typescript",
					"javascript",
					"tsx",
					"html",
					"css",
					"json",
					"java",
					"bash",
					"markdown",
					"markdown_inline",
					"yaml",
					"toml",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
