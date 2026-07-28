return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)

      local Tree = require("snacks.explorer.tree")
      local expand = Tree.expand

      -- Auto-expand directories that have exactly one fileless subdirectory (compactible chains)
      function Tree:expand(node)
        expand(self, node)
        local function recurse(n)
          local dir
          local dirCount, fileCount = 0, 0
          for _, child in pairs(n.children) do
            if child.dir then
              dirCount = dirCount + 1
              dir = child
            else
              fileCount = fileCount + 1
            end
            if dirCount > 1 or fileCount > 0 then
              return
            end
          end
          if not dir then
            return
          end
          dir.open = true
          expand(self, dir)
          recurse(dir)
        end
        recurse(node)
      end
    end,
  },
}
