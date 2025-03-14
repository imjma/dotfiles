return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          local telescope = require("telescope")
          telescope.load_extension('fzf')
        end
      }
    },

    config = function()
      local telescope = require("telescope")
      telescope.setup()

      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
      vim.keymap.set('n', '<leader>/', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>')
      -- vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
    end
  }
}
