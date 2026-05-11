return {
  {
    "folke/flash.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("flash").setup({
        modes = {
          -- Enhance default f/t/F/T motions with flash labels
          char = {
            enabled = true,
          },
          -- Flash search integration
          search = {
            enabled = true,
          },
        },
      })

      vim.keymap.set({ "n", "x", "o" }, "s",     function() require("flash").jump() end,              { desc = "Flash jump" })
      vim.keymap.set({ "n", "x", "o" }, "S",     function() require("flash").treesitter() end,        { desc = "Flash treesitter" })
      vim.keymap.set("n",               "<leader>tf", function() require("flash").toggle() end,       { desc = "Toggle flash search" })
    end,
  },
}