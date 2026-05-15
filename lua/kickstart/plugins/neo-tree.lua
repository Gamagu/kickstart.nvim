-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local function calc_width(state)
  if not state or not state.tree then
    return 30
  end
  local tree = state.tree
  local max_width = 30 -- minimum width
  local function walk_node(node, depth)
    local name = node.name or node.id or ''
    local width = depth * 2 + #name + 4
    if width > max_width then
      max_width = width
    end
    if node:is_expanded() then
      local child_ids = node:get_child_ids()
      if child_ids then
        for _, child_id in ipairs(child_ids) do
          local child = tree:get_node(child_id)
          if child then
            walk_node(child, depth + 1)
          end
        end
      end
    end
  end
  local root_nodes = tree:get_nodes()
  if root_nodes then
    for _, node in ipairs(root_nodes) do
      walk_node(node, node:get_depth())
    end
  end
  return max_width
end

local function resize_neo_tree_window(state)
  if not state then
    return
  end
  local win = state.winid
  if not win or not vim.api.nvim_win_is_valid(win) then
    return
  end
  local new_width = calc_width(state)
  local config = vim.api.nvim_win_get_config(win)
  if config.relative and config.relative ~= '' then
    config.width = new_width
    config.col = vim.o.columns - new_width
    vim.api.nvim_win_set_config(win, config)
  end
end

---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>of', ':Neotree reveal<CR>', desc = '[O]pen [F]ile tree', silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    event_handlers = {
      {
        event = 'neo_tree_window_after_open',
        handler = function(args)
          local state = args and args.state or args
          resize_neo_tree_window(state)
        end,
      },
      {
        event = 'after_render',
        handler = function(state)
          resize_neo_tree_window(state)
        end,
      },
    },
    window = {
      position = 'float',
      popup = {
        position = { col = '100%', row = '0' },
        size = function(state)
          local lines = vim.o.lines
          return {
            width = calc_width(state),
            height = math.floor(lines * 0.5),
          }
        end,
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
