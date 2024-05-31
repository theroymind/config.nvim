local openai_api_key = vim.fn.getenv("OPENAI_API_KEY")

if openai_api_key == "" then
    return {}
end

return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    },
    --[[
<C-Enter> [Both] to submit.
<C-y> [Both] to copy/yank last answer.
<C-o> [Both] Toggle settings window.
<C-h> [Both] Toggle help window.
<Tab> [Both] Cycle over windows.
<C-f> [Chat] Cycle over modes (center, stick to right).
<C-c> [Both] to close chat window.
<C-p> [Chat] Toggle sessions list.
<C-u> [Chat] scroll up chat window.
<C-d> [Chat] scroll down chat window.
<C-k> [Chat] to copy/yank code from last answer.
<C-n> [Chat] Start new session.
<C-r> [Chat] draft message (create message without submitting it to server)
<C-r> [Chat] switch role (switch between user and assistant role to define a workflow)
<C-s> [Both] Toggle system message window.
<C-i> [Edit Window] use response as input.
<C-d> [Edit Window] view the diff between left and right panes and use diff-mode commands
    ]] --
    config = function()
        require("chatgpt").setup({
            openai_params = {
                model = "gpt-4o",
                max_tokens = 4096
            },
            edit_with_instructions = {
                keymaps = {
                    accept = "<C-y>",
                    toggle_diff = "<C-d>",
                    toggle_settings = "<C-o>",
                    toggle_help = "<C-h>",
                    cycle_windows = "<Tab>",
                    use_output_as_input = "<C-i>",
                }
            },
            chat = {
                keymaps = {
                    yank_last = "<C-y>",
                    yank_last_code = "<C-k>",
                    scroll_up = "<C-u>",
                    scroll_down = "<C-d>",
                    new_session = "<C-n>",
                    cycle_windows = "<Tab>",
                    cycle_modes = "<C-f>",
                    next_message = "<C-j>",
                    prev_message = "<C-k>",
                    select_session = "<Space>",
                    rename_session = "r",
                    delete_session = "d",
                    draft_message = "<C-r>",
                    edit_message = "e",
                    delete_message = "d",
                    toggle_settings = "<C-o>",
                    toggle_sessions = "<C-p>",
                    toggle_help = "<C-h>",
                    toggle_message_role = "<C-r>",
                    toggle_system_role_open = "<C-s>",
                    stop_generating = "<C-x>",
                }
            },
        })

        -- Define key mappings
        local keymap = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        -- Normal mode mappings
        keymap('n', '<leader>cc', '<cmd>ChatGPT<CR>', opts)
        --[[
        keymap('n', '<leader>ce', '<cmd>ChatGPTEditWithInstruction<CR>', opts)
        keymap('n', '<leader>cg', '<cmd>ChatGPTRun grammar_correction<CR>', opts)
        keymap('n', '<leader>ct', '<cmd>ChatGPTRun translate<CR>', opts)
        keymap('n', '<leader>ck', '<cmd>ChatGPTRun keywords<CR>', opts)
        keymap('n', '<leader>cd', '<cmd>ChatGPTRun docstring<CR>', opts)
        keymap('n', '<leader>ca', '<cmd>ChatGPTRun add_tests<CR>', opts)
        keymap('n', '<leader>co', '<cmd>ChatGPTRun optimize_code<CR>', opts)
        keymap('n', '<leader>cs', '<cmd>ChatGPTRun summarize<CR>', opts)
        keymap('n', '<leader>cf', '<cmd>ChatGPTRun fix_bugs<CR>', opts)
        keymap('n', '<leader>cx', '<cmd>ChatGPTRun explain_code<CR>', opts)
        keymap('n', '<leader>cr', '<cmd>ChatGPTRun roxygen_edit<CR>', opts)
        keymap('n', '<leader>cl', '<cmd>ChatGPTRun code_readability_analysis<CR>', opts)

        -- Visual mode mappings
        keymap('v', '<leader>ce', '<cmd>ChatGPTEditWithInstruction<CR>', opts)
        keymap('v', '<leader>cg', '<cmd>ChatGPTRun grammar_correction<CR>', opts)
        keymap('v', '<leader>ct', '<cmd>ChatGPTRun translate<CR>', opts)
        keymap('v', '<leader>ck', '<cmd>ChatGPTRun keywords<CR>', opts)
        keymap('v', '<leader>cd', '<cmd>ChatGPTRun docstring<CR>', opts)
        keymap('v', '<leader>ca', '<cmd>ChatGPTRun add_tests<CR>', opts)
        keymap('v', '<leader>co', '<cmd>ChatGPTRun optimize_code<CR>', opts)
        keymap('v', '<leader>cs', '<cmd>ChatGPTRun summarize<CR>', opts)
        keymap('v', '<leader>cf', '<cmd>ChatGPTRun fix_bugs<CR>', opts)
        keymap('v', '<leader>cx', '<cmd>ChatGPTRun explain_code<CR>', opts)
        keymap('v', '<leader>cr', '<cmd>ChatGPTRun roxygen_edit<CR>', opts)
        keymap('v', '<leader>cl', '<cmd>ChatGPTRun code_readability_analysis<CR>', opts)
        ]]
           --
    end,
}
