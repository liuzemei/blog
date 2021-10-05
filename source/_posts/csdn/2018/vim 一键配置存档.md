---
title: vim 一键配置存档
date: 2018-09-12 11:21:22
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/82658719)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <pre class="prettyprint"><code class=" hljs bash"><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span>
<span class="hljs-string">" 显示相关  
"</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">"
"</span><span class="hljs-keyword">set</span> shortmess=atI   <span class="hljs-string">" 启动的时候不显示那个援助乌干达儿童的提示  
"</span>winpos <span class="hljs-number">5</span> <span class="hljs-number">5</span>          <span class="hljs-string">" 设定窗口位置  
"</span><span class="hljs-keyword">set</span> lines=<span class="hljs-number">40</span> columns=<span class="hljs-number">155</span>    <span class="hljs-string">" 设定窗口大小  
"</span><span class="hljs-keyword">set</span> nu              <span class="hljs-string">" 显示行号  
set go=             "</span> 不要图形按钮  
<span class="hljs-string">"color asmanian2     "</span> 设置背景主题  
<span class="hljs-keyword">set</span> guifont=Courier_New:h10:cANSI   <span class="hljs-string">" 设置字体  
"</span>syntax on           <span class="hljs-string">" 语法高亮  
autocmd InsertLeave * se nocul  "</span> 用浅色高亮当前行  
autocmd InsertEnter * se cul    <span class="hljs-string">" 用浅色高亮当前行  
"</span><span class="hljs-keyword">set</span> ruler           <span class="hljs-string">" 显示标尺  
set showcmd         "</span> 输入的命令显示出来，看的清楚些  
<span class="hljs-string">"set cmdheight=1     "</span> 命令行（在状态行下）的高度，设置为<span class="hljs-number">1</span>  
<span class="hljs-string">"set whichwrap+=&lt;,&gt;,h,l   "</span> 允许backspace和光标键跨越行边界(不建议)  
<span class="hljs-string">"set scrolloff=3     "</span> 光标移动到buffer的顶部和底部时保持<span class="hljs-number">3</span>行距离  
<span class="hljs-keyword">set</span> novisualbell    <span class="hljs-string">" 不要闪烁(不明白)  
set statusline=%F%m%r%h%w\ [FORMAT=%{&amp;ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "</span>状态行显示的内容  
<span class="hljs-keyword">set</span> laststatus=<span class="hljs-number">1</span>    <span class="hljs-string">" 启动显示状态行(1),总是显示状态行(2)  
set foldenable      "</span> 允许折叠  
<span class="hljs-keyword">set</span> foldmethod=manual   <span class="hljs-string">" 手动折叠  
"</span><span class="hljs-keyword">set</span> background=dark <span class="hljs-string">"背景使用黑色 
set nocompatible  "</span>去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  

<span class="hljs-string">" 显示中文帮助
if version &gt;= 603
    set helplang=cn
    set encoding=utf-8
endif
"</span> 设置配色方案
<span class="hljs-string">"colorscheme murphy
"</span>字体 
<span class="hljs-string">"if (has("</span>gui_running<span class="hljs-string">")) 
"</span>   <span class="hljs-keyword">set</span> guifont=Bitstream\ Vera\ Sans\ Mono\ <span class="hljs-number">10</span> 
<span class="hljs-string">"endif 
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
"</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span>
<span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">"新文件标题"</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">"
"</span>新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java <span class="hljs-keyword">exec</span> <span class="hljs-string">":call SetTitle()"</span> 
<span class="hljs-string">""</span>定义函数SetTitle，自动插入文件头 
func SetTitle() 
    <span class="hljs-string">"如果文件类型为.sh文件 
    if &amp;filetype == 'sh' 
        call setline(1,"</span>\<span class="hljs-comment">#########################################################################") </span>
        call append(line(<span class="hljs-string">"."</span>), <span class="hljs-string">"\# File Name: "</span>.expand(<span class="hljs-string">"%"</span>)) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">1</span>, <span class="hljs-string">"\# Author: Neo"</span>) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">2</span>, <span class="hljs-string">"\# mail: Neooosky@gmail.com"</span>) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">3</span>, <span class="hljs-string">"\# Created Time: "</span>.strftime(<span class="hljs-string">"%c"</span>)) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">4</span>, <span class="hljs-string">"\#########################################################################"</span>) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">5</span>, <span class="hljs-string">"\#!/bin/bash"</span>) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">6</span>, <span class="hljs-string">""</span>) 
    <span class="hljs-keyword">else</span> 
        call setline(<span class="hljs-number">1</span>, <span class="hljs-string">"/*************************************************************************"</span>) 
        call append(line(<span class="hljs-string">"."</span>), <span class="hljs-string">"    &gt; File Name: "</span>.expand(<span class="hljs-string">"%"</span>)) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">1</span>, <span class="hljs-string">"    &gt; Author: Neo"</span>) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">2</span>, <span class="hljs-string">"    &gt; Mail: Neooosky@gmail.com "</span>) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">3</span>, <span class="hljs-string">"    &gt; Created Time: "</span>.strftime(<span class="hljs-string">"%c"</span>)) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">4</span>, <span class="hljs-string">" ************************************************************************/"</span>) 
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">5</span>, <span class="hljs-string">""</span>)
    endif

    <span class="hljs-keyword">if</span> &amp;filetype == <span class="hljs-string">'cpp'</span>
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">6</span>, <span class="hljs-string">"#include&lt;iostream&gt;"</span>)
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">7</span>, <span class="hljs-string">"using namespace std;"</span>)
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">8</span>, <span class="hljs-string">""</span>)
    endif

    <span class="hljs-keyword">if</span> &amp;filetype == <span class="hljs-string">'c'</span>
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">6</span>, <span class="hljs-string">"#include&lt;stdio.h&gt;"</span>)
        call append(line(<span class="hljs-string">"."</span>)+<span class="hljs-number">7</span>, <span class="hljs-string">""</span>)
    endif

    <span class="hljs-string">"新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc 
"</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">"
"</span>键盘命令
<span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span>
nmap &lt;leader&gt;w :w!&lt;cr&gt;
nmap &lt;leader&gt;f :find&lt;cr&gt;
<span class="hljs-string">" 映射全选+复制 ctrl+a
map &lt;C-A&gt; ggVGY
map! &lt;C-A&gt; &lt;Esc&gt;ggVGY
map &lt;F12&gt; gg=G
"</span> 选中状态下 Ctrl+c 复制
vmap &lt;C-c&gt; <span class="hljs-string">"+y
"</span>去空行  
nnoremap &lt;F2&gt; :g/^\s*$/d&lt;CR&gt; 

<span class="hljs-string">"比较文件  
nnoremap &lt;C-F2&gt; :vert diffsplit 
"</span>新建标签  
map &lt;M-F2&gt; :tabnew&lt;CR&gt;  

<span class="hljs-string">"列出当前目录文件  
map &lt;F3&gt; :tabnew .&lt;CR&gt;  
"</span>打开树状文件目录  
map &lt;C-F3&gt; \be  
<span class="hljs-string">"C，C++ 按F5编译运行
map &lt;F5&gt; :call CompileRunGcc()&lt;CR&gt;
func! CompileRunGcc()
    exec "</span>w<span class="hljs-string">"
    if &amp;filetype == 'c'
        exec "</span>!g++ % -o %&lt;<span class="hljs-string">"
        exec "</span>! ./%&lt;<span class="hljs-string">"
    elseif &amp;filetype == 'cpp'
        exec "</span>!g++ % -o %&lt;<span class="hljs-string">"
        exec "</span>! ./%&lt;<span class="hljs-string">"
    elseif &amp;filetype == 'java' 
        exec "</span>!javac %<span class="hljs-string">" 
        exec "</span>!java %&lt;<span class="hljs-string">"
    elseif &amp;filetype == 'sh'
        :!./%
    endif
endfunc
"</span>C,C++的调试
map &lt;F8&gt; :call Rungdb()&lt;CR&gt;
func! Rungdb()
    <span class="hljs-keyword">exec</span> <span class="hljs-string">"w"</span>
    <span class="hljs-keyword">exec</span> <span class="hljs-string">"!g++ % -g -o %&lt;"</span>
    <span class="hljs-keyword">exec</span> <span class="hljs-string">"!gdb ./%&lt;"</span>
endfunc

<span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span>
<span class="hljs-string">""</span>实用设置
<span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">"
"</span> 设置当文件被改动时自动载入
<span class="hljs-keyword">set</span> autoread
<span class="hljs-string">" quickfix模式
autocmd FileType c,cpp map &lt;buffer&gt; &lt;leader&gt;&lt;space&gt; :w&lt;cr&gt;:make&lt;cr&gt;
"</span>代码补全 
<span class="hljs-keyword">set</span> completeopt=preview,menu 

<span class="hljs-string">"允许插件  
filetype plugin on
"</span>共享剪贴板  
<span class="hljs-keyword">set</span> clipboard+=unnamed 

<span class="hljs-string">"从不备份  
set nobackup
"</span>make 运行
:<span class="hljs-keyword">set</span> makeprg=g++\ -Wall\ \ %

<span class="hljs-string">"自动保存
set autowrite
set ruler                   "</span> 打开状态栏标尺
<span class="hljs-keyword">set</span> cursorline              <span class="hljs-string">" 突出显示当前行
set magic                   "</span> 设置魔术
<span class="hljs-keyword">set</span> guioptions-=T           <span class="hljs-string">" 隐藏工具栏
set guioptions-=m           "</span> 隐藏菜单栏
<span class="hljs-string">"set statusline=\ %&lt;%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&amp;fileformat}\ %{&amp;encoding}\ %c:%l/%L%)\
"</span> 设置在状态行显示的信息
<span class="hljs-keyword">set</span> foldcolumn=<span class="hljs-number">0</span>
<span class="hljs-keyword">set</span> foldmethod=indent 
<span class="hljs-keyword">set</span> foldlevel=<span class="hljs-number">3</span> 
<span class="hljs-keyword">set</span> foldenable              <span class="hljs-string">" 开始折叠
"</span> 不要使用vi的键盘模式，而是vim自己的
<span class="hljs-keyword">set</span> nocompatible

<span class="hljs-string">" 语法高亮
set syntax=on
"</span> 去掉输入错误的提示声音
<span class="hljs-keyword">set</span> noeb

<span class="hljs-string">" 在处理未保存或只读文件的时候，弹出确认
set confirm
"</span> 自动缩进
<span class="hljs-keyword">set</span> autoindent
<span class="hljs-keyword">set</span> cindent

<span class="hljs-string">" Tab键的宽度
set tabstop=4
"</span> 统一缩进为<span class="hljs-number">4</span>
<span class="hljs-keyword">set</span> softtabstop=<span class="hljs-number">4</span>
<span class="hljs-keyword">set</span> shiftwidth=<span class="hljs-number">4</span>

<span class="hljs-string">" 不要用空格代替制表符
set noexpandtab
"</span> 在行和段开始处使用制表符
<span class="hljs-keyword">set</span> smarttab

<span class="hljs-string">" 显示行号
set number
"</span> 历史记录数
<span class="hljs-keyword">set</span> history=<span class="hljs-number">1000</span>

<span class="hljs-string">"禁止生成临时文件
set nobackup
set noswapfile
"</span>搜索忽略大小写
<span class="hljs-keyword">set</span> ignorecase

<span class="hljs-string">"搜索逐字符高亮
set hlsearch
set incsearch
"</span>行内替换
<span class="hljs-keyword">set</span> gdefault

<span class="hljs-string">"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"</span>语言设置
<span class="hljs-keyword">set</span> langmenu=zh_CN.UTF-<span class="hljs-number">8</span>
<span class="hljs-keyword">set</span> helplang=cn

<span class="hljs-string">" 我的状态行显示的内容（包括文件类型和解码）
"</span><span class="hljs-keyword">set</span> statusline=%F%m%r%h%w\ [FORMAT=%{&amp;ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\<span class="hljs-string">"%d/%m/%y\ -\ %H:%M\")}
"</span><span class="hljs-keyword">set</span> statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

<span class="hljs-string">" 总是显示状态行
set laststatus=2
"</span> 命令行（在状态行下）的高度，默认为<span class="hljs-number">1</span>，这里是<span class="hljs-number">2</span>
<span class="hljs-keyword">set</span> cmdheight=<span class="hljs-number">2</span>

<span class="hljs-string">" 侦测文件类型
filetype on
"</span> 载入文件类型插件
filetype plugin on

<span class="hljs-string">" 为特定文件类型载入相关缩进文件
filetype indent on
"</span> 保存全局变量
<span class="hljs-keyword">set</span> viminfo+=!

<span class="hljs-string">" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
"</span> 字符间插入的像素行数目
<span class="hljs-keyword">set</span> linespace=<span class="hljs-number">0</span>

<span class="hljs-string">" 增强模式中的命令行自动完成操作
set wildmenu
"</span> 使回格键（backspace）正常处理indent, eol, start等
<span class="hljs-keyword">set</span> backspace=<span class="hljs-number">2</span>

<span class="hljs-string">" 允许backspace和光标键跨越行边界
set whichwrap+=&lt;,&gt;,h,l
"</span> 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
<span class="hljs-keyword">set</span> mouse=a
<span class="hljs-keyword">set</span> selection=exclusive
<span class="hljs-keyword">set</span> selectmode=mouse,key

<span class="hljs-string">" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
"</span> 在被分割的窗口间显示空白，便于阅读
<span class="hljs-keyword">set</span> fillchars=vert:\ ,stl:\ ,stlnc:\

<span class="hljs-string">" 高亮显示匹配的括号
set showmatch
"</span> 匹配括号高亮的时间（单位是十分之一秒）
<span class="hljs-keyword">set</span> matchtime=<span class="hljs-number">1</span>

<span class="hljs-string">" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
"</span> 为C程序提供自动缩进
<span class="hljs-keyword">set</span> smartindent

<span class="hljs-string">" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt
"</span>自动补全
:inoremap ( ()&lt;ESC&gt;i
:inoremap ) &lt;c-r&gt;=ClosePair(<span class="hljs-string">')'</span>)&lt;CR&gt;
:inoremap { {&lt;CR&gt;}&lt;ESC&gt;O
:inoremap } &lt;c-r&gt;=ClosePair(<span class="hljs-string">'}'</span>)&lt;CR&gt;
:inoremap [ []&lt;ESC&gt;i
:inoremap ] &lt;c-r&gt;=ClosePair(<span class="hljs-string">']'</span>)&lt;CR&gt;
:inoremap <span class="hljs-string">" "</span><span class="hljs-string">"&lt;ESC&gt;i
:inoremap ' ''&lt;ESC&gt;i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "</span>\&lt;Right&gt;<span class="hljs-string">"
    else
        return a:char
    endif
endfunction
filetype plugin indent on 
"</span>打开文件类型检测, 加了这句才可以用智能补全
<span class="hljs-keyword">set</span> completeopt=longest,menu

<span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">"
"</span> CTags的设定  
<span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">"
let Tlist_Sort_Type = "</span>name<span class="hljs-string">"    "</span> 按照名称排序  
<span class="hljs-built_in">let</span> Tlist_Use_Right_Window = <span class="hljs-number">1</span>  <span class="hljs-string">" 在右侧显示窗口  
let Tlist_Compart_Format = 1    "</span> 压缩方式  
<span class="hljs-built_in">let</span> Tlist_Exist_OnlyWindow = <span class="hljs-number">1</span>  <span class="hljs-string">" 如果只有一个buffer，kill窗口也kill掉buffer  
let Tlist_File_Fold_Auto_Close = 0  "</span> 不要关闭其他文件的tags  
<span class="hljs-built_in">let</span> Tlist_Enable_Fold_Column = <span class="hljs-number">0</span>    <span class="hljs-string">" 不要显示折叠树  
autocmd FileType java set tags+=D:\tools\java\tags  
"</span>autocmd FileType h,cpp,cc,c <span class="hljs-keyword">set</span> tags+=D:\tools\cpp\tags  
<span class="hljs-string">"let Tlist_Show_One_File=1            "</span>不同时显示多个文件的tag，只显示当前文件的

<span class="hljs-string">"设置tags  
set tags=tags  
"</span><span class="hljs-keyword">set</span> autochdir 

<span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span>
<span class="hljs-string">"其他东东
"</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span>

<span class="hljs-string">"默认打开Taglist 
let Tlist_Auto_Open=1 
"</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">" 
"</span> Tag list (ctags) 
<span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span><span class="hljs-string">""</span> 
<span class="hljs-built_in">let</span> Tlist_Ctags_Cmd = <span class="hljs-string">'/usr/bin/ctags'</span> 
<span class="hljs-built_in">let</span> Tlist_Show_One_File = <span class="hljs-number">1</span> <span class="hljs-string">"不同时显示多个文件的tag，只显示当前文件的 
let Tlist_Exit_OnlyWindow = 1 "</span>如果taglist窗口是最后一个窗口，则退出vim 
<span class="hljs-built_in">let</span> Tlist_Use_Right_Window = <span class="hljs-number">1</span> <span class="hljs-string">"在右侧窗口中显示taglist窗口
"</span> minibufexpl插件的一般设置
<span class="hljs-built_in">let</span> g:miniBufExplMapWindowNavVim = <span class="hljs-number">1</span>
<span class="hljs-built_in">let</span> g:miniBufExplMapWindowNavArrows = <span class="hljs-number">1</span>
<span class="hljs-built_in">let</span> g:miniBufExplMapCTabSwitchBufs = <span class="hljs-number">1</span>
<span class="hljs-built_in">let</span> g:miniBufExplModSelTarget = <span class="hljs-number">1</span></code></pre>
                
{% endraw %}
