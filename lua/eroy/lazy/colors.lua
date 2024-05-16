function ColorMyPencils(color)
	color = color or "nord"
	vim.cmd.colorscheme(color)
end

return {
    {
        "nordtheme/vim",
        name = "nord",
        config = function()
            vim.cmd("colorscheme nord")

            ColorMyPencils()
        end
    },


}
