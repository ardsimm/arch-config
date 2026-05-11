return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          show_buffer_close_icons = true,
          show_close_icon = false,
          color_icons = true,
          diagnostics = "nvim_lsp",  -- show LSP diagnostics in tabs
          diagnostics_indicator = function(_, _, diag)
            local icons = { error = " ", warning = " ", info = " " }
            local ret = {}
            for severity, icon in pairs(icons) do
              if diag[severity] and diag[severity] > 0 then
                table.insert(ret, icon .. diag[severity])
              end
            end
            return table.concat(ret, " ")
          end,
          offsets = {
            {
              filetype = "oil",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })

      -- Navigate buffers
      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
      vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>",        { desc = "Close buffer" })
      vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin buffer" })
    end,
  },
}