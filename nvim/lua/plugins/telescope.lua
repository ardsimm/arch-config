return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        -- Native FZF sorter, much faster
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>",  desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>",   desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",     desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>",   desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>",    desc = "Recent files" },
      { "<leader>fc", "<cmd>Telescope commands<CR>",    desc = "Commands" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- Ignore these in all pickers
          file_ignore_patterns = {
            "node_modules", ".git/", "dist/", "build/",
            "%.lock", "%.class",
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
          },
          layout_config = {
            horizontal = { preview_width = 0.55 },
          },
        },
        pickers = {
          find_files = {
            hidden = true, -- include dotfiles
          },
        },
      })

      telescope.load_extension("fzf")
    end,
  },
}