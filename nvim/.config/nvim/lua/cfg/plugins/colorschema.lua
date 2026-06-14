return {
    'olimorris/onedarkpro.nvim',
    tag = "v2.22.0",
    priority = 1000,
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('onedarkpro').setup {
            colors = {
                bg = '#16181d',
                fg = '#c5cad3',
            },
        }
        vim.cmd.colorscheme 'onedark'
    end
}
