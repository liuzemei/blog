---
title: vue axios 七牛云 上传图片 图片预览 后端 node （方法二）
date: 2019-02-23 11:40:55
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/87890304)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <blockquote> 
 <ol><li>这个方法是在axios里组织表单请求，然后发送给七牛云服务器，应该比较通用的。</li><li>上传完图片之后可以直接预览到页面中。</li></ol> 
</blockquote> 
<p>另外，本文还附几个获取表单中文件的方法。</p> 
<blockquote> 
 <ol><li>通过$event获取文件信息</li><li>通过$refs获取文件信息</li><li>通过document.getElementById获取文件信息</li></ol> 
</blockquote> 
<p>直接上代码：<br> vue代码：</p> 
<pre><code class="prism language-js"><span class="token operator">&lt;</span>template<span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span>div<span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span>div <span class="token keyword">class</span><span class="token operator">=</span><span class="token string">"rz-picter"</span><span class="token operator">&gt;</span>
          <span class="token operator">&lt;</span>img <span class="token punctuation">:</span>src<span class="token operator">=</span><span class="token string">"producImg"</span> <span class="token keyword">class</span><span class="token operator">=</span><span class="token string">"img-avatar"</span><span class="token operator">&gt;</span>
          <span class="token operator">&lt;</span>input type<span class="token operator">=</span><span class="token string">"file"</span> name<span class="token operator">=</span><span class="token string">"avatar"</span> id<span class="token operator">=</span><span class="token string">"uppic"</span> accept<span class="token operator">=</span><span class="token string">"image/gif,image/jpeg,image/jpg,image/png"</span> @change<span class="token operator">=</span><span class="token string">"changeImage"</span> ref<span class="token operator">=</span><span class="token string">"avatarInput"</span> <span class="token keyword">class</span><span class="token operator">=</span><span class="token string">"uppic"</span><span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>template<span class="token operator">&gt;</span>

<span class="token operator">&lt;</span>script<span class="token operator">&gt;</span>
<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{<!-- --></span>
    <span class="token function">data</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">return</span> <span class="token punctuation">{<!-- --></span>
            uploadToken<span class="token punctuation">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
            producImg<span class="token punctuation">:</span> <span class="token string">''</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    methods<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
        <span class="token function">changeImage</span><span class="token punctuation">(</span>e<span class="token punctuation">,</span>a<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>e<span class="token punctuation">)</span>
            console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>a<span class="token punctuation">)</span>
            <span class="token keyword">var</span> file <span class="token operator">=</span> e<span class="token punctuation">.</span>target<span class="token punctuation">.</span>files<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span>
            <span class="token keyword">var</span> file1 <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">getElementById</span><span class="token punctuation">(</span><span class="token string">'uppic'</span><span class="token punctuation">)</span><span class="token punctuation">.</span>files<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
            <span class="token keyword">var</span> file2 <span class="token operator">=</span> <span class="token keyword">this</span><span class="token punctuation">.</span>$refs<span class="token punctuation">.</span>avatarInput<span class="token punctuation">.</span>files<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span>
            <span class="token keyword">var</span> file3 <span class="token operator">=</span> e<span class="token punctuation">.</span>path<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">.</span>files<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span>
            <span class="token comment">//这四种获取文件的方式得到的结果是一模一样的。都可以直接使用。</span>
            console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>file  <span class="token operator">===</span> file1<span class="token punctuation">)</span> <span class="token comment">//true</span>
            console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>file1 <span class="token operator">===</span> file2<span class="token punctuation">)</span> <span class="token comment">//true</span>
            console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>file3 <span class="token operator">===</span> file2<span class="token punctuation">)</span> <span class="token comment">//true</span>
            <span class="token comment">// console.log(file)</span>
            <span class="token keyword">let</span> cdnUrl <span class="token operator">=</span> <span class="token string">'你的绑定的域名或者七牛云的测试域名'</span><span class="token comment">//记住后面还得加个 /</span>
            <span class="token comment">// 创建一个 FormData(七牛云要求传输格式为FormData)</span>
                <span class="token keyword">let</span> data <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">FormData</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                data<span class="token punctuation">.</span><span class="token function">append</span><span class="token punctuation">(</span><span class="token string">'token'</span><span class="token punctuation">,</span> <span class="token keyword">this</span><span class="token punctuation">.</span>uploadToken<span class="token punctuation">)</span><span class="token punctuation">;</span>     
                <span class="token comment">//七牛需要的token，叫后台给，是七牛账号密码等组成的hash</span>
                data<span class="token punctuation">.</span><span class="token function">append</span><span class="token punctuation">(</span><span class="token string">'file'</span><span class="token punctuation">,</span> file<span class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token comment">//以以下方式组织一个axios请求。</span>
                <span class="token comment">//至少填4个信息，method，url(这是根据存储区域来的，我是华南的)</span>
                <span class="token comment">//data(是以FormData形式组织的，添加如上面代码 .append就行)</span>
                <span class="token comment">//headers(请求头，必须写这个)</span>
                <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token function">axios</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
                    method<span class="token punctuation">:</span> <span class="token string">'post'</span><span class="token punctuation">,</span>
                    url<span class="token punctuation">:</span> <span class="token string">'http://upload-z2.qiniup.com'</span><span class="token punctuation">,</span>
                    data<span class="token punctuation">,</span>
                    headers<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                        <span class="token string">'Content-Type'</span><span class="token punctuation">:</span> <span class="token string">'multipart/form-data'</span>
                    <span class="token punctuation">}</span>
                <span class="token punctuation">}</span><span class="token punctuation">)</span>
                <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>res <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
                    <span class="token keyword">this</span><span class="token punctuation">.</span>producImg <span class="token operator">=</span> cdnUrl <span class="token operator">+</span> res<span class="token punctuation">.</span>data<span class="token punctuation">.</span>key
                <span class="token punctuation">}</span><span class="token punctuation">)</span>
                <span class="token punctuation">.</span><span class="token keyword">catch</span><span class="token punctuation">(</span>err <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
                    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span>
                <span class="token punctuation">}</span><span class="token punctuation">)</span>
         <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token function">created</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">//向后端请求上传凭证，我这里上传凭证是普通凭证。</span>
        <span class="token keyword">this</span><span class="token punctuation">.</span>axios<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/api/order/uploadToken'</span><span class="token punctuation">)</span>
        <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>res <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">this</span><span class="token punctuation">.</span>uploadToken <span class="token operator">=</span> res<span class="token punctuation">.</span>data<span class="token punctuation">.</span>uploadToken
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
        
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>script<span class="token operator">&gt;</span>

<span class="token operator">&lt;</span>style lang<span class="token operator">=</span><span class="token string">"scss"</span> scoped<span class="token operator">&gt;</span>
<span class="token punctuation">.</span>rz<span class="token operator">-</span>picter <span class="token punctuation">{<!-- --></span>
    position<span class="token punctuation">:</span>absolute<span class="token punctuation">;</span>
    <span class="token punctuation">.</span>img<span class="token operator">-</span>avatar <span class="token punctuation">{<!-- --></span>
        width<span class="token punctuation">:</span> <span class="token number">100</span>px<span class="token punctuation">;</span>
        height<span class="token punctuation">:</span> <span class="token number">100</span>px<span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token punctuation">.</span>uppic <span class="token punctuation">{<!-- --></span>
        height<span class="token punctuation">:</span> <span class="token number">90</span>px<span class="token punctuation">;</span>
        width<span class="token punctuation">:</span> <span class="token number">90</span>px<span class="token punctuation">;</span>
        margin<span class="token punctuation">:</span> <span class="token number">0</span> auto<span class="token punctuation">;</span>
        opacity<span class="token punctuation">:</span> <span class="token number">0</span><span class="token punctuation">;</span>
        z<span class="token operator">-</span>index<span class="token punctuation">:</span> <span class="token number">99999</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token punctuation">.</span>img<span class="token operator">-</span>avatar <span class="token punctuation">{<!-- --></span>
    position<span class="token punctuation">:</span> absolute<span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>style<span class="token operator">&gt;</span>

</code></pre> 
<p>后端代码和之前的比较类似，可以查看之前的一盘文章里面node的请求。主要目的是为了获取上传凭证。</p>
                
{% endraw %}
