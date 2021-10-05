---
title: Git永久删除文件和历史记录
date: 2021-09-01 08:49:45
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/120031679)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h1><a id="Git_0"></a>Git永久删除文件和历史记录</h1> 
<p>造成你想从git存储库中永久删除文件和历史记录的可能有：</p> 
<ul><li>你不小心将一个不该加入版本管理的文件加了进去，敏感数据或大文件或别的没用的文件；</li><li>你不小心将一个涉及到破解某著名软件的文章加了进Github仓库，这时你就会收到github官- 方的邮件来提醒你需要完全删除该文件，不然就会遭到git仓库被封禁。</li><li>你希望将敏感数据或无用文件从版本库中永久删除不留痕迹，不仅仅在版本历史里看不出来，还要把它占用的空间也释放出来。</li></ul> 
<blockquote> 
 <p>参考官方链接，github 的帮助文档:<br> <a href="https://help.github.com/articles/remove-sensitive-data">https://help.github.com/articles/remove-sensitive-data</a></p> 
</blockquote> 
<p>很详细的说明了步骤和提供了一种使用BFG工具的思路（更便利）</p> 
<p>这里我只说使用git命令的方式，以windows平台下为例，linux类似做法：</p> 
<h2><a id="filterbranch_14"></a>使用filter-branch</h2> 
<p><strong>注意</strong>: 如果在存储更改后运行git filter-branch，则无法使用其他存储命令检索更改。</p> 
<p>在运行<code>git filter-branch</code>之前，建议取消所做的任何更改。要<code>unstash</code>最后一组隐藏的更改，运行<code>git stash show -p | git apply -R</code>。有关更多信息，请参阅<a href="https://git-scm.com/book/en/v1/Git-Tools-Stashing">https://git-scm.com/book/en/v1/Git-Tools-Stashing</a>。</p> 
<p>演示如下：</p> 
<ol><li>进入git存储仓库，运行以下命令，用要删除文件的相对路径(而不仅仅是文件名)替换PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA。</li></ol> 
<blockquote> 
 <p>这行长命令的参数做到的事是：</p> 
 <ol><li>强制Git处理(但不检出)每个分支和标记的全部历史；</li><li>删除指定的文件，以及由此生成的任何空提交；</li></ol> 
</blockquote> 
<p>覆盖你现有的tags</p> 
<pre><code class="prism language-bash">$ <span class="token function">git</span> filter-branch --force --index-filter <span class="token punctuation">\</span>
<span class="token string">'git rm --cached --ignore-unmatch PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA'</span> <span class="token punctuation">\</span>
--prune-empty --tag-name-filter <span class="token function">cat</span> -- --all
</code></pre> 
<p>其中, PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA 就是你要删除的文件的相对路径(相对于git仓库的根目录), 替换成你要删除的文件路径即可. 注意一点，这里的文件或文件夹，如果以 ‘/’ 开头，则文件或文件夹会被认为是从 git 的安装目录开始。</p> 
<p><strong>如果你要删除的目标不是文件，而是文件夹</strong>，那么请在 <code>git rm --cached</code> 命令后面添加 <code>-r</code> 命令，表示递归的删除（子）文件夹和文件夹下的文件，类似于 <code>rm -rf</code> 命令。</p> 
<p><strong>如果你要删除的文件很多</strong>, 可以写进一个.sh文件批量执行, 如果文件或路径里有中文, 由于MinGW或CygWin对中文路径设置比较麻烦, 你可以使用通配符<code>*</code>号, 例如: <code>sound/music_*.mp3</code>, 这样就把sound目录下以music_开头的mp3文件都删除了.</p> 
<p>例如:新建一个 bash 脚本文件，del-music-mp3.sh:</p> 
<pre><code class="prism language-bash"><span class="token shebang important">#!/bin/bash</span>
<span class="token function">git</span> filter-branch --force --index-filter <span class="token string">'git rm --cached --ignore-unmatch projects/Moon.mp3'</span> --prune-empty --tag-name-filter <span class="token function">cat</span> -- --all
<span class="token function">git</span> filter-branch --force --index-filter <span class="token string">'git rm --cached --ignore-unmatch sound/Music_*.mp3'</span> --prune-empty --tag-name-filter <span class="token function">cat</span> -- --all
</code></pre> 
<p>如果你看到类似下面这样的, 就说明删除成功了:</p> 
<pre><code class="prism language-bash">Rewrite 48dc599c80e20527ed902928085e7861e6b3cbe6 <span class="token punctuation">(</span><span class="token number">266</span>/266<span class="token punctuation">)</span>
</code></pre> 
<blockquote> 
 <p>如果显示 xxxxx unchanged, 说明repo里没有找到该文件, 请检查路径和文件名是否正确.</p> 
</blockquote> 
<h2><a id="gitignorepushrepo_52"></a>添加到.gitignore文件里并push修改后的repo</h2> 
<p>如果想以后也不会再上传这个文件或文件夹, 请把这个文件或文件夹添加到.gitignore文件里, 然后再push你的repo.</p> 
<p>添加到.gitignore文件：</p> 
<pre><code class="prism language-shell">$ <span class="token builtin class-name">echo</span> <span class="token string">"YOUR-FILE-WITH-SENSITIVE-DATA"</span> <span class="token operator">&gt;&gt;</span> .gitignore
$ <span class="token function">git</span> <span class="token function">add</span> .gitignore
$ <span class="token function">git</span> commit -m <span class="token string">"Add YOUR-FILE-WITH-SENSITIVE-DATA to .gitignore"</span>
<span class="token punctuation">[</span>master 051452f<span class="token punctuation">]</span> Add YOUR-FILE-WITH-SENSITIVE-DATA to .gitignore
 <span class="token number">1</span> files changed, <span class="token number">1</span> insertions<span class="token punctuation">(</span>+<span class="token punctuation">)</span>, <span class="token number">0</span> deletions<span class="token punctuation">(</span>-<span class="token punctuation">)</span>
</code></pre> 
<p>再次检查是否已经从存储库的历史记录中删除了所有想要删除的内容，以及是否检出了所有分支。</p> 
<p>以强制覆盖的方式推送你的repo, 命令如下:</p> 
<pre><code class="prism language-shell"><span class="token function">git</span> push origin --force --all
Counting objects: <span class="token number">1074</span>, done.
Delta compression using <span class="token number">2</span> threads.
Compressing objects: <span class="token number">100</span>% <span class="token punctuation">(</span><span class="token number">677</span>/677<span class="token punctuation">)</span>, done.
Writing objects: <span class="token number">100</span>% <span class="token punctuation">(</span><span class="token number">1058</span>/1058<span class="token punctuation">)</span>, <span class="token number">148.85</span> KiB, done.
Total <span class="token number">1058</span> <span class="token punctuation">(</span>delta <span class="token number">590</span><span class="token punctuation">)</span>, reused <span class="token number">602</span> <span class="token punctuation">(</span>delta <span class="token number">378</span><span class="token punctuation">)</span>
To https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
 + 48dc599<span class="token punctuation">..</span>.051452f master -<span class="token operator">&gt;</span> master <span class="token punctuation">(</span>forced update<span class="token punctuation">)</span>
</code></pre> 
<p>这个过程其实是重新上传我们的repo, 比较耗时, 虽然跟删掉重新建一个repo有些类似, 但是好处是保留了原有的更新记录, 所以还是有些不同的. 如果你实在不在意这些更新记录, 也可以删掉重建, 两者也差不太多, 也许后者还更直观些。</p> 
<p>为了能从打了 tag 的版本中也删除你所指定的文件或文件夹，您可以使用这样的命令来强制推送您的 Git tags：</p> 
<pre><code class="prism language-shell">$ <span class="token function">git</span> push origin master --force --tags
</code></pre> 
<p>告诉您的协作者，从您的旧(受污染的)存储库历史中重新创建分支，而不是合并它们。一个合并提交可能会重新引入一些或所有您刚刚陷入清除麻烦的受污染的历史。</p> 
<p>清理和回收空间<br> 经过一段时间之后，您确信git filter-branch没有意外的副作用，您可以使用以下命令强制解除对本地存储库中的所有对象的引用和垃圾回收(GC)。</p> 
<pre><code class="prism language-shell">$ <span class="token function">git</span> for-each-ref --format<span class="token operator">=</span><span class="token string">'delete %(refname)'</span> refs/original <span class="token operator">|</span> <span class="token function">git</span> update-ref --stdin
$ <span class="token function">git</span> reflog expire --expire<span class="token operator">=</span>now --all
$ <span class="token function">git</span> gc --prune<span class="token operator">=</span>now
Counting objects: <span class="token number">2437</span>, done.
Delta compression using up to <span class="token number">4</span> threads.
Compressing objects: <span class="token number">100</span>% <span class="token punctuation">(</span><span class="token number">1378</span>/1378<span class="token punctuation">)</span>, done.
Writing objects: <span class="token number">100</span>% <span class="token punctuation">(</span><span class="token number">2437</span>/2437<span class="token punctuation">)</span>, done.
Total <span class="token number">2437</span> <span class="token punctuation">(</span>delta <span class="token number">1461</span><span class="token punctuation">)</span>, reused <span class="token number">1802</span> <span class="token punctuation">(</span>delta <span class="token number">1048</span><span class="token punctuation">)</span>
</code></pre> 
<p>您还可以通过将过滤后的历史推入一个新的或空的存储库，然后从GitHub创建一个新的克隆来实现这一点。</p> 
<p>上面命令的第一句也可以换成:</p> 
<pre><code class="prism language-shell">$ <span class="token function">rm</span> -rf .git/refs/original/
</code></pre> 
<p>参考自：</p> 
<p>https://www.shuzhiduo.com/A/x9J2kXxn56</p>
                
{% endraw %}
