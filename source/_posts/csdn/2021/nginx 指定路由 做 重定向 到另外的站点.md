---
title: nginx 指定路由 做 重定向 到另外的站点
date: 2021-06-09 21:01:42
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/117754258)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <blockquote> 
 <p>我们需要将一个站点的指定路由，重定向到其他的网站。</p> 
</blockquote> 
<blockquote> 
 <p>比如：我们在访问 my.com 的时候，访问的是我们自己的站点。<br> 希望在访问 my.com/others 的时候，直接重定向到 xxx.com 。<br> 当然我们可以直接通过前端代码里路由去判断做重定向。不过这样做有一个问题，就是浏览器会保留返回按钮。虽然也能达到目的。</p> 
</blockquote> 
<p>好了，下面进入正题。</p> 
<p>其实直接在<code>my.com</code> 项目中的 <code>nginx</code> 的 <code>location</code> 里加上 <code>rewrite</code> 就可以了。</p> 
<pre><code>location / {
  rewrite ^/others(.*)$ https://xxx.com$1 permanent;
}
</code></pre>
                
{% endraw %}
