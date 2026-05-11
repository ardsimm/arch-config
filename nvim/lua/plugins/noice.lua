return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- Use noice for LSP progress
          progress = { enabled = true },
          -- Override markdown rendering for hover docs
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,        -- classic bottom search bar
          command_palette = true,      -- cmdline + popupmenu together
          long_message_to_split = true -- long messages go to split
        },
        routes = {
          -- Hide "written" message on save
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
        },
      })

      vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss notifications" })
      vim.keymap.set("n", "<leader>nh", "<cmd>NoiceHistory<CR>", { desc = "Notification history" })
    end,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        timeout = 3000,
        max_width = 60,
        render = "compact",
        stages = "fade",
      })
      vim.notify = require("notify")
    end,
  },
}