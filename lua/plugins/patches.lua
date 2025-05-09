-- A collection of fixes and patches for various plugins

return {
  {
    'folke/noice.nvim',
    opts = {
      routes = {
        -- { -- Hide error spam every time autocomplete is triggered
        --   filter = {
        --     error = true,
        --     find = '.*blink.cmp.*reactive.nvim.*',
        --   },
        --   opts = {
        --     skip = true,
        --   },
        -- },
        { -- Hide error when toggling gitlab.nvim discussion
          filter = {
            error = true,
            find = 'gitlab.nvim: Could not find Diffview view',
          },
          opts = {
            skip = true,
          },
        },
      },
    },
    {
      'nvim-lualine/lualine.nvim',
      opts = function(_, opts)
        -- Copilot has breaking change for getting status
        -- https://github.com/LazyVim/LazyVim/pull/5900
        table.remove(opts.sections.lualine_x, 2)
      end,
    },
  },
}
