return {
  "folke/which-key.nvim",
  tag = "v3.17.0",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
    -- Set C-p directly to override any explorer-specific mappings
    vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "File switching" })
  end,
  opts = {
    spec = {
      -- Close (c)
      { "<leader>c", group = "Close..." },
      { "<leader>cc", "<cmd>close<CR>", desc = "Close current file" },
      { "<leader>ca", "<cmd>bd<CR>", desc = "Close all files" },

      -- File Explorer (e)
      { "<leader>e", group = "File Explorer..." },
      { "<leader>ee", function() Snacks.explorer() end, desc = "Show File Explorer" },
      { "<leader>ec", function() Snacks.explorer() end, desc = "Collapse Explorer" },
      { "<leader>en", "<cmd>enew<CR>", desc = "New File" },
      { "<leader>er", function() Snacks.explorer({ reveal = true }) end, desc = "Reveal file in Explorer" },
      { "<leader>es", function() Snacks.explorer() end, desc = "Focus file Explorer" },

      -- File Operations (f)
      { "<leader>f", group = "File operations..." },
      { "<leader>fa", function()
          local path = vim.fn.expand("%:p")
          vim.fn.setreg("+", path)
          vim.notify("Copied absolute path: " .. path, vim.log.levels.INFO)
        end, desc = "Copy absolute file path" },
      { "<leader>fr", function()
          local path = vim.fn.expand("%:.")
          vim.fn.setreg("+", path)
          vim.notify("Copied relative path: " .. path, vim.log.levels.INFO)
        end, desc = "Copy relative file path" },
      { "<leader>ff", "<cmd>Telescope live_grep<CR>", desc = "Find strings in project" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },

      -- Editing (E)
      { "<leader>E", group = "Editing..." },
      { "<C-c>", "ygv", desc = "Copy selection", mode = "v" },
      { "<C-c>", "<C-o>yy", desc = "Copy line", mode = "i" },
      { "<C-v>", "\\\"_dgP", desc = "Paste", mode = "v" },
      { "<C-v>", "<C-r>=paste_check()<CR>", desc = "Paste", mode = "i" },
      { "<C-x>", "<C-o>dd", desc = "Cut line", mode = "i" },
      { "<C-x>", "di", desc = "Cut selection", mode = "v" },
      { "<C-S-d>", "<C-o>yy<C-o>p", desc = "Duplicate line", mode = "i" },
      { "<C-S-k>", "<C-o>\\\"_dd", desc = "Delete line", mode = "i" },
      { "<Tab>", ">gv", desc = "Indent selection", mode = "v" },
      { "<S-Tab>", "<gv", desc = "Unindent selection", mode = "v" },

      -- Window Management (w)
      { "<leader>w", group = "Window Management..." },
      { "<leader>we", "<C-w>=", desc = "Make splits equal size" },
      { "<leader>wx", "<cmd>close<CR>", desc = "Close current split" },
      { "<leader>w-", "<cmd>split<CR>", desc = "Split Down" },
      { "<leader>w|", "<cmd>vsplit<CR>", desc = "Split Right" },
      { "<leader>w<left>", "<C-w>h", desc = "Change to left split" },
      { "<leader>w<down>", "<C-w>j", desc = "Change to down split" },
      { "<leader>w<up>", "<C-w>k", desc = "Change to up split" },
      { "<leader>w<right>", "<C-w>l", desc = "Change to right split" },

      -- Git (g)
      { "<leader>g", group = "Git..." },
      { "<leader>ga", function() Snacks.lazygit.open() end, desc = "Open LazyGit" },
      { "<leader>gd", function() Snacks.lazygit.open() end, desc = "Open LazyGit" },
      { "<leader>gg", function() Snacks.lazygit.open() end, desc = "Show git" },
      { "<leader>gs", function() Snacks.lazygit.open() end, desc = "Sync" },
      { "<leader>gp", function() Snacks.lazygit.open() end, desc = "Push" },

      -- Open (o)
      { "<leader>o", group = "Open..." },
      { "<leader>oo", "<cmd>e<CR>", desc = "Open" },
      { "<leader>or", function() Snacks.picker.recent() end, desc = "Open recent" },
      { "<leader>op", function()
          vim.cmd("cd ~/repos")
          Snacks.picker.files()
        end, desc = "Open project" },

      -- Split/Symbol (s)
      { "<leader>s", group = "Symbols..." },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Go to symbol in file" },
      { "<leader>sw", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Go to symbol in workspace" },

      -- Tab Management (t)
      { "<leader>t", group = "Tab Management..." },
      { "<leader>to", "<cmd>tabnew<CR>", desc = "Open new tab" },
      { "<leader>tx", "<cmd>tabclose<CR>", desc = "Close current tab" },
      { "<leader>tn", "<cmd>tabn<CR>", desc = "Go to next tab" },
      { "<leader>tp", "<cmd>tabp<CR>", desc = "Go to previous tab" },
      { "<leader>tf", "<cmd>tabnew %<CR>", desc = "Open current buffer in new tab" },

      -- Problem Navigation
      { "[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous problem in the file" },
      { "]", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next problem in the file" },

      -- Format & Lint (F, l)
      { "<leader>F", function()
          require("conform").format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          })
        end, desc = "Format file or range", mode = { "n", "v" } },
      { "<leader>l", function()
          require("lint").try_lint()
        end, desc = "Trigger linting for current file" },

      -- LSP (g*, leader ca/rn/D/d)
      { "gR", vim.lsp.buf.references, desc = "Show LSP references" },
      { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
      { "gd", vim.lsp.buf.definition, desc = "Show LSP definitions" },
      { "gb", "<C-o>", desc = "Go back to previous location" },
      { "gi", vim.lsp.buf.implementation, desc = "Show LSP implementations" },
      { "gt", vim.lsp.buf.type_definition, desc = "Show LSP type definitions" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "See available code actions", mode = { "n", "v" } },
      { "<leader>rn", vim.lsp.buf.rename, desc = "Smart rename" },
      { "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Show buffer diagnostics" },
      { "<leader>d", vim.diagnostic.open_float, desc = "Show line diagnostics" },
      { "[d", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
      { "]d", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
      { "K", vim.lsp.buf.hover, desc = "Show documentation for what is under cursor" },
      { "<leader>rs", ":LspRestart<CR>", desc = "Restart LSP" },

      -- Todo Comments ([t, ]t)
      { "]t", function()
          require("todo-comments").jump_next()
        end, desc = "Next todo comment" },
      { "[t", function()
          require("todo-comments").jump_prev()
        end, desc = "Previous todo comment" },

      -- Movement keybindings (direct)
      { "<A-down>", ":m+<CR>==", desc = "Move line down", mode = "n" },
      { "<A-down>", "<Esc>:m+<CR>==gi", desc = "Move line down", mode = "i" },
      { "<A-down>", ":m'>+<CR>gv=gv", desc = "Move line down", mode = "v" },
      { "<A-up>", ":m-2<CR>==", desc = "Move line up", mode = "n" },
      { "<A-up>", "<Esc>:m-2<CR>==gi", desc = "Move line up", mode = "i" },
      { "<A-up>", ":m-2<CR>gv=gv", desc = "Move line up", mode = "v" },
      { "<C-right>", "e", desc = "Move word forward", mode = "n" },
      { "<C-right>", "<C-o>:call jump_word_e()<CR>", desc = "Move word forward", mode = "i" },
      { "<C-left>", "b", desc = "Move word backward", mode = "n" },
      { "<C-left>", "<C-o>:call jump_word_b()<CR>", desc = "Move word backward", mode = "i" },

      -- Additional bindings
      { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "File switching" },
      { "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Find in current file" },
      { "<C-Space><left>", "<C-w>h", desc = "Change to panel left" },
      { "<C-Space><right>", "<C-w>l", desc = "Change to panel right" },
      { "<C-Space><up>", "<C-w>k", desc = "Change to panel up" },
      { "<C-Space><down>", "<C-w>j", desc = "Change to panel down" },

      -- Miscellaneous (z)
      { "<leader>z", group = "Miscellaneous..." },
      { "<leader>zh", ":nohl<CR>", desc = "Clear search highlights" },
      { "<leader>z+", "<C-a>", desc = "Increment number" },
      { "<leader>z-", "<C-x>", desc = "Decrement number" },

      -- Snacks
      { "<leader>zn", function() Snacks.notifier.show_history() end, desc = "Notification history" },
      { "<leader>zt", function() Snacks.terminal() end, desc = "Toggle terminal" },
      { "<leader>zz", function() Snacks.zen() end, desc = "Zen mode" },
      { "<leader>zb", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>di", function() Snacks.indent() end, desc = "Toggle indent guides" },
      { "<leader>gl", function() Snacks.lazygit.open() end, desc = "LazyGit" },
    },
  },
}
