return {
  n = {
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", desc = "toggle trouble" },
    ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "toggle workspace diagnostics" },
    ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "document diagnostics" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "document list" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>" },
    ["gR"] = { "<cmd>TroubleToggle lsp_references<cr>" },
    -- ["<:>"] = { "<cmd>FineCmdline<CR>", dest = "command line" },
    -- ["<CR>"] = { "<cmd>FineCmdline<CR>", { noremap = true } },
    -- ["gp"] = {
    --   "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
    --   desc = "go to preview",
    --   --{ noremap = true },
    -- },
  },
  t = {},
}
