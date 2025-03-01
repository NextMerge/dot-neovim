return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = function()
      local tsc = require('treesitter-context')
      Snacks.toggle({
        name = 'Treesitter Context',
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map('<leader>ut')

      vim.keymap.set('n', '<leader>cu', function()
        tsc.go_to_context(vim.v.count1)
      end, { silent = true, desc = 'Go [U]p Treesitter Context' })

      return { mode = 'cursor', max_lines = 3 }
    end,
  },
}
