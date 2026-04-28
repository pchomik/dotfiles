return {
  "folke/snacks.nvim",
  tag = "v2.31.0",
  priority = 1000,
  lazy = false,
  opts = {
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
