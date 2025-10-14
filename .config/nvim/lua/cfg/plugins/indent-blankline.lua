return {
    "lukas-reineke/indent-blankline.nvim",
    tag = "v3.9.0",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
        indent = { char = "┊" },
    },
}
