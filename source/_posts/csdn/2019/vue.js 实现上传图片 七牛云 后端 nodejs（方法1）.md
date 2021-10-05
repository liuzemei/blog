---
title: vue.js 实现上传图片 七牛云 后端 nodejs（方法1）
date: 2019-02-22 10:53:23
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/87874162)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>前端 vue.js 实现上传图片到七牛云的组件。</p> 
<p>需要向后台拿上传凭证，后端是用node.js写的。</p> 
<p>前端 代码如下：</p> 
<pre><code class="prism language-js"><span class="token operator">&lt;</span>template<span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span>div <span class="token keyword">class</span><span class="token operator">=</span><span class="token string">"con"</span><span class="token operator">&gt;</span>
    <span class="token comment">//这里的action，要对应你的bucket所在的服务区哈，我的是华南的。</span>
        <span class="token operator">&lt;</span>form method<span class="token operator">=</span><span class="token string">"post"</span> action<span class="token operator">=</span><span class="token string">"http://upload-z2.qiniup.com"</span>
              enctype<span class="token operator">=</span><span class="token string">"multipart/form-data"</span><span class="token operator">&gt;</span>
            <span class="token operator">&lt;</span>input name<span class="token operator">=</span><span class="token string">"token"</span> type<span class="token operator">=</span><span class="token string">"hidden"</span> v<span class="token operator">-</span>model<span class="token operator">=</span><span class="token string">"uploadToken"</span><span class="token operator">&gt;</span>
            <span class="token operator">&lt;</span>input name<span class="token operator">=</span><span class="token string">"file"</span> type<span class="token operator">=</span><span class="token string">"file"</span> <span class="token operator">/</span><span class="token operator">&gt;</span>
            <span class="token operator">&lt;</span>input type<span class="token operator">=</span><span class="token string">"submit"</span> value<span class="token operator">=</span><span class="token string">"上传文件"</span> <span class="token operator">/</span><span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span><span class="token operator">/</span>form<span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>template<span class="token operator">&gt;</span>

<span class="token operator">&lt;</span>script<span class="token operator">&gt;</span>
<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{<!-- --></span>
    <span class="token function">data</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">return</span> <span class="token punctuation">{<!-- --></span>
            uploadToken<span class="token punctuation">:</span> <span class="token string">''</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    methods<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token function">created</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">this</span><span class="token punctuation">.</span>axios<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/api/order/uploadToken'</span><span class="token punctuation">)</span>
        <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>res <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">this</span><span class="token punctuation">.</span>uploadToken <span class="token operator">=</span> res<span class="token punctuation">.</span>data<span class="token punctuation">.</span>uploadToken
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>script<span class="token operator">&gt;</span>

</code></pre> 
<p>后端代码如下：</p> 
<blockquote> 
 <p>当然你先得 npm i qiniu然后才可以使用~<br> 框架用的是express ，这部分就不讲了。</p> 
</blockquote> 
<pre><code class="prism language-js"><span class="token keyword">var</span> qiniu <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">"qiniu"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>


<span class="token comment">//获取七牛云的上传凭证</span>
router<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/uploadToken'</span><span class="token punctuation">,</span> <span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    <span class="token keyword">let</span> accessKey <span class="token operator">=</span> <span class="token string">'你的accessKey'</span>
    <span class="token keyword">let</span> secretKey <span class="token operator">=</span> <span class="token string">'你的secretKey'</span>
    <span class="token keyword">var</span> mac <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">qiniu<span class="token punctuation">.</span>auth<span class="token punctuation">.</span>digest<span class="token punctuation">.</span>Mac</span><span class="token punctuation">(</span>accessKey<span class="token punctuation">,</span> secretKey<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">let</span> bucket <span class="token operator">=</span> <span class="token string">'produc-curtain'</span>
    <span class="token comment">//要上传的空间</span>
    <span class="token keyword">var</span> options <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
      scope<span class="token punctuation">:</span> bucket<span class="token punctuation">,</span>
      returnBody<span class="token punctuation">:</span> <span class="token string">'{"key":"$(key)","hash":"$(etag)","fsize":$(fsize),"bucket":"$(bucket)","name":"$(x:name)"}'</span>
    <span class="token punctuation">}</span><span class="token punctuation">;</span>
    
    <span class="token comment">// 构建上传凭证</span>
    <span class="token keyword">var</span> putPolicy <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">qiniu<span class="token punctuation">.</span>rs<span class="token punctuation">.</span>PutPolicy</span><span class="token punctuation">(</span>options<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">var</span> uploadToken<span class="token operator">=</span>putPolicy<span class="token punctuation">.</span><span class="token function">uploadToken</span><span class="token punctuation">(</span>mac<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">if</span><span class="token punctuation">(</span>uploadToken<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
        res<span class="token punctuation">.</span><span class="token function">json</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>uploadToken<span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre>
                
{% endraw %}
