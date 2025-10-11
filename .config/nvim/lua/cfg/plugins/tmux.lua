return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  keys = {
    { "c-s-<Left>",  "<cmd><C-U>TmuxNavigateLeft<cr>"  },
    { "c-s-<Down>",  "<cmd><C-U>TmuxNavigateDown<cr>"  },
    { "c-s-<Up>",    "<cmd><C-U>TmuxNavigateUp<cr>"    },
    { "c-s-<Right>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  },
}
