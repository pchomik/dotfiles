return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- Niezbędne zależności
    "MunifTanjim/nui.nvim",
    -- Opcjonalne, ale zalecane dla powiadomień
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      -- Obsługa komunikatów LSP przez noice
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- Konfiguracja widoków (presets)
    presets = {
      bottom_search = true,    -- pasek wyszukiwania (/) na dole (klasycznie)
      command_palette = true,  -- pasek komend (:) i menu na środku (popup)
      long_message_to_split = true, -- długie wiadomości w nowym oknie
      inc_rename = false,      -- wsparcie dla inc-rename.nvim (jeśli używasz)
      lsp_doc_border = true,   -- ramka wokół dokumentacji LSP
    },
    -- Dodatkowe ustawienia UI
    views = {
      cmdline_popup = {
        position = {
          row = "40%", -- ustawienie wysokości na ekranie
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "52%", -- menu podpowiedzi tuż pod paskiem komend
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded", -- zaokrąglone rogi popupu
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
  },
}
