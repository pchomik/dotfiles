return {
    "hrsh7th/nvim-cmp",
    commit = "b5311ab3ed9c846b585c0c15b7559be131ec4be9",
    event = "InsertEnter",
    dependencies = {
        {
            "hrsh7th/cmp-buffer",
            commit = "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
        }, -- source for text in buffer
        {
            "hrsh7th/cmp-path",
            commit = "c642487086dbd9a93160e1679a1327be111cbc25",
        }, -- source for file system paths
        {
            "L3MON4D3/LuaSnip",
            version = "v2.4.0", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
        },
        {
            "saadparwaiz1/cmp_luasnip",
            commit = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90",
        }, -- for autocompletion
        {
            "rafamadriz/friendly-snippets",
            commit = "572f5660cf05f8cd8834e096d7b4c921ba18e175",
        }, -- useful snippets
        {
            "onsails/lspkind.nvim",
            commit = "3ddd1b4edefa425fda5a9f95a4f25578727c0bb3",
        }, -- vs-code like pictograms
    },
    config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        local lspkind = require("lspkind")

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp"},
                { name = "luasnip" }, -- snippets
                { name = "buffer" }, -- text within current buffer
                { name = "path" }, -- file system paths
            }),

            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
        })
    end,
}
