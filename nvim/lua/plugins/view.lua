return {
  -- Markdown renderer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        heading = {
          enabled = true,
          sign = true,
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        },
        code = {
          enabled = true,
          sign = true,
          style = "full",
          border = "thin",
        },
        bullet = {
          enabled = true,
          icons = { "●", "○", "◆", "◇" },
        },
        checkbox = {
          enabled = true,
          unchecked = { icon = "󰄱 " },
          checked   = { icon = "󰱒 " },
        },
      })

      vim.keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })
    end,
  },

  -- Image viewer (requires kitty)
  {
    "3rd/image.nvim",
    ft = { "markdown", "png", "jpg", "jpeg", "gif", "webp" },
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            -- Show images inline in markdown files
            download_remote_images = true,
          },
        },
        max_width = 80,
        max_height = 20,
        max_height_window_percentage = 40,
        window_overlap_clear_enabled = true,
      })
    end,
  },
}