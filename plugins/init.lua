return {
  --github theme
  -- { "projekt0n/github-nvim-theme" },
  -- nightfox theme
  { "EdenEast/nightfox.nvim" },
  {
    "topaxi/gh-actions.nvim",
    cmd = "GhActions",
    keys = {
      { "<leader>gh", "<cmd>GhActions<cr>", desc = "Open Github Actions" },
    },
    -- optional, you can also install and use `yq` instead.
    build = "make",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    opts = {},
    config = function(_, opts) require("gh-actions").setup(opts) end,
    event = "User AstroGitFile",
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
  },
  -- leap fast motion
  {
    "ggandor/flit.nvim",
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs { "f", "F", "t", "T" } do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  -- leap neovim
  {
    "ggandor/leap.nvim",
    keys = {
      { "g", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "G", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gg", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require "leap"
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.2",
    config = function()
      require("distant").setup {
        -- Applies Chip's personal settings to every machine you connect to
        --
        -- 1. Ensures that distant servers terminate with no connections
        -- 2. Provides navigation bindings for remote directories
        -- 3. Provides keybinding to jump into a remote file's parent directory
        ["*"] = require("distant.settings").chip_default(),
      }
    end,
    lazy = false,
  },
  -- git conflicts
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    event = "User AstroFile",
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup {
        default_mappings = true,
        dismiss_on_move = true,
      }
    end,
    -- lazy = false,
    event = "User AstroFile",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      size = 10,
      shell = "zsh",
      -- open_mapping = [[<F7>]],
      open_mapping = [[<c-\>]],
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
    lazy = false,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous { skip_groups = true, jump = true }
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
  {
    "declancm/cinnamon.nvim",
    config = function() require("cinnamon").setup() end,
    event = "User AstroFile",
    -- lazy = false
  },
  -- { "easymotion/vim-easymotion", lazy = false },
  {
    "abecodes/tabout.nvim",
    config = function() require("user.tabout").config() end,
    lazy = false,
  },
  {
    "f-person/git-blame.nvim",
    event = "User AstroGitFile",
    -- lazy = false,
  },
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- opts.section.header.val = {
      --   "                                                     ",
      --   "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      --   "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      --   "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      --   "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      --   "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      --   "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      --   "                                                     ",
      -- }
      opts.section.header.val = {
        "           ▄ ▄                   ",
        "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
        "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
        "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
        "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
        "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
        "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
        "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
        "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    -- event = "InsertEnter",
    opts = function(_, opts)
      local cmp, copilot = require "cmp", require "copilot.suggestion"
      local lspkind = require "lspkind"
      cmp.setup {
        formatting = {
          format = lspkind.cmp_format {
            mode = "symbol",
            max_width = 50,
            symbol_map = { Copilot = "" },
          },
        },
      }
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      if not snip_status_ok then return end
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end
      if not opts.mapping then opts.mapping = {} end
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if copilot.is_visible() then
          copilot.accept()
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<C-x>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.next() end
      end)

      opts.mapping["<C-z>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.prev() end
      end)

      opts.mapping["<C-right>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_word() end
      end)

      opts.mapping["<C-l>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_word() end
      end)

      opts.mapping["<C-down>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_line() end
      end)

      opts.mapping["<C-j>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_line() end
      end)

      opts.mapping["<C-c>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.dismiss() end
      end)

      return opts
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    opts = { suggestion = { auto_trigger = true, debounce = 150 } },
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = false,
    after = { "copilot.lua" },
    config = function() require("copilot_cmp").setup {} end,
  },
  {
    "abecodes/tabout.nvim",
    lazy = false,
    wants = { "nvim-treesitter" },
    after = { "nvim-cmp" },
    config = function()
      require("tabout").setup {
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = ":", close = ":" },
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      }
    end,
  },
  { "luisiacc/gruvbox-baby" },
  { "rebelot/kanagawa.nvim" },
  -- github dark themes
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup {
        -- ...
      }

      -- vim.cmd "github_dark_tritanopia"
      -- vim.cmd "colorscheme github_dark_tritanopia"
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
    event = "VeryLazy",
  },
  -- {
  --   "tzachar/cmp-tabnine",
  --   build = "./install.sh",
  --   dependencies = "hrsh7th/nvim-cmp",
  --   after = "nvim-cmp",
  --   opts = function(_, opts)
  --     -- local tabnine = require "cmp_tabnine.config"
  --     -- tabnine:setup {
  --     --   max_lines = 1000,
  --     --   max_num_results = 20,
  --     --   sotr = true,
  --     --   run_on_every_keystroke = true,
  --     --   snippet_placeholder = "..",
  --     --   ignored_filetypes = {},
  --     --   show_prediction_strength = false,
  --     -- }
  --     -- astronvim.add_cpm_source { name = "cmp_tabnine", priority = 1000, max_item_count = 7 }
  --     local cmp = require "cmp"
  --     opts.sources = cmp.config.sources {
  --       { name = "nvim_lsp", priority = 1000 },
  --       { name = "luasnip", priority = 750 },
  --       { name = "cmp_tabnine", priority = 1000 },
  --       { name = "buffer", priority = 750 },
  --       { name = "path", priority = 500 },
  --       -- { name = "emoji", priority = 700 },
  --     }
  --     return opts
  --   end,
  --   lazy = false,
  -- },
  -- {
  --   "codota/tabnine-nvim",
  --   build = "./dl_binaries.sh",
  --   lazy = false,
  --   -- branch = "beta",
  --   config = function()
  --     require("tabnine").setup {
  --       disable_auto_comment = true,
  --       accept_keymap = "<Tab>",
  --       dismiss_keymap = "<C-]>",
  --       debounce_ms = 800,
  --       suggestion_color = { gui = "#98c379", cterm = 244 },
  --       exclude_filetypes = { "TelescopePrompt" },
  --     }
  --   end,
  -- },
  {
    "simrat39/rust-tools.nvim",
    { "williamboman/mason-lspconfig.nvim" },
    opts = {
      ensure_installed = { "rust-analyzer" },
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "clangd" },
      },
    },
    lazy = false,
  },
  { "doums/darcula" },
  { "briones-gabriel/darcula-solid.nvim", requires = "rktjmp/lush.nvim" },
  {
    "danymat/neogen",
    config = function()
      -- adding some keybindings
      local opts = { noremap = true, silent = true }
      local map = vim.api.nvim_set_keymap
      map("n", "<leader>nf", ":lua require('neogen').generate({type = 'func' })<CR>", opts)
      map("n", "<leader>nf", ":lua require('neogen').generate({type = 'func' })<CR>", opts)
      map("n", "<leader>nl", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)

      require("neogen").setup {
        enabled = true,
        input_after_comment = true,
        languages = {
          lua = {
            template = {
              annotation_convention = "emmylua",
            },
          },
          python = {
            template = {
              annotation_convention = "numpydoc",
            },
          },
          cpp = {
            template = {
              annotation_convention = "doxygen",
            },
          },
          rust = {
            template = {
              annotation_convention = "rustdoc",
            },
          },
          sh = {
            template = {
              annotation_convention = "google_bash",
            },
          },
        },
      }
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  },
}
