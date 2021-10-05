---
title: linux下man手册的安装和使用
date: 2018-08-20 10:47:00
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/81867485)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>版权声明：本文为博主原创文章 &amp;&amp; 转载请著名出处 @ <a href="http://blog.csdn.net/gatieme">http://blog.csdn.net/gatieme</a> <a href="https://blog.csdn.net/gatieme/article/details/51656707">https://blog.csdn.net/gatieme/article/details/51656707</a></p> 
<p>linux man手册 <br> Linux提供了丰富的帮助手册，当你需要查看某个命令的参数时不必到处上网查找，只要man一下即可。 <br> Linux 的man手册共有以下几个章节：</p> 
<p>章节 名称 描述 <br> 1 Standard commands(标准命令) Executable programs or shell commands, 普通的命令 <br> 2 System calls(系统调用) System calls (functions provided by the kernel)系统调用,如open,write之类的(通过这个，至少可以很方便的查到调用这个函数，需要加什么头文件) <br> 3 Libraryfunctions(库函数) Library calls (functions within program libraries), 库函数,如printf,fread <br> 4 Specialdevices(设备说明) Special files (usually found in /dev), 特殊文件,也就是/dev下的各种设备文件 <br> 5 File formats(文件格式) File formats and conventions eg /etc/passwd, 指文件的格式,比如passwd, 就会说明这个文件中各个字段的含义 <br> 6 Games andtoys(游戏和娱乐) 给游戏留的,由各个游戏自己定义 <br> 7 Miscellaneous(杂项) Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7),附件还有一些变量,比如向environ这种全局变量在这里就有说明 <br> 8 AdministrativeCommands(管理员命令) System administration commands (usually only for root), 系统管理用的命令,这些命令只能由root使用,如ifconfig <br> 9 Kernel routines [Non standard] <br> 安装man手册 <br> Ubuntu安装 <br> Ubuntu默认是没有完全安装man手册的</p> 
<p>apt-get install manpages-de manpages-de-dev manpages-dev glibc-doc manpages-posix-dev manpages-posix <br> 1 <br> 为了显示中文手册，下载manpages-zh包。</p> 
<p>可以直接运行如下命令安装</p> 
<p>sudo apt-get install manpages-zh <br> 1 <br> CentOS安装 <br> man手册</p> 
<p>yum install man <br> 1 <br> man中文安装包</p> 
<p>yum install manpages-zh <br> 1 <br> 如果查不到manpages-zh中文包,则可以使用如下命令搜索</p> 
<p>yum list |grep man.*zh <br> 1 <br> man-pages-zh-CN.noarch 1.5.2-4.el7 @base</p> 
<p>由此可以找到以上安装包，如果找不到，执行 yum -y update 更新安装包。</p> 
<p>执行安装命令</p> 
<p>sudo yum install man-pages-zh-CN.noarch <br> 1 <br> 源码安装 <br> 安装man手册</p> 
<p>源码从这里下载</p> 
<p><a href="http://www.kernel.org/pub/linux/docs/man-pages/">http://www.kernel.org/pub/linux/docs/man-pages/</a></p> 
<p>下载后解压缩，从终端进入解压后的文件夹，输入命令：</p> 
<p>sudo make install <br> 1 <br> 这个命令是把man安装到/user/man目录下面的，这样就已经成功的安装了man</p> 
<p>但是如果你不想安装, 我们可以直接在解压后的目录使用</p> 
<p>假设解压后文件夹路径是：/home/man，如果不想安装，可以用：</p> 
<p>man –M /home/man + 所查询的命令 <br> 1 <br> 解释：man -M 路径 定义一组查找man手册页的目录。如果没有指定此参数，系统环境变量 MANPATH将使用。 如果查无到此环境变量，则按默认 /etc/man.config 文件中指定的查找。一个空的 MANPATH 子字 符串表示使用默认清单。</p> 
<p>安装中文语言包手册</p> 
<p>在安装之前，运行locale 命令来查看自己的语言环境是什么，主要有影响的是LC_ALL，LC_CTYPE 和 LANG 变量的值。</p> 
<p>如果语言环境是 zh_CN.UTF-8，可以运行make u8 &amp;&amp; makeinstall-u8；如果语言环境是GB2312，GBK 或者 GB18030，可以运行 make gb &amp;&amp; makeinstall-gb；</p> 
<p>或者，可以下载对应的rpm包来安装，同样简单。对于zh_CN.UTF-8，应当安装man-pages-zh_CN-1.x，对于 GB2312，GBK，GB18030，应当安装 man-pages-zh_CN-gb-1.x。请参阅讨论版上关于不同发行版的系统与其默认中文编码的说明。</p> 
<p>环境变量配置 <br> 我们前面安装了中英文的man包, 可以通过设置中英文显示语言来设定其显示</p> 
<p>如果希望终端显示为中文, 则可以通过设置LANG和LANGUAGE变量来更新语言环境</p> 
<p>在~/.bashrc中设置</p> 
<h1 id="chinese">chinese</h1> 
<p>LANG=”zh_CN.UTF-8” <br> LANGUAGE=”zh_CN:zh” <br> 1 <br> 2 <br> 3 <br> 英文则设定</p> 
<h1 id="english">english</h1> 
<p>LANG=”en_US.UTF-8” <br> LANGUAGE=”en_US:en” <br> 1 <br> 2 <br> 3 <br> 但是中文翻译的不太好, 我们多数情况下还是希望使用英文的, 而更改环境变量的方式总是很麻烦, 有什么方式可以一劳永逸呢.</p> 
<p>首先差找到我们的man手册安装在哪里</p> 
<p>可以使用sudo find / -name man查找</p> 
<p>我的man手册安装在了/usr/share/man下</p> 
<p>man手册安装在了/usr/share/man</p> 
<p>其中zh_开头的就是中文包的man手册,</p> 
<p>zh_CN简体中文</p> 
<p>zh_HK香港繁体</p> 
<p>zh_TW台湾繁体</p> 
<p>我们可以使用-M选项指定man手册</p> 
<p>比如使用</p> 
<p>man -M /usr/share/man/zh_CN/ 2 read</p> 
<p>就可以使用中文手册查看read系统调用</p> 
<p>下面我们为其添加一个别名cman, 这样我们可以很方便的使用中文的man手册</p> 
<p>在~/.bashrc中添加</p> 
<p>alias cman=’man -M /usr/share/man/zh_CN’ <br> 1 <br> 这样以来我们的man是英文的, 而cman则是一个中文的man手册</p> 
<p>中英文man手册</p> 
<p>man手册的使用 <br> 我们输入 man ls，它会在最左上角显示“LS（1）”，在这里，“LS”表示手册名称，而“（1）”表示该手册位于第一节章(对应编号, 没个编号对应一个章节)</p> 
<p>同样，我们输入“man ifconfig”它会在最左上角显示“IFCONFIG（8）”。</p> 
<p>但是有些名称可能对应很多章节的信息,因此可以这样输入命令：“man [章节号] 手册名称”, 来指定某个章节比如我们前面的man 2 read就是查看第2章节(系统调用)中的read</p> 
<p>而我们可以使用-f选项来查看命令所在的章节</p> 
<p>man -f选项</p> 
<p>版权声明：本文为博主原创文章 &amp;&amp; 转载请著名出处 @ <a href="http://blog.csdn.net/gatieme">http://blog.csdn.net/gatieme</a> <a href="https://blog.csdn.net/gatieme/article/details/51656707">https://blog.csdn.net/gatieme/article/details/51656707</a></p>
                
{% endraw %}
