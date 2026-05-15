return {
  clangd_cmd = {
    'clangd',
    '-j',
    '16',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    -- '--log=info',
    '--enable-config',
    '--limit-results=30',
    '--pch-storage=memory',
  },
  stylua_path = {
  },
  clang_format_conform = {
  },
}
