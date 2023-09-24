-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.g.neotree_auto_cd = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

lvim.builtin.nvimtree.active = false
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.treesitter.highlight.enable = true

lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
}

lvim.lsp.installer.setup.ensure_installed = {
	"sumneko_lua",
	"jsonls",
	"html",
	"cssls",
	"emmet_ls",
	"tsserver",
	"intelephense",
	"tailwindcss",
}

require("lvim.lsp.manager").setup("emmet_ls")
require("lvim.lsp.manager").setup("tailwindcss")
require("lvim.lsp.manager").setup("intelephense")

lvim.builtin.which_key.mappings["e"] = {"<Cmd>:NeoTreeFocusToggle<CR>", "Open NeoTree"}
lvim.builtin.which_key.mappings["E"] = {"<Cmd>:NeoTreeFocus<CR>", "Focus NeoTree"}
lvim.builtin.which_key.mappings["F"] = {"<Cmd>:NeoTreeFloatToggle<CR>", "Open NeoTree(Float mode)"}
lvim.builtin.which_key.mappings["m"] = {"<Cmd>:MarkdownPreviewToggle<CR>", "Open Markdown Preview"}
lvim.builtin.which_key.mappings["i"] = {"gg<CR>=G<CR>", "auto indent (gg/=G)"}

lvim.keys.normal_mode["<S-k>"] = {"<Cmd>:m .-2<CR>=="}
lvim.keys.normal_mode["<S-j>"] = {"<Cmd>:m .+1<CR>=="}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
  }
}

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { name = "black" },
  { name = "stylua" },
  {
    name = "clang_format",
    args = { "--style=chromium" },
  },
  {
    name = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
  },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
})

lvim.plugins = {
  { "mg979/vim-visual-multi", branch = "master" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
      })
    end
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript", "typescript" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 0
    end,
  },
  {
    "turbio/bracey.vim",
    cmd = {"Bracey", "BracyStop", "BraceyReload", "BraceyEval"},
    build = "npm install --prefix server",
  },
  {
    "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
    end,
  },
}
