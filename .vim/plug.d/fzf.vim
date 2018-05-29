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
  let l:fzf_file_options = '--preview "[[ \$(file --mime {2..-1}) =~ binary ]] && echo {2..-1} is a binary file || (highlight -O ansi -l {2..-1} || coderay {2..-1} || rougify {2..-1} || cat {2..-1}) 2> /dev/null | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf("%s %s", l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_file_options,
        \ 'down':    '40%' })
endfunction


command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
