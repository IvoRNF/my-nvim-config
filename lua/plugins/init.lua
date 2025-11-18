return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function() -- Mapping tab is already used in NvChad
      vim.g.copilot_no_tab_map = true -- Disable tab mapping
      vim.g.copilot_assume_mapped = true -- Assume that the mapping is already done
    end,
  }, -- These are some examples, uncomment them if you want to see them work!
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   ft = { "javascript" },
  --   opts = {
  --
  --     servers = {
  --       vtsls = {
  --         settings = {
  --           typescript = {
  --             tsserver = {
  --               maxTsServerMemory = 8192,
  --             },
  --           },
  --         },
  --       },
  --     },
  --   }, -- Configure as needed
  -- },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "scss",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-angular",
    ft = { "html" },
  },
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- vim.keymap.set("n", "<leader>l", function()
      --   lint.try_lint()
      -- end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- Format before saving the buffer
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 3000,
          lsp_fallback = true,
        },
      }
    end,
  },
}
