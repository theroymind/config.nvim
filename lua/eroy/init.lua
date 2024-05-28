require("eroy.set")
require("eroy.remap")
require("eroy.lazy_init")


local augroup = vim.api.nvim_create_augroup
local GeneralGroup = augroup('General', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})
vim.opt.clipboard = 'unnamedplus'

-- automatically read latest files from disk when entering buffer
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    command = "checktime",
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 100,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = GeneralGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        -- Callbacks to do once all lazy vim setup is done and plugins are loaded
        ColorMyPencils()
        require("nvim-tree.api").tree.open()
        vim.cmd("wincmd p")
    end
})

autocmd('LspAttach', {
    group = GeneralGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})
