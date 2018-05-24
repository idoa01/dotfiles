if exists('g:plug_installing_plugins')
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer --gocode-completer' }
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
  finish
endif

let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'ruby' : 1,
    \ 'javascript' : 1,
    \}
