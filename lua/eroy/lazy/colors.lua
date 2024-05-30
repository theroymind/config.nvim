function ColorMyPencils(color)
    color = color or "tempus_autumn"
    vim.cmd.colorscheme(color)

    if color == "tempus_autumn" then
        -- Set specific Telescope highlights for tempus_autumn theme
        vim.cmd [[
            highlight TelescopeSelection cterm=bold ctermbg=none ctermfg=yellow guibg=#3A464C guifg=yellow
            highlight TelescopeSelectionCaret cterm=bold ctermbg=none ctermfg=red guibg=none guifg=red
        ]]
    else
        -- Clear custom Telescope highlights to use the defaults
        vim.cmd [[
            highlight clear TelescopeSelection
            highlight clear TelescopeSelectionCaret
            highlight clear TelescopeMultiSelection
            highlight clear TelescopeMatching
        ]]
    end
end

return {
    { "nordtheme/vim" },
    { "diegoulloao/neofusion.nvim", name = "neofusion", priority = 1000, config = true },
    { "protesilaos/tempus-themes-vim" },
}
