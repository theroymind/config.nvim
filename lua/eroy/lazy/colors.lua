function ColorMyPencils(color)
    color = color or "tempus_autumn"
    vim.cmd.colorscheme(color)
end

return {
    { "nordtheme/vim" },
    { "diegoulloao/neofusion.nvim",   name = "neofusion", priority = 1000, config = true },
    { "protesilaos/tempus-themes-vim" },
}
