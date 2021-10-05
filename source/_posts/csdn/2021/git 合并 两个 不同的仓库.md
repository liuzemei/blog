---
title: git 合并 两个 不同的仓库
date: 2021-05-20 09:34:28
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/117062979)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h3><a id="_0"></a>合并两个不同的仓库</h3> 
<ol><li>最终要得到的仓库为 origin/master.</li><li>要合并的仓库为 upstream/master.</li></ol> 
<pre><code class="prism language-shell"><span class="token comment"># 1. 拉下 origin/master 的代码</span>
<span class="token function">git</span> clone xxxxxxx.git

<span class="token comment"># 2. 添加需要合并的远程仓库 upstream</span>
<span class="token function">git</span> remote add upstream xxxxxxxx.git

<span class="token comment"># 3. 基于 upstream/master 创建一个 origin/asf 的仓库</span>
<span class="token function">git</span> checkout -b asf upstream/master

<span class="token comment"># 4. 切换到 origin/master 分支</span>
<span class="token function">git</span> checkout master

<span class="token comment"># 5. 合并 asf 分支</span>
<span class="token function">git</span> merge asf --allow-unrelated-histories

<span class="token comment"># 6. 推送代码到 origin/master 完成合并</span>
<span class="token function">git</span> push origin master
</code></pre>
                
{% endraw %}
