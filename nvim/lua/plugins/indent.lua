return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",       -- vertical line character
          tab_char = "│",
        },
        scope = {
          enabled = true,   -- highlight current scope
          show_start = false,
          show_end = false,
        },
        exclude = {
          filetypes = {
            "help", "dashboard", "lazy", "mason",
            "notify", "oil", "trouble",
          },
        },
      })
    end,
  },
}