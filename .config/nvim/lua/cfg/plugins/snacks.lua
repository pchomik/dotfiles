return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = {
      replace_netrw = true,
    },
    picker = {
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["<C-p>"] = false,
              },
            },
            input = {
              keys = {
                ["<C-p>"] = false,
              },
            },
          },
        },
      },
    },
    dashboard = { enabled = true },
    bufdelete = { enable = true },
    indent = { enabled = true },
    notifier = { enabled = true },
    terminal = { enabled = true },
    bigfile = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
    lazygit = {
      configure = true,
      win = {
        style = "lazygit",
      },
    },
  },
}
