return {
  "vim-airline/vim-airline",
  dependencies = {
      "vim-airline/vim-airline-themes",
  },
  config = function()
      -- Airline configuration
      vim.cmd([[
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#buffer_idx_mode = 1
      let g:airline#extensions#tabline#left_sep = ' > '
      let g:airline#extensions#tabline#left_alt_sep = ' > '
      let g:airline#extensions#tabline#formatter = 'unique_tail'
      ]])
  end,
}
