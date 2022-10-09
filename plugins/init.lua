-- keeping plugins here
return {
  { "andweeb/presence.nvim" },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function() require("treesitter-context").setup {} end,
  },
  { "simrat39/inlay-hints.nvim" },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    after = "mason-lspconfig.nvim",
    config = function()
      require("rust-tools").setup {
        server = astronvim.lsp.server_settings "rust_analyzer",
      }
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    after = "mason-lspconfig.nvim",
    config = function()
      require("clangd_extensions").setup {
        server = astronvim.lsp.server_settings "clangd",
        extensions = {
          -- defaults:
          -- Automatically set inlay hints (type hints)
          autoSetHints = true,
          -- These apply to the default ClangdSetInlayHints command
          inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
          },
          ast = {
            role_icons = {
              type = "",
              declaration = "",
              expression = "",
              specifier = "",
              statement = "",
              ["template argument"] = "",
            },

            kind_icons = {
              Compound = "",
              Recovery = "",
              TranslationUnit = "",
              PackExpansion = "",
              TemplateTypeParm = "",
              TemplateTemplateParm = "",
              TemplateParamObject = "",
            },

            highlights = {
              detail = "Comment",
            },
          },
          memory_usage = {
            border = "none",
          },
          symbol_info = {
            border = "none",
          },
        },
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup {
        styles = {
          comments = { italic = false },
          keywords = { italic = true },
          functions = { italic = true },
        },
      }
    end,
  },
  --themer
  {
    "themercorp/themer.lua",
    config = function()
      require("themer").setup {
        -- colorscheme = "rose_pine",
        -- colorscheme = "kurai",
        -- colorscheme = "papa_dark",
        -- colorscheme = "ayu_mirage",
        styles = {
          ["function"] = { style = "italic" },
          functionbuiltin = { style = "italic" },
          -- variable = { style = "italic" },
          variable = { style = "None" },
          variableBuiltIn = { style = "italic" },
          parameter = { style = "italic" },
        },
        plugins = {
          treesitter = true,
          indentline = true,
          barbar = true,
          bufferline = true,
          cmp = true,
          gitsigns = true,
          lsp = true,
          telescope = true,
        },
      }
    end,
  },
  -- onedark
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup {
        style = "cool",
        -- style = "deep",
        -- style = "darker",
        code_style = {
          comments = "none",
          keywords = "italic",
          functions = "italic",
        },
      }
    end,
  },
  --minimal
  { "Yazeed1s/minimal.nvim" },
  --sonokai
  { "sainnhe/sonokai" },
  --material
  {
    "marko-cerovac/material.nvim",
    config = function()
      require("material").setup {
        italics = {
          keywords = true,
          comments = true,
          functions = true,
          variables = false,
        },
      }
    end,
  },
  -- kanagawa bones colorscheme
  {
    "Shatur/neovim-ayu",
    config = function()
      require("ayu").setup {
        mirage = true,
      }
    end,
  },
  { "rebelot/kanagawa.nvim" },
  { "lunarvim/horizon.nvim" },
  -- tokyodark color scheme
  { "tiagovla/tokyodark.nvim" },
  -- catppuccin color scheme
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function() require("catppuccin").setup {} end,
  },
  { "mfussenegger/nvim-dap" },
  {
    "Shatur/neovim-cmake",
    config = function()
      local opts = { noremap = true, silent = true }
      local map = vim.api.nvim_set_keymap
      map("n", "<leader><F6>", ":CMake configure<CR>", opts)
      map("n", "<leader><F7>", ":CMake build_all<CR>", opts)
      local Path = require "plenary.path"
      local progress = ""
      -- function cmake_build()
      --   local job = require("cmake").build()
      --   if job then
      --     job:after(vim.schedule_wrap(function(_, exit_code)
      --       if exit_code == 0 then
      --         vim.notify("Target was built successfully", vim.log.levels.INFO, { title = "CMake" })
      --       else
      --         vim.notify("Target build failed", vim.log.levels.ERROR, { title = "CMake" })
      --       end
      --     end))
      --   end
      -- end

      require("cmake").setup {
        cmake_executable = "cmake",
        save_before_build = true,
        parameters_file = "neovim.json",
        copy_compile_commands = true,
        dap_configuration = {
          type = "lldb",
          request = "launch",
          stopOnEntry = false,
          runInTerminal = false,
        },
        dap_open_command = require("dap").repl.open,
        build_dir = tostring(Path:new("{cwd}", "build", "{os}-{build_type}")),
        default_projects_path = tostring(Path:new(vim.loop.os_homedir(), "Projects")),
        configure_args = { "-GNinja", "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
        build_args = {},
        on_build_output = nil,
        -- on_build_output = function(lines)
        --   local match = string.match(lines[#lines], "(%[.*%])")
        --   if match then progress = string.gsub(match, "%%", "%%%%") end
        -- end,
        quickfix = {
          pos = "botright", -- Where to open quickfix
          height = 10, -- Height of the opened quickfix.
          only_on_error = true, -- Open quickfix window only if target build failed.
        },
      }
    end,
  },
  {
    "danymat/neogen",
    config = function()
      -- adding some keybindings
      local opts = { noremap = true, silent = true }
      local map = vim.api.nvim_set_keymap
      map("n", "<leader>nf", ":lua require('neogen').generate({type = 'func' })<CR>", opts)
      map("n", "<leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)

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
