return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509",
        },
        { 
            "nvim-telescope/telescope-fzf-native.nvim", 
            build = "make",
            commit = "1f08ed60cafc8f6168b72b80be2b2ea149813e55",
        },
        {
            "nvim-tree/nvim-web-devicons",
            commit = "b8221e42cf7287c4dcde81f232f58d7b947c210d",
        },
        {
            "folke/todo-comments.nvim",
            tag = "v1.4.0",
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local transform_mod = require("telescope.actions.mt").transform_mod

        local trouble = require("trouble")
        local trouble_telescope = require("trouble.sources.telescope")

        -- or create your custom action
        local custom_actions = transform_mod({
            open_trouble_qflist = function(prompt_bufnr)
                trouble.toggle("quickfix")
            end,
        })

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
                        ["<C-t>"] = trouble_telescope.open,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    end,
}
