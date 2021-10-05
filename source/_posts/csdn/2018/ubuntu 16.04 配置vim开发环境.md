---
title: ubuntu 16.04 配置vim开发环境
date: 2018-08-08 11:18:42
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/81504999)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>一下博客中修改得到：</p> 
<p><a href="http://blog.163.com/023_dns/blog/static/1187273662012125112426472/">http://blog.163.com/023_dns/blog/static/1187273662012125112426472/</a></p> 
<p>首先展示最后配置的效果图</p> 
<p>一步步将vim改造成C/C++开发环境(IDE) - Nealson - Figthing的博客</p> 
<p>1、安装vim和vim的基本插件 <br> 命令：sudo apt-get install vim vim-scripts vim-doc</p> 
<p>vim-scripts是vim的基本插件，语法高亮，缩进等等</p> 
<p>vim-doc是vim帮助文档</p> 
<p>2、基本配置 <br> 在个人目录下新建一个.vimrc的vim配置文件，并粘贴以下内容保存，如果用vim复制粘贴不方便，可以用gedit</p> 
<p>” This line should not be removed as it ensures that various options are <br> ” properly set to work with the Vim-related packages available in Debian. 下面这句如果在ubuntu下要注释掉 <br> ” debian.vim <br> ” Uncomment the next line to make Vim more Vi-compatible <br> ” NOTE: debian.vim sets ‘nocompatible’. Setting ‘compatible’ changes numerous <br> ” options, so any other options should be set AFTER setting ‘compatible’. <br> set nocompatible</p> 
<pre><code>" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on            " 语法高亮
endif
colorscheme ron        " elflord ron peachpuff default 设置配色方案，vim自带的配色方案保存在/usr/share/vim/vim72/colors目录下

" detect file type
filetype on
filetype plugin on
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") &gt; 1 &amp;&amp; line("'\"") &lt;= line("$") | exe "normal! g'\"" | endif
  "have Vim load indentation rules and plugins according to the detected filetype
  filetype plugin indent on
endif
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set ignorecase        " 搜索模式里忽略大小写
"set smartcase        " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项。只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用。
set autowrite        " 自动把内容写回文件: 如果文件被修改过，在每个 :next、:rewind、:last、:first、:previous、:stop、:suspend、:tag、:!、:make、CTRL-] 和 CTRL-^命令时进行；用 :buffer、CTRL-O、CTRL-I、'{A-Z0-9} 或 `{A-Z0-9} 命令转到别的文件时亦然。
set autoindent        " 设置自动对齐(缩进)：即每行的缩进值与上一行相等；使用 noautoindent 取消设置
"set smartindent        " 智能对齐方式
set tabstop=4        " 设置制表符(tab键)的宽度
set softtabstop=4     " 设置软制表符的宽度    
set shiftwidth=4    " (自动) 缩进使用的4个空格
set cindent            " 使用 C/C++ 语言的自动缩进方式
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,&gt;1s,=1s,:1s     "设置C/C++语言的具体缩进方式
"set backspace=2    " 设置退格键可用
set showmatch        " 设置匹配模式，显示匹配的括号
set linebreak        " 整词换行
set whichwrap=b,s,&lt;,&gt;,[,] " 光标从行首和行末时可以跳到另一行去
"set hidden " Hide buffers when they are abandoned
set mouse=a            " Enable mouse usage (all modes)    "使用鼠标
set number            " Enable line number    "显示行号
"set previewwindow    " 标识预览窗口
set history=50        " set command history to 50    "历史记录50条
"--状态行设置--
set laststatus=2 " 总显示最后一个窗口的状态行；设为1则窗口数多于一个的时候显示最后一个窗口的状态行；0不显示最后一个窗口的状态行
set ruler            " 标尺，用于显示光标位置的行号和列号，逗号分隔。每个窗口都有自己的标尺。如果窗口有状态行，标尺在那里显示。否则，它显示在屏幕的最后一行上。
"--命令行设置--
set showcmd            " 命令行显示输入的命令
set showmode        " 命令行显示vim当前模式
"--find setting--
set incsearch        " 输入字符串就显示匹配点
set hlsearch 
set clipboard=unnamed   " 允许vim与系统剪切板交互，当在系统复制了一段代码，允许直接在vim用p命令粘贴
</code></pre> 
<p>注意英语的双引号加空格表示后面的是注释</p> 
<p>3、管理vim插件工具 vim-addon-manager <br> 一般在安装了vim、vim-scripts和vim-doc之后就会安装好，如果没安装，可以用</p> 
<p>命令：sudo apt-get install vim-addon-manager</p> 
<p>进行安装</p> 
<p>如果要查看vim各个插件的状态，可以用</p> 
<p>命令：vim-addons status</p> 
<p>查看</p> 
<p>此外，我们可以利用vim-addon-manager安装官方插件，这里我们先要确定在个人目录下是否有~/.vim/plugin和~/.vim/doc两个目录，如果没有，自己分别新建好，当我们要安装xxx插件时，我们可以用</p> 
<p>命令：vim-addons install xxx</p> 
<p>进行安装</p> 
<p>对于vim-addons的详细用法，可以用</p> 
<p>命令：man vim-addons</p> 
<p>查看帮助文档</p> 
<p>4、安装ctags <br> ctags用于建立源代码树的标签索引，用于快速定位函数，宏定义，变量等</p> 
<p>新安装的ubuntu没有ctags，可以用</p> 
<p>命令：sudo apt-get install ctags</p> 
<p>并在.vimrc文件中添加配置，实现按下F5更新工程中的tags文件</p> 
<pre><code>" *********************** ctags setting  ***********************************
"
" 按下F5重新生成tag文件，并更新taglist
map &lt;F5&gt; :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .&lt;CR&gt;&lt;CR&gt; :TlistUpdate&lt;CR&gt;
imap &lt;F5&gt; &lt;ESC&gt;:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .&lt;CR&gt;&lt;CR&gt; :TlistUpdate&lt;CR&gt;
set tags=tags
set tags+=./tags "add current directory's generated tags file
" set tags+=/usr/include/systags "add new tags file(增加其他路径下的tags，在ctags -R 生成tags文件后，不要将tags移动到别的目录，否则ctrl+］时，会提示找不到源码文件)
</code></pre> 
<p>要实现其他路径的代码索引，必须生成代码的tags的文件，例如要生成标准库的tags文件，步骤为cd到目录/usr/include，然后用 <br> 命令：sudo ctags -R –c++-kinds=+p –fields=+iaS –extra=+q *</p> 
<p>建立该目录以及子目录的索引，其中 * 表示建立该目录及其子目录的索引</p> 
<p>然后我们会发现该目录下多了一个tags文件，并重命名为systags</p> 
<p>为了省去每次建立工程时添加tags文件，可以在.vimrc文件中添加配置命令（上述配置中已经添加）</p> 
<p>set tags+=/usr/include/systags</p> 
<p>这样每次建立工程的时候就会自动添加该路径下的tags文件</p> 
<p>要注意的是，这个tags文件不能随便移动，我试过将这个文件移动到其他地方，发现/usr/include子目录下的文件会找不到</p> 
<p>当我们要查看某个函数的原型时，将光标停留在函数名上，用快捷键ctrl+w+]，就能在vim中增加一个新窗口，并定位到函数的原型上，如果用快捷键ctrl+]，则会在原来的窗口上进行定位，用快捷键ctrl+o，则会返回到原来的代码编辑位置</p> 
<p>5、vim自动补全——OmniCppComplete <br> 用vim-addons安装该插件</p> 
<p>命令：vim-addons install omnicppcomplete</p> 
<p>然后在.vimrc中添加如下配置，设置插件的补全功能</p> 
<pre><code>" 按下F3自动补全代码，注意该映射语句后不能有其他字符，包括tab；否则按下F3会自动补全一些乱码
imap &lt;F3&gt; &lt;C-X&gt;&lt;C-O&gt;
" 按下F2根据头文件内关键字补全
imap &lt;F2&gt; &lt;C-X&gt;&lt;C-I&gt;
set completeopt=menu,menuone " 关掉智能补全时的预览窗口
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with -&gt;
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1 " enable the global scope search
let OmniCpp_DisplayMode=1 " Class scope completion mode: always show all members
"let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_ShowScopeInAbbr=1 " show scope in abbreviation and remove the last column
let OmniCpp_ShowAccess=1 
</code></pre> 
<p>由于该插件的补全功能基于ctags的数据，所以用ctags生成索引的时候要添加额外的参数</p> 
<p>命令：ctags -R –c++-kinds=+p –fields=+iaS –extra=+q</p> 
<p>其中，–c++-kinds=+p : 为C++文件增加函数原型的标签</p> 
<p>–fields=+iaS : 在标签文件中加入继承信息(i)、类成员的访问控制信息(a)、以及函数的指纹(S)</p> 
<p>–extra=+q : 为标签增加类修饰符。注意，如果没有此选项，将不能对类成员补全</p> 
<p>在编写代码时，假如我们要敲printf，此时只要敲prin，然后用快捷键ctrl+x ctrl+o，就能呼出候选函数</p> 
<p>此外，还有常用的快捷键</p> 
<p>当自动补全下拉窗口弹出后，一些可用的快捷键:</p> 
<p>Ctrl+P 向前切换成员</p> 
<p>Ctrl+N 向后切换成员</p> 
<p>Ctrl+E 表示退出下拉窗口, 并退回到原来录入的文字</p> 
<p>Ctrl+Y 表示退出下拉窗口, 并接受当前选项</p> 
<p>其他补全方式:</p> 
<p>Ctrl+X Ctrl+L 整行补全</p> 
<p>Ctrl+X Ctrl+N 根据当前文件里关键字补全</p> 
<p>Ctrl+X Ctrl+K 根据字典补全</p> 
<p>Ctrl+X Ctrl+T 根据同义词字典补全</p> 
<p>Ctrl+X Ctrl+I 根据头文件内关键字补全</p> 
<p>Ctrl+X Ctrl+] 根据标签补全</p> 
<p>Ctrl+X Ctrl+F 补全文件名</p> 
<p>Ctrl+X Ctrl+D 补全宏定义</p> 
<p>Ctrl+X Ctrl+V 补全vim命令</p> 
<p>Ctrl+X Ctrl+U 用户自定义补全方式</p> 
<p>Ctrl+X Ctrl+S 拼写建议</p> 
<p>帮助文档</p> 
<p>:help omnicppcomplete</p> 
<p>6、提示函数原型echofunc <br> echofunc可以在命令行中提示当前输入函数的原型。</p> 
<p>echofunc下载地址：<a href="http://www.vim.org/scripts/script.php?script_id=1735">http://www.vim.org/scripts/script.php?script_id=1735</a></p> 
<p>下载完成后，把echofunc.vim文件放到 ~/.vim/plugin文件夹中</p> 
<p>当你在vim插入(insert)模式下紧接着函数名后输入一个”(“的时候, 这个函数的声明就会自动显示在命令行中。如果这个函数有多个声明, 则可以通过按键”Alt+-“和”Alt+=”向前和向后翻页, 这个两个键可以通过设置g:EchoFuncKeyNext和g:EchoFuncKeyPrev参数来修改。这个插件需要tags文件的支持, 并且在创建tags文件的时候要加选项”–fields=+lS”（OmniCppComplete创建的tag文件也能用）, 整个创建tags文件的命令如下:</p> 
<p>命令：ctags -R –fields=+lS</p> 
<p>7、标签浏览器Taglist <br> Taglist用于列出了当前文件中的所有标签（宏, 全局变量, 函数名等）</p> 
<p>正常来说，按照上述步骤操作，Taglist已经安装到vim中了，如果还没安装，可以用</p> 
<p>命令：vim-addons install taglist</p> 
<p>进行安装</p> 
<p>如果出现：Info: ignoring ‘taglist’ which is neither removed nor broken 的错误，有可能是因为taglist已经安装好了，打开vim，在命令模式下输入</p> 
<p>命令：Tlist</p> 
<p>如果出现标签栏说明已经安装好了，此外还可以使用</p> 
<p>此外，还要在.vimrc里对Taglist进行配置</p> 
<p>let Tlist_Ctags_Cmd=’ctags’ “因为我们放在环境变量里，所以可以直接执行 <br> let Tlist_Use_Right_Window=1 “让窗口显示在右边，0的话就是显示在左边 <br> let Tlist_Show_One_File=0 “让taglist可以同时展示多个文件的函数列表 <br> let Tlist_File_Fold_Auto_Close=1 “非当前文件，函数列表折叠隐藏 <br> let Tlist_Exit_OnlyWindow=1 “当taglist是最后一个分割窗口时，自动推出vim <br> “是否一直处理tags.1:处理;0:不处理 <br> let Tlist_Process_File_Always=1 “实时更新tags <br> let Tlist_Inc_Winwidth=0 <br> 命令：:help taglist.txt</p> 
<p>查看帮助文档</p> 
<p>8、文件浏览器和缓冲区管理器WinManager <br> WinManager用于管理文件浏览器和缓冲区（buffer）。2.0以上版本的WinManager还可以管理其他IDE类型插件，不过要用户在插件中增加一些辅助变量和hook来支持WinManager（帮助文档有相关说明）。</p> 
<p>Taglist插件本身就提供了对WinManager的支持，不需要我们去修改它。这里，我们就用WinManager来管理文件浏览器netrw和标签浏览器Taglist。netrw是标准的vim插件, 已经随vim一起安装进系统里了, 不需要我们自行下载安装。</p> 
<p>安装WinManager，可以用</p> 
<p>命令：vim-addons install winmanager</p> 
<p>配置winmanager可以在.vimrc里面添加配置</p> 
<pre><code>"-- WinManager setting --
let g:winManagerWindowLayout='FileExplorer|TagList' " 设置我们要管理的插件
"let g:persistentBehaviour=0 " 如果所有编辑文件都关闭了，退出vim
nmap wm :WMToggle&lt;cr&gt; 
</code></pre> 
<p>常用命令 <br> :WMToggle 打开/关闭WinManage，不过我们在配置文件.vimrc中做了快捷键映射，所以直接按wm就可以打开/关闭WinManage <br> 文件浏览器命令（在文件浏览器窗口中使用） <br> 或双击 如果光标下是目录, 则进入该目录; 如果光标下文件, 则打开该文件 <br> 如果光标下是目录, 则进入该目录; 如果光标下文件, 则在新窗口打开该文件 <br> 刷新列表 <br> - 返回上一层目录 <br> c 使浏览目录成为vim当前工作目录 <br> d 创建目录 <br> D 删除当前光标下的目录或文件 <br> i 切换显示方式 <br> R 文件或目录重命名 <br> s 选择排序方式 <br> r 反向排序列表 <br> x 定制浏览方式, 使用你指定的程序打开该文件 <br> winmanager帮助文档 <br> :help winmanager <br> netrw帮助文档 <br> :help netrw</p> 
<p>9、buffer管理器MiniBufferExplorer <br> MiniBufferExplorer用于浏览和管理buffer，如果只打开一个文件，是不会显示在屏幕上的，而打开多个文件之后，会自动出现在屏幕上。vim也有自带的buffer管理工具，不过只有:ls, :bnext, :bdelete 等的命令, 既不好用, 又不直观.</p> 
<p>关于vim缓冲区（buffer）和窗口的概念（详见:help windows）</p> 
<p>“缓冲区” 是一块内存区域，里面存储着正在编辑的文件。如果没有把缓冲区里的文件存盘，那么原始文件不会被更改。</p> 
<p>“窗口” 被用来查看缓冲区里的内容。你可以用多个窗口观察同一个缓冲区，也可以用多个窗口观察不同的缓冲区。</p> 
<p>“屏幕” Vim 所用的整个工作区域，可以是一个终端模拟窗口，也被叫做 “Vim 窗口”。一个屏幕包含一个或多个窗口，被状态行和屏幕底部的命令行分割。</p> 
<p>安装该插件可以用（按照上面的步骤下来应该已经装好了，或者vim已经自带了）</p> 
<p>命令：vim-addons install minibufexplorer</p> 
<p>并在.vimrc中添加配置</p> 
<pre><code>" -- MiniBufferExplorer --
let g:miniBufExplMapWindowNavVim = 1 " 按下Ctrl+h/j/k/l，可以切换到当前窗口的上下左右窗口
let g:miniBufExplMapWindowNavArrows = 1 " 按下Ctrl+箭头，可以切换到当前窗口的上下左右窗口
let g:miniBufExplMapCTabSwitchBufs = 1 " 启用以下两个功能：Ctrl+tab移到下一个buffer并在当前窗口打开；Ctrl+Shift+tab移到上一个buffer并在当前窗口打开；ubuntu好像不支持
"let g:miniBufExplMapCTabSwitchWindows = 1 " 启用以下两个功能：Ctrl+tab移到下一个窗口；Ctrl+Shift+tab移到上一个窗口；ubuntu好像不支持
let g:miniBufExplModSelTarget = 1    " 不要在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer
</code></pre> 
<p>常用命令 <br> 移到上一个buffer <br> 移到下一个buffer <br> 打开光标所在的buffer <br> d 删除光标所在的buffer</p> 
<p>10、代码折叠fold <br> 折叠用于把缓冲区内某一范围内的文本行显示为屏幕上的一行。就像一张纸，要它缩短</p> 
<p>些，可以把它折叠起来。</p> 
<p>那些文本仍然在缓冲区内而没有改变。受到折叠影响的只是文本行显示的方式。</p> 
<p>折叠的好处是，通过把多行的一节折叠成带有折叠提示的一行，会使你更好地了解对文本</p> 
<p>的宏观结构。</p> 
<p>折叠方式foldmethod</p> 
<p>vim提供以下6种方法来选定折叠方式：</p> 
<p>manual 手工定义折叠</p> 
<p>indent 更多的缩进表示更高级别的折叠</p> 
<p>expr 用表达式来定义折叠</p> 
<p>syntax 用语法高亮来定义折叠</p> 
<p>diff 对没有更改的文本进行折叠</p> 
<p>marker 对文中的标志折叠</p> 
<p>折叠级别foldlevel</p> 
<p>‘foldlevel’ 是个数值选项：数字越大则打开的折叠更多。</p> 
<p>当 ‘foldlevel’ 为 0 时，所有的折叠关闭。</p> 
<p>当 ‘foldlevel’ 为正数时，一些折叠关闭。</p> 
<p>当 ‘foldlevel’ 很大时，所有的折叠打开。</p> 
<p>折叠栏foldcolumn</p> 
<p>‘foldcolumn’ 是个数字，它设定了在窗口的边上表示折叠的栏的宽度。当为0时，没有折叠栏。最大是12。</p> 
<p>一个打开的折叠由一栏来表示，顶端是 ‘-‘，其下方是 ‘|’。这栏在折叠结束的地方结束。当折叠嵌套时，嵌套的折叠出现在被包含的折叠右方一个字符位置。</p> 
<p>一个关闭的折叠由 ‘+’ 表示。</p> 
<p>当折叠栏太窄而不能显示所有折叠时，显示一数字来表示嵌套的级别。</p> 
<p>在折叠栏点击鼠标，可以打开和关闭折叠：</p> 
<ul><li><p>点击 ‘+’ 打开在这行的关闭折叠</p></li><li><p>在任何其他非空字符上点击，关闭这行上的打开折叠</p></li></ul> 
<p>在vim配置文件/home/user/.vimrc中加入如下的配置：</p> 
<pre><code>set foldmethod=syntax " 用语法高亮来定义折叠
set foldlevel=100 " 启动vim时不要自动折叠代码
set foldcolumn=5 " 设置折叠栏宽度
</code></pre> 
<p>常用命令 <br> za 打开/关闭在光标下的折叠 <br> zA 循环地打开/关闭光标下的折叠 <br> zo 打开 (open) 在光标下的折叠 <br> zO 循环打开 (Open) 光标下的折叠 <br> zc 关闭 (close) 在光标下的折叠 <br> zC 循环关闭 (Close) 在光标下的所有折叠 <br> zM 关闭所有折叠 <br> zR 打开所有的折叠 <br> 帮助文档 <br> :help usr_28.txt <br> :help fold.txt</p> 
<p>11、项目数据管理器Project <br> （其实我还不知道这东西拿来干嘛的，应该是我还没搞过大的工程，所以用不到） Project插件是用来显示项目的目录树的，这个目录树是默认保存在~/.vimprojects文件中。</p> 
<p>安装Project</p> 
<pre><code>    命令：vim-addons install project 
</code></pre> 
<p>Project目录树可以通过下面的步骤生成： <br> 1） 打开vim在命令模式下输入 :Project，在屏幕的最左边就会出现一个project框。不过因为没有初始化暂时是空的 <br> 2）在命令模式下（不是插入模式）输入\C （大写的C），会出现下面这些信息： <br> Enter the Name of the Entry: xxxx （输入项目名称） <br> Enter the Absolute Directory to Load: /xxx/xxx/xxx （输入项目根目录的绝对路径） <br> Enter the CD parameter: . （“.”为当前目录）或者和项目根目录一致 <br> Enter the File Filter: <em>.</em> （符合条件的源文件，可以是<em>.cpp/</em>.h等） <br> PS：项目目录可以嵌套。而且更改之后在~/.vimprojects文件中就能看到内容，你可以手动进行更改。</p> 
<p>Project目录树可以通过下面的步骤生成：</p> 
<p>1） 打开vim在命令模式下输入 :Project，在屏幕的最左边就会出现一个project框。不过因为没有初始化暂时是空的</p> 
<p>2）在命令模式下（不是插入模式）输入\C （大写的C），会出现下面这些信息：</p> 
<p>Enter the Name of the Entry: xxxx （输入项目名称）</p> 
<p>Enter the Absolute Directory to Load: /xxx/xxx/xxx （输入项目根目录的绝对路径）</p> 
<p>Enter the CD parameter: . （“.”为当前目录）或者和项目根目录一致</p> 
<p>Enter the File Filter: <em>.</em> （符合条件的源文件，可以是<em>.cpp/</em>.h等）</p> 
<p>PS：项目目录可以嵌套。而且更改之后在~/.vimprojects文件中就能看到内容，你可以手动进行更改。</p> 
<p>12、quickfix命令集 <br> 通过quickfix命令集，你可在 Vim 内编译程序并直接跳转到出错位置进行修正。你可以接着重新编译并做修正，直到不再出错为止。</p> 
<p>在vim配置文件/home/user/.vimrc中加入如下的配置：</p> 
<pre><code>" 按下F6，执行make clean
map &lt;F6&gt; :make clean&lt;CR&gt;&lt;CR&gt;&lt;CR&gt;
" 按下F7，执行make编译程序，并打开quickfix窗口，显示编译信息
map &lt;F7&gt; :make&lt;CR&gt;&lt;CR&gt;&lt;CR&gt; :copen&lt;CR&gt;&lt;CR&gt;
" 按下F8，光标移到上一个错误所在的行
map &lt;F8&gt; :cp&lt;CR&gt;
" 按下F9，光标移到下一个错误所在的行
map &lt;F9&gt; :cn&lt;CR&gt;
" 以上的映射是使上面的快捷键在插入模式下也能用
imap &lt;F6&gt; &lt;ESC&gt;:make clean&lt;CR&gt;&lt;CR&gt;&lt;CR&gt;
imap &lt;F7&gt; &lt;ESC&gt;:make&lt;CR&gt;&lt;CR&gt;&lt;CR&gt; :copen&lt;CR&gt;&lt;CR&gt;
imap &lt;F8&gt; &lt;ESC&gt;:cp&lt;CR&gt;
imap &lt;F9&gt; &lt;ESC&gt;:cn&lt;CR&gt;
</code></pre> 
<p>帮助文档</p> 
<p>:help usr_30</p> 
<p>:help quickfix</p> 
<p>下面的命令运行 “make” (包括你所给出的参数) 程序并捕捉其运行结果: &gt;</p> 
<p>:make {arguments}</p> 
<p>如果编译时出现错误，按 ，回到vim界面，看不到出错信息了！这时，可以运行以下命令</p> 
<p>:cw[indow]</p> 
<p>打开quickfix窗口来查看出错信息，它会自动跳到第一处出错的地方。然后，你可以双击出错某一条出错信息，vim就会自动跳转到相应的出错位置</p> 
<p>:cn[ext] 光标移到下一个错误所在的行</p> 
<p>:cp[revious] 光标移到上一个错误所在的行</p> 
<p>:cfirst 到第一处错误</p> 
<p>:clast 到最后一处错误</p> 
<p>:cc 空间不够时，Vim 会缩短出错信息。如果你想查看详细信息，可以使用此命令</p> 
<p>:cl[ist] 列出所有出错信息的概览（只有那些含有文件名或行数的错误信息会被显示，需要查看那些并不含文件名或行数的信息可用“:cl[ist]!”命令）</p> 
<p>12、cscope <br> Cscope是一个类似于ctags的工具，不过其功能比ctags强大很多。</p> 
<p>安装Cscope</p> 
<p>命令：sudo apt-get install cscope</p> 
<p>在vim配置文件/home/user/.vimrc中加入如下的配置：</p> 
<pre><code>if has("cscope")
    set csprg=/usr/bin/cscope        " 指定用来执行cscope的命令
    set csto=0                        " 设置cstag命令查找次序：0先找cscope数据库再找标签文件；1先找标签文件再找cscope数据库
    set cst                            " 同时搜索cscope数据库和标签文件
    set cscopequickfix=s-,c-,d-,i-,t-,e-    " 使用QuickFix窗口来显示cscope查找结果
    set nocsverb
    if filereadable("cscope.out")    " 若当前目录下存在cscope数据库，添加该数据库到vim
        cs add cscope.out
    elseif $CSCOPE_DB != ""            " 否则只要环境变量CSCOPE_DB不为空，则添加其指定的数据库到vim
        cs add $CSCOPE_DB
    endif
    set csverb
endif
map &lt;F4&gt; :cs add ./cscope.out .&lt;CR&gt;&lt;CR&gt;&lt;CR&gt; :cs reset&lt;CR&gt;
imap &lt;F4&gt; &lt;ESC&gt;:cs add ./cscope.out .&lt;CR&gt;&lt;CR&gt;&lt;CR&gt; :cs reset&lt;CR&gt;
" 将:cs find c等Cscope查找命令映射为&lt;C-_&gt;c等快捷键（按法是先按Ctrl+Shift+-, 然后很快再按下c）
nmap &lt;C-_&gt;s :cs find s &lt;C-R&gt;=expand("&lt;cword&gt;")&lt;CR&gt;&lt;CR&gt; :copen&lt;CR&gt;&lt;CR&gt;
nmap &lt;C-_&gt;g :cs find g &lt;C-R&gt;=expand("&lt;cword&gt;")&lt;CR&gt;&lt;CR&gt;
nmap &lt;C-_&gt;d :cs find d &lt;C-R&gt;=expand("&lt;cword&gt;")&lt;CR&gt;&lt;CR&gt; :copen&lt;CR&gt;&lt;CR&gt;
nmap &lt;C-_&gt;c :cs find c &lt;C-R&gt;=expand("&lt;cword&gt;")&lt;CR&gt;&lt;CR&gt; :copen&lt;CR&gt;&lt;CR&gt;
nmap &lt;C-_&gt;t :cs find t &lt;C-R&gt;=expand("&lt;cword&gt;")&lt;CR&gt;&lt;CR&gt; :copen&lt;CR&gt;&lt;CR&gt;
nmap &lt;C-_&gt;e :cs find e &lt;C-R&gt;=expand("&lt;cword&gt;")&lt;CR&gt;&lt;CR&gt; :copen&lt;CR&gt;&lt;CR&gt;
nmap &lt;C-_&gt;f :cs find f &lt;C-R&gt;=expand("&lt;cfile&gt;")&lt;CR&gt;&lt;CR&gt;
nmap &lt;C-_&gt;i :cs find i &lt;C-R&gt;=expand("&lt;cfile&gt;")&lt;CR&gt;&lt;CR&gt; :copen&lt;CR&gt;&lt;CR&gt;
</code></pre> 
<p>cscope的主要功能是通过其”find”子命令来实现的</p> 
<p>“cscope find”的用法:</p> 
<p>cs find c|d|e|f|g|i|s|t name</p> 
<p>0 或 s 查找这个 C 符号(可以跳过注释)</p> 
<p>1 或 g 查找这个定义</p> 
<p>2 或 d 查找这个函数调用的函数</p> 
<p>3 或 c 查找调用过这个函数的函数</p> 
<p>4 或 t 查找这个字符串</p> 
<p>6 或 e 查找这个 egrep 模式</p> 
<p>7 或 f 查找这个文件</p> 
<p>8 或 i 查找包含这个文件的文件</p> 
<p>用法：</p> 
<p>&lt;1&gt;、为源码建立一个cscope数据库</p> 
<p>lingd@ubuntu:~/arm/linux-2.6.28.7$ cscope -Rbq</p> 
<p>lingd@ubuntu:~/arm/linux-2.6.28.7$ ls cscope.*</p> 
<p>cscope.in.out cscope.out cscope.po.out</p> 
<p>&lt;2&gt;、用vim打开某个源码文件，末行模式下，输入“:cs add cscope.out”（该命令已被我们映射为快捷键F4），添加cscope数据库到vim。因为我们已将vim配置为启动时，自动添加当前目录下的cscope数据库，所以你再添加该cscope数据库时，vim会提示“重复cscope数据库 未被加入“</p> 
<p>&lt;3&gt;、完成前两步后，现在就可以用“cs find c”等Cscope查找命令查找关键字了。我们已在.vimrc中将“cs find c”等Cscope查找命令映射为c等快捷键（按法是先按Ctrl+Shift+-, 然后很快按下c）</p> 
<p>帮助文档</p> 
<p>:help if_cscop</p> 
<p>注意：帮助文档if_cscop中，快捷键映射nmap i :cs find i ^=expand(“”)$是有误的！</p> 
<p>比如光标“header.h”上按下i，也就是查找包含“header.h“的文件。但是按照这个映射规则，则是将i映射为cs find i ^header.h<span class="MathJax_Preview" style="color: inherit; display: none;"></span><span class="MathJax" id="MathJax-Element-13-Frame" tabindex="0" style="position: relative;">
  
   <span class="math" id="MathJax-Span-1185" style="width: 13.023em; display: inline-block;"><span style="display: inline-block; position: relative; width: 10.836em; height: 0px; font-size: 120%;"><span style="position: absolute; clip: rect(1.513em, 1010.84em, 2.867em, -999.997em); top: -2.497em; left: 0em;"><span class="mrow" id="MathJax-Span-1186"><span class="texatom" id="MathJax-Span-1187"><span class="mrow" id="MathJax-Span-1188"><span class="mo" id="MathJax-Span-1189"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 83%; font-style: normal; font-weight: normal;">，</span></span></span></span><span class="texatom" id="MathJax-Span-1190"><span class="mrow" id="MathJax-Span-1191"><span class="mo" id="MathJax-Span-1192"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 83%; font-style: normal; font-weight: normal;">也</span></span></span></span><span class="texatom" id="MathJax-Span-1193"><span class="mrow" id="MathJax-Span-1194"><span class="mo" id="MathJax-Span-1195"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 83%; font-style: normal; font-weight: normal;">就</span></span></span></span><span class="texatom" id="MathJax-Span-1196"><span class="mrow" id="MathJax-Span-1197"><span class="mo" id="MathJax-Span-1198"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 83%; font-style: normal; font-weight: normal;">是</span></span></span></span><span class="texatom" id="MathJax-Span-1199"><span class="mrow" id="MathJax-Span-1200"><span class="mo" id="MathJax-Span-1201"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 83%; font-style: normal; font-weight: normal;">查</span></span></span></span><span class="texatom" id="MathJax-Span-1202"><span class="mrow" id="MathJax-Span-1203"><span class="mo" id="MathJax-Span-1204"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 83%; font-style: normal; font-weight: normal;">找</span></span></span></span><span class="texatom" id="MathJax-Span-1205"><span class="mrow" id="MathJax-Span-1206"><span class="mo" id="MathJax-Span-1207"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 83%; font-style: normal; font-weight: normal;">包</span></span></span></span><span class="texatom" id="MathJax-Span-1208"><span class="mrow" id="MathJax-Span-1209"><span class="mo" id="MathJax-Span-1210"><span style="font-family: STIXGeneral, &quot;Arial Unicode MS&quot;, serif; font-size: 83%; font-style: normal; font-weight: normal;">含</span></span></span></span><span class="msubsup" id="MathJax-Span-1211"><span style="display: inline-block; position: relative; width: 0.888em; height: 0px;"><span style="position: absolute; clip: rect(3.18em, 1000.42em, 3.753em, -999.997em); top: -4.008em; left: 0em;"><span class="mo" id="MathJax-Span-1212" style="font-family: STIXGeneral-Regular;">“</span><span style="display: inline-block; width: 0px; height: 4.013em;"></span></span><span style="position: absolute; top: -4.372em; left: 0.471em;"><span class="mi" id="MathJax-Span-1213" style="font-size: 70.7%; font-family: STIXGeneral-Italic;">h</span><span style="display: inline-block; width: 0px; height: 4.013em;"></span></span></span></span><span class="mi" id="MathJax-Span-1214" style="font-family: STIXGeneral-Italic;">e</span><span class="mi" id="MathJax-Span-1215" style="font-family: STIXGeneral-Italic;">a</span><span class="mi" id="MathJax-Span-1216" style="font-family: STIXGeneral-Italic;">d<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.055em;"></span></span><span class="mi" id="MathJax-Span-1217" style="font-family: STIXGeneral-Italic;">e</span><span class="mi" id="MathJax-Span-1218" style="font-family: STIXGeneral-Italic;">r<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.003em;"></span></span><span class="mo" id="MathJax-Span-1219" style="font-family: STIXGeneral-Regular;">.</span><span class="mi" id="MathJax-Span-1220" style="font-family: STIXGeneral-Italic; padding-left: 0.211em;">h</span></span><span style="display: inline-block; width: 0px; height: 2.503em;"></span></span></span><span style="display: inline-block; overflow: hidden; vertical-align: -0.309em; border-left: 0px solid; width: 0px; height: 1.378em;"></span></span>
  <span class="MJX_Assistive_MathML">
   
    
     
      ，
     
    
    
     
      也
     
    
    
     
      就
     
    
    
     
      是
     
    
    
     
      查
     
    
    
     
      找
     
    
    
     
      包
     
    
    
     
      含
     
    
    
     
      “
     
     
      h
     
    
    
     e
    
    
     a
    
    
     d
    
    
     e
    
    
     r
    
    
     .
    
    
     h
    
   </span></span><script type="math/tex" id="MathJax-Element-13">，也就是查找包含“^header.h</script>“的文件，这显然不是我们想要的结果。该映射规则应该改成nmap i :cs find i =expand(“”)</p> 
<p>14、快捷键汇总 <br> 根据上面的配置 F2-F9 按键的功能为：</p> 
<p>F2：根据头文件内关键字进行补全</p> 
<p>F3：自动补全代码</p> 
<p>F4：添加cscope数据库到vim</p> 
<p>F5：更新当前目录下的tags文件</p> 
<p>F6：执行make clean命令</p> 
<p>F7：执行make命令</p> 
<p>F8：编译错误时移动到上一个错误</p> 
<p>F9：编译错误时移动到下一个错误</p> 
<p>vim常用快捷键（一般模式下）</p> 
<p>shift+v：视图模式</p> 
<p>gg：光标移动到文档开头</p> 
<p>G：光标移动到最后一行开头</p> 
<p>shift+$：移动到该行的末尾</p> 
<p>i：进入插入模式（光标前位置进行插入）</p> 
<p>a：进入插入模式（光标后位置进行插入）</p> 
<p>o：在光标下新建一行并进入插入模式</p> 
<p>O：在光标上新建一行并进入插入模式</p> 
<p>I：在该行行尾进入插入模式</p> 
<p>A：在该行行首进入插入模式</p> 
<p>y：复制到vim剪切板</p> 
<p>p：从vim剪切板拷贝</p> 
<p>“+y：复制到系统剪切板</p> 
<p>“+p：从系统剪切板进行复制</p> 
<p>u：撤销上一步操作</p> 
<p>ctrl+r：恢复上一步撤销</p> 
<p>j/k/h/l：光标上/下/左/右移动</p> 
<p>dd：删除整行</p> 
<p>如果重装系统怎么办？重新配置？怎么可能！我已经将配置文件上传到百度云了！</p> 
<p><a href="http://pan.baidu.com/s/1i5oRFHb">http://pan.baidu.com/s/1i5oRFHb</a></p>
                
{% endraw %}
