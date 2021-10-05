---
title: ubuntu:vim的安装及部分问题解决方法
date: 2018-08-08 11:06:51
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/81504663)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>VIM的安装及部分问题解决方法</p> 
<p>1.刚安装好Ubuntu后需要装vim编辑器时，在终端输入vim test.c时会出现下面情况：</p> 
<p>nigel@yq-ubuntu:~/worksp$ vim test.c</p> 
<p>The program ‘vim’ can be found in the following packages:</p> 
<ul><li><p>vim</p></li><li><p>vim-gnome</p></li><li><p>vim-tiny</p></li><li><p>vim-athena</p></li><li><p>vim-gtk</p></li><li><p>vim-nox</p></li></ul> 
<p>Try: sudo apt-get install</p> 
<p>nigel@yq-ubuntu:~/worksp$</p> 
<p>这说明系统还未安装vim编辑器。</p> 
<p>2.但是当我输入sudo apt-get install vim-gtk时（我们用的vim就是这个安装包）,</p> 
<p>再次出现了下面这样的问题：</p> 
<p>nigel@yq-ubuntu:~/worksp$ sudo apt-get install vim-gtk</p> 
<p>Reading package lists… Done</p> 
<p>Building dependency tree </p> 
<p>Reading state information… Done</p> 
<p>Package vim-gtk is not available, but is referred to by another package.</p> 
<p>This may mean that the package is missing, has been obsoleted, or</p> 
<p>is only available from another source</p> 
<p>E: Package ‘vim-gtk’ has no installation candidate</p> 
<p>这种情况如果你没有出现说明你的软件源设置是可以的，我的刚装好没有选择软件源就会出现这个提示，找不到这个包。这时，我们应该在software center中找到software sources(软件源设置)，点击Ubuntu software-&gt;找到download from点击进去选择other…-&gt;select best server ,然后他会自动寻找适合你IP的最佳软件源，静静等待。找到之后，chooes server退出即可。</p> 
<p>3.我们再次回到终端，执行sudo apt-get update更新一下</p> 
<p>4.然后我们再次执行sudo apt-get install vim-gtk，</p> 
<p>这次发现还是没有成功，而是出现了下面这种情况：</p> 
<p>nigel@yq-ubuntu:~/worksp$ sudo apt-get install vim-gtk</p> 
<p>Reading package lists… Done</p> 
<p>Building dependency tree </p> 
<p>Reading state information… Done</p> 
<p>Some packages could not be installed. This may mean that you have</p> 
<p>requested an impossible situation or if you are using the unstable</p> 
<p>distribution that some required packages have not yet been created</p> 
<p>or been moved out of Incoming.</p> 
<p>The following information may help to resolve the situation:</p> 
<p>The following packages have unmet dependencies:</p> 
<p>vim-gtk : Depends: vim-common (= 2:7.3.429-2ubuntu2) but 2:7.3.429-2ubuntu2.1 is to be installed</p> 
<p>E: Unable to correct problems, you have held broken packages.</p> 
<p>原因可能是安装vim所依赖的vim-common和系统自带的vim-common版本冲突，解决办法就是先把vim-common卸载了然后再安装vim即可。</p> 
<p>5.执行这句话sudo apt-get remove vim-common 卸载vim-common</p> 
<p>6.再次执行sudo apt-get install vim-gtk，这次会发现成功了！！！呵呵。</p> 
<p>——(文档由nigel-yq 编写)</p>
                
{% endraw %}
