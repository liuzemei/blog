---
title: mongdb _id比对req.body._id 的大坑
date: 2019-02-19 15:35:40
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/87712674)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <pre><code class="prism language-js">
    Product<span class="token punctuation">.</span><span class="token function">findOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>producName<span class="token punctuation">:</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>producName<span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>product <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
        product<span class="token punctuation">.</span>completeImgs <span class="token operator">=</span> product<span class="token punctuation">.</span>completeImgs <span class="token operator">||</span> <span class="token punctuation">[</span><span class="token punctuation">]</span>
        <span class="token keyword">if</span><span class="token punctuation">(</span>product<span class="token punctuation">.</span>completeImgs<span class="token punctuation">.</span>length <span class="token operator">&gt;</span> <span class="token number">0</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">let</span> aimImg <span class="token operator">=</span> product<span class="token punctuation">.</span>completeImgs<span class="token punctuation">.</span><span class="token function">find</span><span class="token punctuation">(</span>img <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
                console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token keyword">typeof</span> img<span class="token punctuation">.</span>_id<span class="token punctuation">)</span> <span class="token comment">// object</span>
                console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token keyword">typeof</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>_id<span class="token punctuation">)</span> <span class="token comment">// string</span>
                console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token keyword">typeof</span> mongoose<span class="token punctuation">.</span>Types<span class="token punctuation">.</span><span class="token function">ObjectId</span><span class="token punctuation">(</span>req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>_id<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token comment">//object</span>
                console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token keyword">typeof</span> img<span class="token punctuation">.</span>_id<span class="token punctuation">.</span><span class="token function">toString</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token comment">//string</span>
                console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>img<span class="token punctuation">.</span>_id <span class="token operator">===</span> mongoose<span class="token punctuation">.</span>Types<span class="token punctuation">.</span><span class="token function">ObjectId</span><span class="token punctuation">(</span>req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>_id<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token comment">//false</span>
                console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>img<span class="token punctuation">.</span>_id<span class="token punctuation">.</span><span class="token function">toString</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">===</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>_id<span class="token punctuation">)</span><span class="token comment">//ture</span>
                <span class="token keyword">return</span> img<span class="token punctuation">.</span>_id<span class="token punctuation">.</span><span class="token function">toString</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">===</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>_id
            <span class="token punctuation">}</span><span class="token punctuation">)</span>
            console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>aimImg<span class="token punctuation">)</span>
        <span class="token punctuation">}</span><span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
            res<span class="token punctuation">.</span><span class="token function">end</span><span class="token punctuation">(</span><span class="token string">'noThatProductImg'</span><span class="token punctuation">)</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token keyword">catch</span><span class="token punctuation">(</span>err <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
        console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span>
        res<span class="token punctuation">.</span><span class="token function">end</span><span class="token punctuation">(</span><span class="token string">'getFailure'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
   
</code></pre> 
<p>真是大坑…</p> 
<p>直接查询数据库里的_id是一个Object对象，<br> 而用axios传递的_id是一个String对象。</p> 
<p>而且用<code>mongoose.Types.ObjectId()</code>确实可以把一个String的_id转换成Object的_id</p> 
<p>但是还是不相等，这个时候，可以用<code>findOneById(_id)</code>这个可以查，但是还是不相等…</p> 
<p>如果用 <code>===</code> 来比较的话，就只能把<code>Object</code>的<code>_id</code>用<code>toString()</code>转换成<code>String</code>，然后就可以比较了。</p>
                
{% endraw %}
