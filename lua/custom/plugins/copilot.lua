return {
  {
    'github/copilot.vim',
    lazy = true,
    event = 'BufRead',
    config = function()
      vim.keymap.set('i', '<C-x>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    {
      'CopilotC-Nvim/CopilotChat.nvim',
      lazy = true,
      dependencies = {
        { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
        { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
      },
      keys = {
        {
          '<leader>ac',
          '<cmd>CopilotChat<cr>',
          mode = { 'n', 'v' },
          desc = 'Open Copilot Chat',
        },
        {
          '<leader>am',
          '<cmd>CopilotChatModels<cr>',
          desc = 'Copilot Chat [M]odels',
        },
        {
          '<leader>ap',
          '<cmd>CopilotChatPrompts<cr>',
          mode = { 'n', 'v' },
          desc = 'Copilot Chat [P]rompts',
        },
      },
      build = 'make tiktoken', -- Only on MacOS or Linux
      opts = {
          show_help = true,
          highlight_headers = true,
          show_folds = true
      },
      -- See Commands section for default commands if you want to lazy load on them
    },
  },
}
