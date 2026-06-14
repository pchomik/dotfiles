return {
    "folke/todo-comments.nvim",
    tag = "v1.4.0",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 
        {
            "nvim-lua/plenary.nvim",
            commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509",
        }, 
    },
    config = function()
        local todo_comments = require("todo-comments")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Next todo comment" })

        keymap.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Previous todo comment" })

        todo_comments.setup()
    end,
}
