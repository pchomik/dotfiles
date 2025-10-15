return {
  "williamboman/mason.nvim",
  tag = "v2.1.0",
  dependencies = {
    {
            "williamboman/mason-lspconfig.nvim",
            tag = "v2.1.0",
    },
    {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            commit = "517ef5994ef9d6b738322664d5fdd948f0fdeb46",
    },
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- The on_attach function is called for every LSP server that attaches to a buffer
    local on_attach = function(client, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper functions to reduce the verbosity of your keymaps.
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
      end

      -- Add your keymaps here, if you want them to be set only for buffers with an active LSP
    end

    -- get the capabilities for cmp-nvim-lsp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Define server-specific settings
    local servers = {
      ruff_lsp = {},
      pyright = {
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              ignore = { "*" },
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      },
    }

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        "gopls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
        "ruff_lsp",
      },
      -- The handler that will be called for each server
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name] and servers[server_name].settings or {},
          })
        end,
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d",
        "isort",
        "black",
        "ruff"
      },
    })
  end,
}
