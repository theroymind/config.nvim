return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        ColorMyPencils()
        local lualine = require('lualine')
        local theme = require('lualine.themes.auto')
        lualine.setup {
            options = {
                theme = theme
            },
            sections = {
                lualine_c = { { 'filename', path = 1 } }
            }
        }
    end
}
