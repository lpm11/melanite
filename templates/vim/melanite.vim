" File:       melanite.vim
" Maintainer: lpm11
" URL:        https://github.com/lpm11/melanite
" Modified:   8 Feb 2015 09:25 PM JST
" License:    MIT

" Description:"{{{
" ----------------------------------------------------------------------------
" Yet another dark color scheme.
" 
" The code taken from vim-hybrid:
" https://github.com/w0ng/vim-hybrid
"
" vim-hybrid combines the following:
" 
"   The RGB colour palette is taken from Tomorrow-Night.vim:
"   https://github.com/chriskempson/vim-tomorrow-theme
"
"   The syntax highlighting scheme is taken from jellybeans.vim:
"   https://github.com/nanotech/jellybeans.vim
"
"   The code taken from solarized.vim
"   https://github.com/altercation/vim-colors-solarized

"}}}
" Initialisation:"{{{
" ----------------------------------------------------------------------------
if !has("gui_running") && &t_Co < 256
  finish
endif

if !exists("g:melanite_use_Xresources")
  let g:melanite_use_Xresources = 0
endif

if !exists("g:melanite_use_iTerm_colors")
  let g:melanite_use_iTerm_colors = 0
endif

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "melanite"

"}}}
" GUI And Cterm Palettes:"{{{
" ----------------------------------------------------------------------------
if has("gui_running")
  let s:vmode       = "gui"
  let s:bg1         = "@melanite-bg1"
  let s:bg2         = "@melanite-bg2"
  let s:fg1         = "@melanite-fg1"
  let s:fg2         = "@melanite-fg2"
  let s:fga         = "@melanite-fga"
  let s:fgb         = "@melanite-fgb"
  let s:red         = "@melanite-red"
  let s:orange      = "@melanite-orange"
  let s:yellow      = "@melanite-yellow"
  let s:green       = "@melanite-green"
  let s:cyan        = "@melanite-cyan"
  let s:blue        = "@melanite-blue"
  let s:purple      = "@melanite-purple"
  let s:violet      = "@melanite-violet"
  let s:darkred     = "@melanite-red-l60"
  let s:darkorange  = "@melanite-orange-l60"
  let s:darkyellow  = "@melanite-yellow-l60"
  let s:darkgreen   = "@melanite-green-l60"
  let s:darkcyan    = "@melanite-cyan-l60"
  let s:darkblue    = "@melanite-blue-l60"
  let s:darkpurple  = "@melanite-purple-l60"
  let s:darkviolet  = "@melanite-violet-l60"
  let s:lightred    = "@melanite-red-l80"
  let s:lightorange = "@melanite-orange-l80"
  let s:lightyellow = "@melanite-yellow-l80"
  let s:lightgreen  = "@melanite-green-l80"
  let s:lightcyan   = "@melanite-cyan-l80"
  let s:lightblue   = "@melanite-blue-l80"
  let s:lightpurple = "@melanite-purple-l80"
  let s:lightviolet = "@melanite-violet-l80"
else
  let s:vmode       = "cterm"
  let s:bg1         = "@melanite-bg1-p"
  let s:bg2         = "@melanite-bg2-p"
  let s:fg1         = "@melanite-fg1-p"
  let s:fg2         = "@melanite-fg2-p"
  let s:fga         = "@melanite-fga-p"
  let s:fgb         = "@melanite-fgb-p"
  let s:red         = "@melanite-red-p"
  let s:orange      = "@melanite-orange-p"
  let s:yellow      = "@melanite-yellow-p"
  let s:green       = "@melanite-green-p"
  let s:cyan        = "@melanite-cyan-p"
  let s:blue        = "@melanite-blue-p"
  let s:purple      = "@melanite-purple-p"
  let s:violet      = "@melanite-violet-p"
  let s:darkred     = "@melanite-red-l60-p"
  let s:darkorange  = "@melanite-orange-l60-p"
  let s:darkyellow  = "@melanite-yellow-l60-p"
  let s:darkgreen   = "@melanite-green-l60-p"
  let s:darkcyan    = "@melanite-cyan-l60-p"
  let s:darkblue    = "@melanite-blue-l60-p"
  let s:darkpurple  = "@melanite-purple-l60-p"
  let s:darkviolet  = "@melanite-violet-l60-p"
  let s:lightred    = "@melanite-red-l80-p"
  let s:lightorange = "@melanite-orange-l80-p"
  let s:lightyellow = "@melanite-yellow-l80-p"
  let s:lightgreen  = "@melanite-green-l80-p"
  let s:lightcyan   = "@melanite-cyan-l80-p"
  let s:lightblue   = "@melanite-blue-l80-p"
  let s:lightpurple = "@melanite-purple-l80-p"
  let s:lightviolet = "@melanite-violet-l80-p"
  
  " Not supported yet
  " if g:melanite_use_Xresources == 1
  "   let s:foreground = "15"   " White
  "   let s:selection  = "8"    " DarkGrey
  "   let s:line       = "0"    " Black
  "   let s:comment    = "7"    " LightGrey
  "   let s:red        = "9"    " LightRed
  "   let s:orange     = "3"    " DarkYellow
  "   let s:yellow     = "11"   " LightYellow
  "   let s:green      = "10"   " LightGreen
  "   let s:aqua       = "14"   " LightCyan
  "   let s:blue       = "12"   " LightBlue
  "   let s:purple     = "13"   " LightMagenta

  if g:melanite_use_iTerm_colors == 1
    let s:red         = "1"
    let s:green       = "2"
    let s:yellow      = "3"
    let s:blue        = "4"
    let s:violet      = "5"
    let s:cyan        = "6"
    let s:lightred    = "9"
    let s:lightgreen  = "10"
    let s:lightyellow = "11"
    let s:lightblue   = "12"
    let s:lightviolet = "13"
    let s:lightcyan   = "14"
  endif
endif

"}}}
" Formatting Options:"{{{
" ----------------------------------------------------------------------------
let s:none   = "NONE"
let s:t_none = "NONE"
let s:n      = "NONE"
let s:c      = ",undercurl"
let s:r      = ",reverse"
let s:s      = ",standout"
let s:b      = ",bold"
let s:u      = ",underline"
let s:i      = ",italic"

"}}}
" Highlighting Primitives:"{{{
" ----------------------------------------------------------------------------
exe "let s:bg_none = ' "       .s:vmode."bg=".s:none       ."'"
exe "let s:bg_bg1 = ' "        .s:vmode."bg=".s:bg1        ."'"
exe "let s:bg_bg2 = ' "        .s:vmode."bg=".s:bg2        ."'"
exe "let s:bg_fg1 = ' "        .s:vmode."bg=".s:fg1        ."'"
exe "let s:bg_fg2 = ' "        .s:vmode."bg=".s:fg2        ."'"
exe "let s:bg_fga = ' "        .s:vmode."bg=".s:fga        ."'"
exe "let s:bg_fgb = ' "        .s:vmode."bg=".s:fgb        ."'"
exe "let s:bg_red = ' "        .s:vmode."bg=".s:red        ."'"
exe "let s:bg_orange = ' "     .s:vmode."bg=".s:orange     ."'"
exe "let s:bg_yellow = ' "     .s:vmode."bg=".s:yellow     ."'"
exe "let s:bg_green = ' "      .s:vmode."bg=".s:green      ."'"
exe "let s:bg_cyan = ' "       .s:vmode."bg=".s:cyan       ."'"
exe "let s:bg_blue = ' "       .s:vmode."bg=".s:blue       ."'"
exe "let s:bg_purple = ' "     .s:vmode."bg=".s:purple     ."'"
exe "let s:bg_violet = ' "     .s:vmode."bg=".s:violet     ."'"
exe "let s:bg_darkred = ' "    .s:vmode."bg=".s:darkred    ."'"
exe "let s:bg_darkorange = ' " .s:vmode."bg=".s:darkorange ."'"
exe "let s:bg_darkyellow = ' " .s:vmode."bg=".s:darkyellow ."'"
exe "let s:bg_darkgreen = ' "  .s:vmode."bg=".s:darkgreen  ."'"
exe "let s:bg_darkcyan = ' "   .s:vmode."bg=".s:darkcyan   ."'"
exe "let s:bg_darkblue = ' "   .s:vmode."bg=".s:darkblue   ."'"
exe "let s:bg_darkpurple = ' " .s:vmode."bg=".s:darkpurple ."'"
exe "let s:bg_darkviolet = ' " .s:vmode."bg=".s:darkviolet ."'"
exe "let s:bg_lightred = ' "   .s:vmode."bg=".s:lightred   ."'"
exe "let s:bg_lightorange = ' ".s:vmode."bg=".s:lightorange."'"
exe "let s:bg_lightyellow = ' ".s:vmode."bg=".s:lightyellow."'"
exe "let s:bg_lightgreen = ' " .s:vmode."bg=".s:lightgreen ."'"
exe "let s:bg_lightcyan = ' "  .s:vmode."bg=".s:lightcyan  ."'"
exe "let s:bg_lightblue = ' "  .s:vmode."bg=".s:lightblue  ."'"
exe "let s:bg_lightpurple = ' ".s:vmode."bg=".s:lightpurple."'"
exe "let s:bg_lightviolet = ' ".s:vmode."bg=".s:lightviolet."'"

exe "let s:fg_none = ' "       .s:vmode."fg=".s:none       ."'"
exe "let s:fg_bg1 = ' "        .s:vmode."fg=".s:bg1        ."'"
exe "let s:fg_bg2 = ' "        .s:vmode."fg=".s:bg2        ."'"
exe "let s:fg_fg1 = ' "        .s:vmode."fg=".s:fg1        ."'"
exe "let s:fg_fg2 = ' "        .s:vmode."fg=".s:fg2        ."'"
exe "let s:fg_fga = ' "        .s:vmode."fg=".s:fga        ."'"
exe "let s:fg_fgb = ' "        .s:vmode."fg=".s:fgb        ."'"
exe "let s:fg_red = ' "        .s:vmode."fg=".s:red        ."'"
exe "let s:fg_orange = ' "     .s:vmode."fg=".s:orange     ."'"
exe "let s:fg_yellow = ' "     .s:vmode."fg=".s:yellow     ."'"
exe "let s:fg_green = ' "      .s:vmode."fg=".s:green      ."'"
exe "let s:fg_cyan = ' "       .s:vmode."fg=".s:cyan       ."'"
exe "let s:fg_blue = ' "       .s:vmode."fg=".s:blue       ."'"
exe "let s:fg_purple = ' "     .s:vmode."fg=".s:purple     ."'"
exe "let s:fg_violet = ' "     .s:vmode."fg=".s:violet     ."'"
exe "let s:fg_darkred = ' "    .s:vmode."fg=".s:darkred    ."'"
exe "let s:fg_darkorange = ' " .s:vmode."fg=".s:darkorange ."'"
exe "let s:fg_darkyellow = ' " .s:vmode."fg=".s:darkyellow ."'"
exe "let s:fg_darkgreen = ' "  .s:vmode."fg=".s:darkgreen  ."'"
exe "let s:fg_darkcyan = ' "   .s:vmode."fg=".s:darkcyan   ."'"
exe "let s:fg_darkblue = ' "   .s:vmode."fg=".s:darkblue   ."'"
exe "let s:fg_darkpurple = ' " .s:vmode."fg=".s:darkpurple ."'"
exe "let s:fg_darkviolet = ' " .s:vmode."fg=".s:darkviolet ."'"
exe "let s:fg_lightred = ' "   .s:vmode."fg=".s:lightred   ."'"
exe "let s:fg_lightorange = ' ".s:vmode."fg=".s:lightorange."'"
exe "let s:fg_lightyellow = ' ".s:vmode."fg=".s:lightyellow."'"
exe "let s:fg_lightgreen = ' " .s:vmode."fg=".s:lightgreen ."'"
exe "let s:fg_lightcyan = ' "  .s:vmode."fg=".s:lightcyan  ."'"
exe "let s:fg_lightblue = ' "  .s:vmode."fg=".s:lightblue  ."'"
exe "let s:fg_lightpurple = ' ".s:vmode."fg=".s:lightpurple."'"
exe "let s:fg_lightviolet = ' ".s:vmode."fg=".s:lightviolet."'"

exe "let s:fmt_none      = ' ".s:vmode."=NONE".          " term=NONE"        ."'"
exe "let s:fmt_bold      = ' ".s:vmode."=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_bldi      = ' ".s:vmode."=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_undr      = ' ".s:vmode."=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_undb      = ' ".s:vmode."=NONE".s:u.s:b.  " term=NONE".s:u.s:b."'"
exe "let s:fmt_undi      = ' ".s:vmode."=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_curl      = ' ".s:vmode."=NONE".s:c.      " term=NONE".s:c    ."'"
exe "let s:fmt_ital      = ' ".s:vmode."=NONE".s:i.      " term=NONE".s:i    ."'"
exe "let s:fmt_stnd      = ' ".s:vmode."=NONE".s:s.      " term=NONE".s:s    ."'"
exe "let s:fmt_revr      = ' ".s:vmode."=NONE".s:r.      " term=NONE".s:r    ."'"
exe "let s:fmt_revb      = ' ".s:vmode."=NONE".s:r.s:b.  " term=NONE".s:r.s:b."'"

if has("gui_running")
  exe "let s:sp_none        = ' guisp=".s:none       ."'"
  exe "let s:sp_bg1         = ' guisp=".s:bg1        ."'"
  exe "let s:sp_bg2         = ' guisp=".s:bg2        ."'"
  exe "let s:sp_fg1         = ' guisp=".s:fg1        ."'"
  exe "let s:sp_fg2         = ' guisp=".s:fg2        ."'"
  exe "let s:sp_fga         = ' guisp=".s:fga        ."'"
  exe "let s:sp_fgb         = ' guisp=".s:fgb        ."'"
  exe "let s:sp_red         = ' guisp=".s:red        ."'"
  exe "let s:sp_orange      = ' guisp=".s:orange     ."'"
  exe "let s:sp_yellow      = ' guisp=".s:yellow     ."'"
  exe "let s:sp_green       = ' guisp=".s:green      ."'"
  exe "let s:sp_cyan        = ' guisp=".s:cyan       ."'"
  exe "let s:sp_blue        = ' guisp=".s:blue       ."'"
  exe "let s:sp_purple      = ' guisp=".s:purple     ."'"
  exe "let s:sp_violet      = ' guisp=".s:violet     ."'"
  exe "let s:sp_darkred     = ' guisp=".s:darkred    ."'"
  exe "let s:sp_darkorange  = ' guisp=".s:darkorange ."'"
  exe "let s:sp_darkyellow  = ' guisp=".s:darkyellow ."'"
  exe "let s:sp_darkgreen   = ' guisp=".s:darkgreen  ."'"
  exe "let s:sp_darkcyan    = ' guisp=".s:darkcyan   ."'"
  exe "let s:sp_darkblue    = ' guisp=".s:darkblue   ."'"
  exe "let s:sp_darkpurple  = ' guisp=".s:darkpurple ."'"
  exe "let s:sp_darkviolet  = ' guisp=".s:darkviolet ."'"
  exe "let s:sp_lightred    = ' guisp=".s:lightred   ."'"
  exe "let s:sp_lightorange = ' guisp=".s:lightorange."'"
  exe "let s:sp_lightyellow = ' guisp=".s:lightyellow."'"
  exe "let s:sp_lightgreen  = ' guisp=".s:lightgreen ."'"
  exe "let s:sp_lightcyan   = ' guisp=".s:lightcyan  ."'"
  exe "let s:sp_lightblue   = ' guisp=".s:lightblue  ."'"
  exe "let s:sp_lightpurple = ' guisp=".s:lightpurple."'"
  exe "let s:sp_lightviolet = ' guisp=".s:lightviolet."'"
else
  let s:sp_none        = ""
  let s:sp_bg1         = "" 
  let s:sp_bg2         = "" 
  let s:sp_fg1         = "" 
  let s:sp_fg2         = "" 
  let s:sp_fga         = "" 
  let s:sp_fgb         = "" 
  let s:sp_red         = "" 
  let s:sp_orange      = "" 
  let s:sp_yellow      = "" 
  let s:sp_green       = "" 
  let s:sp_cyan        = "" 
  let s:sp_blue        = "" 
  let s:sp_purple      = "" 
  let s:sp_violet      = "" 
  let s:sp_darkred     = "" 
  let s:sp_darkorange  = "" 
  let s:sp_darkyellow  = "" 
  let s:sp_darkgreen   = "" 
  let s:sp_darkcyan    = "" 
  let s:sp_darkblue    = "" 
  let s:sp_darkpurple  = "" 
  let s:sp_darkviolet  = "" 
  let s:sp_lightred    = "" 
  let s:sp_lightorange = "" 
  let s:sp_lightyellow = "" 
  let s:sp_lightgreen  = "" 
  let s:sp_lightcyan   = "" 
  let s:sp_lightblue   = "" 
  let s:sp_lightpurple = "" 
  let s:sp_lightviolet = "" 
endif

"}}}
" Vim Highlighting: (see :help highlight-groups)"{{{
" ----------------------------------------------------------------------------
exe "hi! ColorColumn"   .s:fg_none        .s:bg_bg2         .s:fmt_none
"		Conceal"
"		Cursor"
"		CursorIM"
exe "hi! CursorColumn"  .s:fg_none        .s:bg_bg2         .s:fmt_none
exe "hi! CursorLine"    .s:fg_none        .s:bg_bg2         .s:fmt_none
exe "hi! Directory"     .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! DiffAdd"       .s:fg_lightgreen  .s:bg_darkgreen   .s:fmt_none
exe "hi! DiffChange"    .s:fg_lightblue   .s:bg_darkblue    .s:fmt_none
exe "hi! DiffDelete"    .s:fg_lightred    .s:bg_darkred     .s:fmt_none
exe "hi! DiffText"      .s:fg_bg1         .s:bg_blue        .s:fmt_none
exe "hi! ErrorMsg"      .s:fg_bg1         .s:bg_red         .s:fmt_stnd
exe "hi! VertSplit"     .s:fg_fgb         .s:bg_none        .s:fmt_none
exe "hi! Folded"        .s:fg_fga         .s:bg_bg1         .s:fmt_none
exe "hi! FoldColumn"    .s:fg_none        .s:bg_bg1         .s:fmt_none
exe "hi! SignColumn"    .s:fg_none        .s:bg_bg1         .s:fmt_none
"		Incsearch"
exe "hi! LineNr"        .s:fg_fgb         .s:bg_none        .s:fmt_none
exe "hi! CursorLineNr"  .s:fg_yellow      .s:bg_none        .s:fmt_bold
exe "hi! MatchParen"    .s:fg_red         .s:bg_none        .s:fmt_undr
exe "hi! ModeMsg"       .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! MoreMsg"       .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! NonText"       .s:fg_fg2         .s:bg_none        .s:fmt_none
exe "hi! Pmenu"         .s:fg_fg2         .s:bg_bg2         .s:fmt_none
exe "hi! PmenuSel"      .s:fg_fg2         .s:bg_bg2         .s:fmt_revr
"		PmenuSbar"
"		PmenuThumb"
exe "hi! Question"      .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! Search"        .s:fg_fg2         .s:bg_lightblue   .s:fmt_none
exe "hi! SpecialKey"    .s:fg_fg2         .s:bg_none        .s:fmt_none
exe "hi! SpellCap"      .s:fg_blue        .s:bg_none        .s:fmt_undr
exe "hi! SpellLocal"    .s:fg_cyan        .s:bg_none        .s:fmt_undr
exe "hi! SpellBad"      .s:fg_red         .s:bg_none        .s:fmt_undr
exe "hi! SpellRare"     .s:fg_purple      .s:bg_none        .s:fmt_undr
exe "hi! StatusLine"    .s:fg_fga         .s:bg_bg1         .s:fmt_revr
exe "hi! StatusLineNC"  .s:fg_fgb         .s:bg_bg2         .s:fmt_revr
exe "hi! TabLine"       .s:fg_fga         .s:bg_bg1         .s:fmt_revr
"		TabLineFill"
"		TabLineSel"
exe "hi! Title"         .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! Visual"        .s:fg_none        .s:bg_bg2         .s:fmt_none
"		VisualNos"
exe "hi! WarningMsg"    .s:fg_red         .s:bg_none        .s:fmt_none
"		WildMenu"

exe "hi! Normal"        .s:fg_fg1         .s:bg_bg1         .s:fmt_none

"}}}
" Generic Syntax Highlighting: (see :help group-name)"{{{
" ----------------------------------------------------------------------------
exe "hi! Comment"         .s:fg_fga         .s:bg_none        .s:fmt_none
exe "hi! SpecialComment"  .s:fg_fga         .s:bg_none        .s:fmt_none

exe "hi! Constant"        .s:fg_lightyellow .s:bg_none        .s:fmt_none
exe "hi! Number"          .s:fg_lightyellow .s:bg_none        .s:fmt_none
exe "hi! Boolean"         .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! Float"           .s:fg_lightyellow .s:bg_none        .s:fmt_none

exe "hi! String"          .s:fg_orange      .s:bg_none        .s:fmt_none
exe "hi! Character"       .s:fg_orange      .s:bg_none        .s:fmt_none

exe "hi! Identifier"      .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! Function"        .s:fg_cyan        .s:bg_none        .s:fmt_none

exe "hi! Statement"       .s:fg_green       .s:bg_none        .s:fmt_none
"		Conditional"
"		Repeat"
"		Label"
exe "hi! Operator"        .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! Keyword"         .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! Exception"       .s:fg_green       .s:bg_none        .s:fmt_none

exe "hi! PreProc"         .s:fg_purple      .s:bg_none        .s:fmt_none
"		Include"
"		Define"
"		Macro"
"		PreCondit"

exe "hi! Type"            .s:fg_green       .s:bg_none        .s:fmt_none
"		StorageClass"
exe "hi! Structure"       .s:fg_green       .s:bg_none        .s:fmt_none
"		Typedef"

exe "hi! Special"         .s:fg_green       .s:bg_none        .s:fmt_none
"		SpecialChar"
"		Tag"
"		Delimiter"
"		Debug"
"
exe "hi! Underlined"      .s:fg_blue        .s:bg_none        .s:fmt_none

exe "hi! Ignore"          .s:fg_none        .s:bg_none        .s:fmt_none

exe "hi! Error"           .s:fg_red         .s:bg_darkred     .s:fmt_undr

exe "hi! Todo"            .s:fg_green       .s:bg_none        .s:fmt_bold

" Quickfix window highlighting
exe "hi! qfLineNr"        .s:fg_yellow      .s:bg_none        .s:fmt_none
"   qfFileName"
"   qfLineNr"
"   qfError"

"}}}
" Diff Syntax Highlighting:"{{{
" ----------------------------------------------------------------------------
" Diff
"		diffOldFile
"		diffNewFile
"		diffFile
"		diffOnly
"		diffIdentical
"		diffDiffer
"		diffBDiffer
"		diffIsA
"		diffNoEOL
"		diffCommon
hi! link diffRemoved Constant
"		diffChanged
hi! link diffAdded Special
"		diffLine
"		diffSubname
"		diffComment

"}}}
" Legal:"{{{
" ----------------------------------------------------------------------------
" Copyright (c) 2011 Ethan Schoonover
" Copyright (c) 2009-2012 NanoTech
" Copyright (c) 2012 w0ng
" Copyright (c) 2015 lpm11
"
" Permission is hereby granted, free of charge, to any per‐
" son obtaining a copy of this software and associated doc‐
" umentation files (the “Software”), to deal in the Soft‐
" ware without restriction, including without limitation
" the rights to use, copy, modify, merge, publish, distrib‐
" ute, sublicense, and/or sell copies of the Software, and
" to permit persons to whom the Software is furnished to do
" so, subject to the following conditions:
"
" The above copyright notice and this permission notice
" shall be included in all copies or substantial portions
" of the Software.
"
" THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY
" KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
" THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICU‐
" LAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
" DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CON‐
" TRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON‐
" NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

" }}}
