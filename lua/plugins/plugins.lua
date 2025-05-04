return {
  {
    'folke/snacks.nvim',
    keys = {
      { '<leader>e', false },
      { '<leader>E', false },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = 'Recent (cwd)',
      },
      { '<leader>fR', LazyVim.pick('oldfiles'), desc = 'Recent' },
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
        sources = {
          help = {
            win = {
              input = {
                keys = {
                  ['<CR>'] = { 'tab', mode = { 'n', 'i' } },
                },
              },
            },
          },
        },
      },
      scratch = {
        filekey = {
          branch = false,
        },
      },
      words = {
        enabled = false,
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- Copied from LazyVim source to change mappings
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
      vim.keymap.set({ 'n', 'x' }, 's', '<Plug>(leap)')
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')

      -- Grey out background in Catppuccin
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'NonText' })

      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group.
      leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
      leap.opts.safe_labels = 'hmnutqflz/SFNLHMUGTQ?Z'
    end,
  },
  {
    'echasnovski/mini.files',
    keys = {
      {
        '<leader>e',
        function()
          local mf = require('mini.files')
          if not mf.close() then
            mf.open(vim.api.nvim_buf_get_name(0), true)
          end
        end,
        desc = 'Open mini.files (Directory of Current File)',
      },
      {
        '<leader>E',
        function()
          local mf = require('mini.files')
          if not mf.close() then
            mf.open(vim.uv.cwd(), true)
          end
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
    'echasnovski/mini.surround',
    opts = {
      mappings = {
        add = 'ma', -- Add surrounding in Normal and Visual modes
        delete = 'md', -- Delete surrounding
        find = 'mf', -- Find surrounding (to the right)
        find_left = 'mF', -- Find surrounding (to the left)
        highlight = 'mh', -- Highlight surrounding
        replace = 'mr', -- Replace surrounding
        update_n_lines = 'mn', -- Update `n_lines`
      },
    },
  },
  {
    'echasnovski/mini.operators',
    lazy = false,
    version = '*',
    opts = {
      -- Evaluate text and replace with output
      evaluate = {
        prefix = 'mo=',
      },

      -- Exchange text regions
      exchange = {
        prefix = 'mox',
      },

      -- Multiply (duplicate) text
      multiply = {
        prefix = 'mom',
      },

      -- Replace text with register
      replace = {
        prefix = 'mor',
      },

      -- Sort text
      sort = {
        prefix = 'mos',
      },
    },
    keys = {
      { 'mo', '', mode = { 'n', 'x' }, desc = '+operators' },
    },
  },
  {
    'echasnovski/mini.bracketed',
    version = false,
    opts = {
      buffer = { suffix = 'b' },
      comment = { suffix = '' },
      conflict = { suffix = 'x' },
      diagnostic = { suffix = 'd' },
      file = { suffix = '' },
      indent = { suffix = '' },
      jump = { suffix = '' },
      location = { suffix = '' },
      oldfile = { suffix = '' },
      quickfix = { suffix = '' },
      treesitter = { suffix = '' },
      undo = { suffix = '' },
      window = { suffix = '' },
      yank = { suffix = '' },
    },
  },
  {
    'echasnovski/mini.ai',
    opts = {
      custom_textobjects = {
        -- JSX attributes
        j = {
          {
            { '[%S^]%s+%w+=%b{}', '^.()%s+%w+={().*()}()' },
          },
        },
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

      vim.keymap.set('n', '<leader>tc', function()
        tsc.go_to_context(vim.v.count1)
      end, { silent = true, desc = 'Go up Treesitter Code Context' })

      return { mode = 'cursor', max_lines = 3 }
    end,
  },
  {
    'folke/which-key.nvim',
    url = 'https://github.com/NextMerge/which-key.nvim.git',
    opts = {
      delay = 0,
      keys = {
        scroll_down = '<PageDown>',
        scroll_up = '<PageUp>',
      },
      spec = {
        {
          mode = { 'n', 'x' },
          { '<leader>t', group = '+tab/treesitter' },
          { '<leader>h', group = '+gitsigns' },
          { 'm', group = '+mini' },
        },
        {
          mode = 'n',
          { '<leader>y', group = '+yank' },
        },
        {
          mode = 'x',
          { '<leader>d', 'Delete without writing to the copy register' },
        },
      },
    },
    triggers = {
      { '<auto>', mode = 'nixsotc' },
      { 'm', mode = { 'n', 'x' } },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    opts = {
      mappings = {
        close = {
          insert = '<Esc>',
        },
      },
      model = 'claude-3.7-sonnet',
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = function(_, opts)
      local currentSymbolIndex = 5
      table.remove(opts.sections.lualine_c, currentSymbolIndex)

      opts.sections.lualine_z = { 'grapple' }
    end,
  },
  {
    'folke/noice.nvim',
    opts = {
      routes = {
        { -- Prevent say, the tailwind LSP from spamming this when you hover a TypeScript file
          filter = {
            event = 'notify',
            find = 'No information available',
          },
          opts = {
            skip = true,
          },
        },
      },
    },
  },
  {
    'saghen/blink.cmp',
    opts = {
      completion = {
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    keys = {
      {
        '<C-s>',
        function()
          vim.api.nvim_exec_autocmds('User', { pattern = 'ConformStart' })
          LazyVim.format({ force = true })
        end,
        mode = { 'n', 'v' },
        desc = 'Format Injected Langs',
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    enabled = false,
  },
  {
    'folke/todo-comments.nvim',
    enabled = false,
  },

  -- New plugins

  { -- Autosave
    'okuuva/auto-save.nvim',
    cmd = 'ASToggle', -- optional for lazy loading on command
    event = { 'InsertLeave', 'TextChanged' }, -- optional for lazy loading on trigger events
    opts = {
      trigger_events = {
        cancel_deferred_save = { 'InsertEnter', { 'User', pattern = 'ConformStart' } },
      },
    },
  },
  { -- Line highlighting depending on current mode
    'rasulomaroff/reactive.nvim',
    event = 'VeryLazy',
    opts = {
      load = { 'catppuccin-mocha-cursor', 'catppuccin-mocha-cursorline' },
    },
  },
  { -- File bookmark
    'cbochs/grapple.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    event = 'LazyFile',
    cmd = 'Grapple',
    opts = {
      scope = 'cwd',
      quick_select = 'htnsHTNS',
    },
    keys = {
      { '<C-m>', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
      { "'", '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    },
  },
  {
    'harrisoncramer/gitlab.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'stevearc/dressing.nvim', -- Recommended but not required. Better UI for pickers.
      'nvim-tree/nvim-web-devicons', -- Recommended but not required. Icons in discussion tree.
    },
    build = function()
      require('gitlab.server').build(true)
    end, -- Builds the Go binary
    opts = {
      config_path = vim.fn.expand('~') .. '/.config/nvim',
      discussion_tree = {
        draft_mode = true,
      },
    },
  },
}
