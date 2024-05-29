function ColorMyPencils(color)
    color = color or "tempus_autumn"
    vim.cmd.colorscheme(color)
end

return {
    { "nordtheme/vim" },
    { "diegoulloao/neofusion.nvim",   name = "neofusion", priority = 1000, config = true },
    { "protesilaos/tempus-themes-vim" },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            ColorMyPencils()
            local lualine = require('lualine')
            local theme = require('lualine.themes.auto')
            lualine.setup {
                options = {
                    theme = theme
                }
            }
        end
    },
}
