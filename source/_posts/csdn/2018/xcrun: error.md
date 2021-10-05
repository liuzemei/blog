---
title: "xcrun: error"
date: 2018-10-26 18:10:56
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/83418993)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>安装mangoDB出现了这个错误，</p> 
<p>终于被找到了</p> 
<pre><code class="prism language-s">xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
Error: Failure while executing; `git config --local --replace-all homebrew.private true` exited with 1.
</code></pre> 
<p>解决方案：</p> 
<pre><code class="prism language-s">xcode-select --install
</code></pre> 
<p>在终端输入这个，把xcode的一个模块安装上去就解决了。</p> 
<p>再执行</p> 
<pre><code class="prism language-s">brew install mongodb
</code></pre> 
<p>就?了</p>
                
{% endraw %}
