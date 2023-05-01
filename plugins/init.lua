return {
  { "easymotion/vim-easymotion", lazy = false },
  {
    "abecodes/tabout.nvim",
    config = function() require("user.tabout").config() end,
    lazy = false,
  },
  {
    "f-person/git-blame.nvim",
    event = "User AstroGitFile",
    lazy = false,
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
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function() end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    -- event = "InsertEnter",
    opts = function(_, opts)
      local cmp, copilot = require "cmp", require "copilot.suggestion"
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
  { "projekt0n/github-nvim-theme", tag = "v0.0.7" },
  {
    "kylechui/nvim-surround",
    lazy = false,
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
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
  -- {
  --   "rebelot/heirline.nvim",
  --   opts = function(_, opts)
  --     local status = require "astronvim.utils.status"
  --
  --     opts.winbar = {
  --       -- create custom winbar
  --       -- store the current buffer number
  --       init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
  --       fallthrough = false, -- pick the correct winbar based on condition
  --       -- inactive winbar
  --       {
  --         condition = function() return not status.condition.is_active() end,
  --         -- show the path to the file relative to the working directory
  --         status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
  --         -- add the file name and icon
  --         status.component.file_info {
  --           file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
  --           file_modified = false,
  --           file_read_only = false,
  --           hl = status.hl.get_attributes("winbarnc", true),
  --           surround = false,
  --           update = "BufEnter",
  --         },
  --       },
  --       -- active winbar
  --       {
  --         -- show the path to the file relative to the working directory
  --         status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
  --         -- add the file name and icon
  --         status.component.file_info { -- add file_info to breadcrumbs
  --           file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
  --           file_modified = false,
  --           file_read_only = false,
  --           hl = status.hl.get_attributes("winbar", true),
  --           surround = false,
  --           update = "BufEnter",
  --         },
  --         -- show the breadcrumbs
  --         status.component.breadcrumbs {
  --           icon = { hl = true },
  --           hl = status.hl.get_attributes("winbar", true),
  --           prefix = true,
  --           padding = { left = 0 },
  --         },
  --       },
  --     }
  --
  --     return opts
  --   end,
  -- },
}
