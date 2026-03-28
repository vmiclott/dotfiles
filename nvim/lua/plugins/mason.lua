return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Bash
        "bash-language-server",
        "shfmt",

        -- C/C++
        "clangd",
        "clang-format",
        "codelldb",

        -- Go
        "gopls",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "delve",

        -- Java
        "jdtls",
        "java-debug-adapter",

        -- JavaScript/TypeScript
        "vtsls",
        "prettier",
        "js-debug-adapter",

        -- Lua
        "lua-language-server",
        "stylua",

        -- Python
        "pyright",
        "ruff",
        "debugpy",

        -- Ruby
        "ruby-lsp",
        "rubocop",
        "rubyfmt",

        -- Utilities
        "shellcheck",
        "cspell-lsp",
        "tree-sitter-cli",
      },
    },
  },
}
