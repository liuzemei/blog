---
title: "TypeError: Router.use() requires a middleware function but got a Object"
date: 2018-10-28 15:06:06
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/83474765)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <pre><code class="prism language-s">TypeError: Router.use() requires a middleware function but got a Object
</code></pre> 
<p>这个问题出现是引用的时候，被引用文件末尾没有加上<br> <code>module.exports = xxx;</code></p>
                
{% endraw %}
