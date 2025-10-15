return {
  "neovim/nvim-lspconfig",
  tag = "v2.5.0",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "bd5a7d6db125d4654b50eeae9f5217f24bb22fd3",
    },
    { 
      "antosha417/nvim-lsp-file-operations", 
      config = true,
      commit = "9744b738183a5adca0f916527922078a965515ed",
    },
    { 
            "folke/neodev.nvim", 
            opts = {},
            tag = "v3.0.0",
    },
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}
