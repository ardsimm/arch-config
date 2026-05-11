return {
  -- LSP servers installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",        -- Lua
          "clangd",        -- C
          "pyright",       -- Python
          "ts_ls",         -- TypeScript / JavaScript
          "html",          -- HTML
          "cssls",         -- CSS
          "jsonls",        -- JSON
          "jdtls",         -- Java
          "bashls",        -- Bash
        },
        automatic_installation = true,
      })
    end,
  },

-- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps applied when a LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end

          map("gd", vim.lsp.buf.definition,       "Go to definition")
          map("gD", vim.lsp.buf.declaration,      "Go to declaration")
          map("gr", vim.lsp.buf.references,       "References")
          map("gi", vim.lsp.buf.implementation,   "Go to implementation")
          map("K",  vim.lsp.buf.hover,            "Hover documentation")
          map("<leader>rn", vim.lsp.buf.rename,   "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
          map("[d", vim.diagnostic.goto_prev,     "Previous diagnostic")
          map("]d", vim.diagnostic.goto_next,     "Next diagnostic")
        end,
      })

      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- New API: vim.lsp.config + vim.lsp.enable
      local servers = {
        "clangd", "pyright", "ts_ls",
        "html", "cssls", "jsonls",
        "bashls", "jdtls",
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
        vim.lsp.enable(server)
      end

      -- Lua (specific config to recognize vim globals)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")
    end,
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",   -- LSP source
      "hrsh7th/cmp-buffer",     -- buffer words source
      "hrsh7th/cmp-path",       -- filesystem paths source
      "L3MON4D3/LuaSnip",       -- snippet engine
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Non-intrusive: never auto-select, never auto-insert
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = "menu,menuone,noselect",
        },

        mapping = cmp.mapping.preset.insert({
          -- Navigate suggestions
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          -- Confirm selection
          ["<C-y>"] = cmp.mapping.confirm({ select = false }),
          -- Manually trigger completion
          ["<C-Space>"] = cmp.mapping.complete(),
          -- Close without selecting
          ["<C-e>"] = cmp.mapping.abort(),
          -- Scroll docs
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          -- Tab and Enter are completely free
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          { name = "buffer",   priority = 500 },
          { name = "path",     priority = 250 },
        }),
      })
    end,
  },
}