# melanite
Yet another dark color scheme.

## Previews
### Atom
![melanite Preview (Atom)](https://raw.githubusercontent.com/lpm11/melanite/master/previews/atom-python.png)

### Visual Studio
![melanite Preview (Visual Studio)](https://raw.githubusercontent.com/lpm11/melanite/master/previews/visualstudio.png)

### LimeChat (OS X)
![melanite Preview (LimeChat (OSX))](https://raw.githubusercontent.com/lpm11/melanite/master/previews/limechat-osx.png)

### iTerm2
![melanite Preview (iTerm2)](https://raw.githubusercontent.com/lpm11/melanite/master/previews/iterm2.png)

## Installation
### Atom
1. Open the "Settings" window, then select "Themes".
2. Search theme by "melanite".
3. Press "Install".

### Visual Studio
1. Download theme file from the following url:
https://raw.githubusercontent.com/lpm11/melanite/master/schemes/visualstudio/melanite.vssettings
2. Follow the instructions at http://studiostyl.es/home/faq to import the theme.

### LimeChat (OS X)
1. Download theme files into `~/Library/Application Support/LimeChat/Themes`.
```bash
cd ~/Library/Application Support/LimeChat/Themes
curl -O https://raw.githubusercontent.com/lpm11/melanite/master/schemes/limechat-osx/Melanite.css
curl -O https://raw.githubusercontent.com/lpm11/melanite/master/schemes/limechat-osx/Melanite.yaml
```
2. Open the preferences window, then select "Theme" and change Current theme.

### iTerm2
1. Download theme file from the following url:
https://raw.githubusercontent.com/lpm11/melanite/master/schemes/iterm2/melanite.itermcolors
2. Open the file you have downloaded.
3. Open the preferences window, then select "Profile" and you can find the melanite theme.
4. Accent colors are too bright? You might want to try darken version:
https://raw.githubusercontent.com/lpm11/melanite/master/schemes/iterm2/melanite-darken05.itermcolors
https://raw.githubusercontent.com/lpm11/melanite/master/schemes/iterm2/melanite-darken10.itermcolors

### TeXShop
1. Download theme applier script from the following url:
https://raw.githubusercontent.com/lpm11/melanite/master/schemes/texshop/melanite-texshop.sh
2. Execute script you have downloaded.
3. If you want to reset, follow the instructions at the following url:
https://github.com/altercation/solarized/issues/167

## The values
```
MELANITE RGBHEX  CIE L*a*b*  ANSI-256 description
-------- ------- ----------- -------- ---------------------
bg1      #222728  15  -2  -2   16     background
bg2      #42484a  30  -2  -2   59     background highlights
fgb      #686b6c  45  -1  -1   59     thirdly content (multiple-line comments)
fga      #757879  50  -1  -1  102     secondly content (comments)
fg1      #c4c7c8  80  -1  -1  188     primary content
fg2      #e0e3e4  90  -1  -1  189*    optional emphasized content

MELANITE RGBHEX  CIE LCH     ANSI-256
-------- ------- ----------- --------
red      #ff72a4  70  65   5  205
orange   #f69113  70  80  65  208
yellow   #b9ad00  70  80  95  142
green    #83ba54  70  55 125  107
cyan     #00c1b0  70  45 185   37
blue     #80b2d4  70  25 245  110
purple   #c09cef  70  45 305  147
violet   #f186d7  70  55 335  212
```

### Color table by various L* lightness
|  H＼L  |      50 |      55 |      60 |      65 |      70 |      75 |      80 |      85 |      90 |
| ------ | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- |
|    red | #d53571 | #e5457d | #f4548a | #ff6397 | #ff72a4 | #ff80b2 | #ff8fbf | #ff9dcd | #ffabdb |
| orange | #b85d00 | #c76a00 | #d77700 | #e68400 | #f69113 | #ff9e26 | #ffac36 | #ffba44 | #ffc852 |
| yellow | #807900 | #8e8600 | #9d9300 | #aba000 | #b9ad00 | #c8bb00 | #d7c800 | #e6d620 | #f5e434 |
|  green | #4e841f | #5b912d | #699f3a | #76ac47 | #83ba54 | #91c861 | #9fd66e | #ade47b | #bbf288 |
|   cyan | #008a7c | #009889 | #00a596 | #00b3a3 | #00c1b0 | #29cfbe | #40ddcc | #53ebda | #64fae8 |
|   blue | #4b7d9d | #588aaa | #6697b8 | #73a5c6 | #80b2d4 | #8ec0e2 | #9ccef0 | #aadcff | #b8eaff |
| purple | #8968b6 | #9775c4 | #a482d2 | #b28fe0 | #c09cef | #cea9fd | #dcb7ff | #ebc5ff | #f9d3ff |
| violet | #b750a0 | #c65dad | #d46bbb | #e378c9 | #f186d7 | #ff93e5 | #ffa1f3 | #ffafff | #ffbdff |

## ANSI-16 compatible values
```
ANSI-16   MELANITE RGBHEX  L*
--------- -------- ------- ---
black     bg1      #222728
brblack   bg2      #42484a
red       red      #f4548a
brred     red*     #ff72a4  80
green     green    #83ba54
brgreen   green*   #9fd66e  80
yellow    yellow   #b9ad00
bryellow  yellow*  #d7c800  80
blue      blue     #80b2d4
brblue    blue*    #9ccef0  80
magenta   violet   #d46bbb
brmagenta violet*  #f186d7  80
cyan      cyan     #00c1b0
brcyan    cyan*    #40ddcc  80
white     fg1      #c4c7c8
brwhite   fg2      #e0e3e4
```

## Base16 compatible values
```
base16 MELANITE RGBHEX   L*
------ -------- -------- ---
base00 bg1      #222728   15
base01 N/A      #2c3133   20
base02 bg2      #42484a   30
base03 fga      #757879   50
base04 N/A      #a9acad   70
base05 fg1      #c4c7c8   80
base06 fg2      #e0e3e4   90
base07 N/A      #f7fafb   98
base08 red*     #ff6397   65
base09 orange*  #ff9e26   75
base0A yellow*  #e6d620   85
base0B green    #83ba54   70
base0C cyan     #00c1b0   70
base0D blue     #80b2d4   70
base0E purple   #c09cef   70
base0F violet*  #c65dad   55
```

![melanite Preview (base16)](https://raw.githubusercontent.com/lpm11/melanite/master/previews/base16.png)

## Base16 light theme
Light theme is not well-tested, these are tentative values.

```
base16 MELANITE RGBHEX   L* (a*b*)
------ -------- -------- -----------
base00 bg1      #222728   15  -2  -2
base01 N/A      #2c3133   20  -2  -2
base02 bg2*     #444748   30  -1  -1
base03 fga      #757879   50  -1  -1
base04 N/A      #a9acad   70  -1  -1
base05 fg1      #c4c7c8   80  -1  -1
base06 fg2*     #e9e2cf   90   0  10
base07 N/A      #fff9e6   98   0  10
base08 red*     #e5457d   55
base09 orange*  #e68400   65
base0A yellow   #b9ad00   70
base0B green*   #699f3a   60
base0C cyan*    #008a7c   50
base0D blue*    #6697b8   60
base0E purple*  #a482d2   60
base0F violet*  #c65dad   55
```

![melanite-light Preview (base16)](https://raw.githubusercontent.com/lpm11/melanite/master/previews/base16-light.png)
