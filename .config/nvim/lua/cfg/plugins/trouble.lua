return {
    "folke/trouble.nvim",
    tag = "v3.7.1",
    dependencies = { 
        {
            "nvim-tree/nvim-web-devicons", 
            commit = "b8221e42cf7287c4dcde81f232f58d7b947c210d",
        },
        {
            "folke/todo-comments.nvim",
            tag = "v1.4.0",
        }
    },
    opts = {
        focus = true,
    },
    cmd = "Trouble",
    keys = {
        { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
        { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
        { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
    },
}
