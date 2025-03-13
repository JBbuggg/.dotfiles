call plug#begin('~/.config/nvim/plugged')

" 🎨 ธีมและ UI
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'  " ใช้ Lightline
Plug 'vim-airline/vim-airline'  " ใช้ Airline (ถ้าไม่ใช้ Lightline)
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'kien/ctrlp.vim'

" 📂 File Explorer (NvimTree)
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" 🛠️ Git Integration
Plug 'tpope/vim-fugitive'

" 💡 LSP & Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" 📌 เปิดใช้งาน syntax และธีม
syntax on
colorscheme onedark

" 📂 ตั้งค่า NvimTree (ป้องกัน error ถ้าไม่มีปลั๊กอิน)
lua << EOF
local status, nvim_tree = pcall(require, "nvim-tree")
if status then
    nvim_tree.setup()
end
EOF

" 📂 ปุ่มลัดเปิด/ปิด NvimTree
"
nnoremap <C-n> :NvimTreeToggle<CR>

" 🚀 ตั้งค่า Lightline และ Git Branch
"
function! GitBranch()
  let branch = FugitiveHead()
  return branch !=# '' ? ' ' . branch : ''
endfunction

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'GitBranch'
      \ }
      \ }



" 📝 ปรับ Clipboard ให้ Copy ออกไป System Clipboard ได้
"
set clipboard+=unnamedplus

" 💡 ตั้งค่าปุ่มลัดสำหรับ Coc.nvim (Snippet)
"
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
xmap <leader>x  <Plug>(coc-convert-snippet)

" 🎨 ทำให้พื้นหลังโปร่งใส (Transparent Background)
" 
highlight Normal guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE


set number

