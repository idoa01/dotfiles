if exists('g:plug_installing_plugins')
  " PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Both options are optional. You don't have to install fzf in ~/.fzf
  " and you don't have to run install script if you use fzf only in Vim.
  Plug 'junegunn/fzf.vim'
  finish
endif

nnoremap <leader>af :Ag<space>

" Leader Commands
nnoremap <silent><leader>. :call Fzf_dev()<CR>
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>gm :GFiles?<CR>
nnoremap <leader>bl :BLines<CR>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ----------------------------------------------------------
" Files + devicons
" From: https://github.com/ryanoasis/vim-devicons/issues/106
" ----------------------------------------------------------
function! Fzf_dev()
  function! s:files()
    let files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(files)
  endfunction

  function! s:prepend_icon(candidates)
    let result = []
    for candidate in a:candidates
      let filename = fnamemodify(candidate, ':p:t')
      let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
      call add(result, printf("%s %s", icon, candidate))
    endfor

    return result
  endfunction

  function! s:edit_file(item)
    let parts = split(a:item, ' ')
    let file_path = get(parts, 1, '')
    execute 'silent e' file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'down':    '40%' })
endfunction
