return {
  {
    'folke/snacks.nvim',
    keys = {
      { '<leader>e', false },
      { '<leader>E', false },
      {
        '<leader>fR',
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = 'Recent (cwd)',
      },
      { '<leader>fr', LazyVim.pick('oldfiles'), desc = 'Recent' },
    },
    opts = {
      dashboard = {
        preset = {
          keys = {
            { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            {
              icon = ' ',
              key = 'r',
              desc = 'Recent Files',
              action = ":lua Snacks.dashboard.pick('oldfiles', { filter = { cwd = true } })",
            },
            {
              icon = ' ',
              key = 'c',
              desc = 'Config',
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
            { icon = ' ', key = 'x', desc = 'Lazy Extras', action = ':LazyExtras' },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
      },
      picker = {
        win = {
          input = {
            keys = {
              ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
              ['<C-c>'] = 'cancel',
            },
          },
        },
      },
      scratch = {
        filekey = {
          branch = false,
        },
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>hp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>hB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>hd", gs.diffthis, "Diff This")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
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
  {
    'echasnovski/mini.files',
    keys = {
      {
        '<leader>e',
        function()
          require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = 'Open mini.files (Directory of Current File)',
      },
      {
        '<leader>E',
        function()
          require('mini.files').open(vim.uv.cwd(), true)
        end,
        desc = 'Open mini.files (cwd)',
      },
    },
    opts = {
      mappings = {
        go_in_plus = '<CR>',
        go_out_plus = '<BS>',
        mark_goto = '',
        mark_set = '',
        reset = '<Del>',
      },
    },
  },
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
  {
    'folke/which-key.nvim',
    opts = {
      delay = 0,
    },
  },
}
