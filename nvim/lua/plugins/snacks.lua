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

      -- Auto-expand directories that contain no files
      function Tree:expand(node)
        expand(self, node)
        local function recurse(n)
          local dirs, files = {}, {}
          for _, child in pairs(n.children) do
            if child.dir then
              table.insert(dirs, child)
            else
              table.insert(files, child)
            end
          end
          if #files == 0 and #dirs > 0 then
            for _, dir in ipairs(dirs) do
              dir.open = true
              expand(self, dir)
              recurse(dir)
            end
          end
        end
        recurse(node)
      end

      -- True when a tree node has exactly one directory child and no files
      local function is_compactable(tn)
        if not tn then
          return false
        end
        local dirs, files = 0, 0
        for _, child in pairs(tn.children) do
          if child.dir then
            dirs = dirs + 1
          else
            files = files + 1
          end
        end
        return dirs == 1 and files == 0
      end

      -- Full compact path for items whose parent chain was collapsed
      local function get_compact_label(file)
        local tn = Tree:node(file)
        if not tn or not tn.parent then
          return nil
        end
        if not is_compactable(tn.parent) then
          return nil
        end
        local parts = {}
        local n = tn.parent
        while n and is_compactable(n) do
          table.insert(parts, 1, n.name)
          n = n.parent
        end
        return #parts > 0 and table.concat(parts, "/") .. "/" or nil
      end

      -- Suppress single-child directories from the picker, reparenting their descendants to the nearest ancestor that has siblings or files.
      local ExplorerSource = require("snacks.picker.source.explorer")
      local original_explorer = ExplorerSource.explorer

      ExplorerSource.explorer = function(finder_opts, ctx)
        local original_finder = original_explorer(finder_opts, ctx)
        return function(cb)
          local buffer = {}
          original_finder(function(item)
            buffer[#buffer + 1] = item
          end)

          local by_path = {}
          for _, item in ipairs(buffer) do
            by_path[item.file] = item
          end

          local suppress = {}
          for _, item in ipairs(buffer) do
            if item.dir then
              local tn = Tree:node(item.file)
              if tn and is_compactable(tn) then
                suppress[item.file] = true
              end
            end
          end

          local remaining = {}
          for _, item in ipairs(buffer) do
            if not suppress[item.file] then
              while item.parent and suppress[item.parent.file] do
                local ptn = Tree:node(item.parent.file)
                if ptn and ptn.parent then
                  item.parent = by_path[ptn.parent.path]
                else
                  item.parent = nil
                  break
                end
              end
              item.compact_label = get_compact_label(item.file)
              remaining[#remaining + 1] = item
            end
          end

          local parent_groups = {}
          for _, item in ipairs(remaining) do
            local pk = item.parent and item.parent.file or ""
            if not parent_groups[pk] then
              parent_groups[pk] = {}
            end
            parent_groups[pk][#parent_groups[pk] + 1] = item
          end
          for _, group in pairs(parent_groups) do
            for i, sib in ipairs(group) do
              sib.last = (i == #group)
            end
          end

          for _, item in ipairs(remaining) do
            cb(item)
          end
        end
      end

      -- Root item: show just the basename. Other items: prepend compact_label.
      local Format = require("snacks.picker.format")
      local orig_filename = Format.filename

      function Format.filename(item, picker)
        if not item.parent then
          local ret = {}
          if picker.opts.icons.files.enabled ~= false then
            local icon, hl = Snacks.util.icon(item.file, "directory", { fallback = picker.opts.icons.files })
            if item.open then
              icon = picker.opts.icons.files.dir_open
            end
            icon = Snacks.picker.util.align(icon, picker.opts.formatters.file.icon_width or 2)
            ret[#ret + 1] = { icon, hl, virtual = true }
          end
          ret[#ret + 1] = { vim.fn.fnamemodify(item.file, ":t"), "SnacksPickerDirectory", field = "file" }
          return ret
        end
        local ret = orig_filename(item, picker)
        if item.compact_label then
          table.insert(ret, 1, { item.compact_label, "SnacksPickerDir", field = "file" })
        end
        return ret
      end
    end,
  },
}
