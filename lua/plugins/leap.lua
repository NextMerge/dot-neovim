return {
  {
    'ggandor/leap.nvim',
    config = function(_, opts)
      local leap = require('leap')
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')

      -- Grey out background in Catppuccin
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'NonText' })

      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group.
      leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
      leap.opts.safe_labels = 'hmnutqfl/SFNLHMUGTQ?'
    end,
  },
}
