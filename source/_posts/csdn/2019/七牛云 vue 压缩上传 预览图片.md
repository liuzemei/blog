---
title: 七牛云 vue 压缩上传 预览图片
date: 2019-02-27 22:27:33
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/87994662)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <pre><code class="prism language-js"><span class="token operator">&lt;</span>template<span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span>div<span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span>div <span class="token keyword">class</span><span class="token operator">=</span><span class="token string">"rz-picter"</span><span class="token operator">&gt;</span>
          <span class="token operator">&lt;</span>img <span class="token punctuation">:</span>src<span class="token operator">=</span><span class="token string">"producImg"</span> <span class="token keyword">class</span><span class="token operator">=</span><span class="token string">"img-avatar"</span><span class="token operator">&gt;</span>
          <span class="token operator">&lt;</span>input type<span class="token operator">=</span><span class="token string">"file"</span> name<span class="token operator">=</span><span class="token string">"avatar"</span> id<span class="token operator">=</span><span class="token string">"uppic"</span> accept<span class="token operator">=</span><span class="token string">"image/gif,image/jpeg,image/jpg,image/png"</span> @change<span class="token operator">=</span><span class="token string">"changeImage"</span> ref<span class="token operator">=</span><span class="token string">"avatarInput"</span> <span class="token keyword">class</span><span class="token operator">=</span><span class="token string">"uppic"</span><span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>template<span class="token operator">&gt;</span>

<span class="token operator">&lt;</span>script<span class="token operator">&gt;</span>
<span class="token keyword">import</span> <span class="token punctuation">{<!-- --></span> Toast <span class="token punctuation">}</span> <span class="token keyword">from</span> <span class="token string">'mint-ui'</span><span class="token punctuation">;</span>
<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{<!-- --></span>
    <span class="token function">data</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">return</span> <span class="token punctuation">{<!-- --></span>
            uploadToken<span class="token punctuation">:</span> <span class="token string">''</span><span class="token punctuation">,</span>
            producImg<span class="token punctuation">:</span> <span class="token string">''</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    methods<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
        <span class="token function">photoCompress</span><span class="token punctuation">(</span>file<span class="token punctuation">,</span>obj<span class="token punctuation">,</span>objDiv<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
 
            <span class="token keyword">var</span> ready<span class="token operator">=</span><span class="token keyword">new</span> <span class="token class-name">FileReader</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token comment">/*开始读取指定的Blob对象或File对象中的内容. 当读取操作完成时,readyState属性的值会成为DONE,如果设置了onloadend事件处理程序,则调用之.同时,result属性中将包含一个data: URL格式的字符串以表示所读取文件的内容.*/</span>
            ready<span class="token punctuation">.</span><span class="token function">readAsDataURL</span><span class="token punctuation">(</span>file<span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">let</span> that <span class="token operator">=</span> <span class="token keyword">this</span>
            ready<span class="token punctuation">.</span><span class="token function-variable function">onload</span><span class="token operator">=</span><span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
                <span class="token keyword">var</span> re<span class="token operator">=</span><span class="token keyword">this</span><span class="token punctuation">.</span>result<span class="token punctuation">;</span>
                that<span class="token punctuation">.</span><span class="token function">canvasDataURL</span><span class="token punctuation">(</span>re<span class="token punctuation">,</span>obj<span class="token punctuation">,</span>objDiv<span class="token punctuation">)</span>
            <span class="token punctuation">}</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token function">canvasDataURL</span><span class="token punctuation">(</span>path<span class="token punctuation">,</span> obj<span class="token punctuation">,</span> callback<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
            <span class="token keyword">var</span> img <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">Image</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            img<span class="token punctuation">.</span>src <span class="token operator">=</span> path<span class="token punctuation">;</span>
            img<span class="token punctuation">.</span><span class="token function-variable function">onload</span> <span class="token operator">=</span> <span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
                <span class="token keyword">var</span> that <span class="token operator">=</span> <span class="token keyword">this</span><span class="token punctuation">;</span>
                <span class="token comment">// 默认按比例压缩</span>
                <span class="token keyword">var</span> w <span class="token operator">=</span> that<span class="token punctuation">.</span>width<span class="token punctuation">,</span>
                    h <span class="token operator">=</span> that<span class="token punctuation">.</span>height<span class="token punctuation">,</span>
                    scale <span class="token operator">=</span> w <span class="token operator">/</span> h<span class="token punctuation">;</span>
                w <span class="token operator">=</span> obj<span class="token punctuation">.</span>width <span class="token operator">||</span> w<span class="token punctuation">;</span>
                h <span class="token operator">=</span> obj<span class="token punctuation">.</span>height <span class="token operator">||</span> <span class="token punctuation">(</span>w <span class="token operator">/</span> scale<span class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token keyword">var</span> quality <span class="token operator">=</span> <span class="token number">0.7</span><span class="token punctuation">;</span>  <span class="token comment">// 默认图片质量为0.7</span>
                <span class="token comment">//生成canvas</span>
                <span class="token keyword">var</span> canvas <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">createElement</span><span class="token punctuation">(</span><span class="token string">'canvas'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token keyword">var</span> ctx <span class="token operator">=</span> canvas<span class="token punctuation">.</span><span class="token function">getContext</span><span class="token punctuation">(</span><span class="token string">'2d'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token comment">// 创建属性节点</span>
                <span class="token keyword">var</span> anw <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">createAttribute</span><span class="token punctuation">(</span><span class="token string">"width"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                anw<span class="token punctuation">.</span>nodeValue <span class="token operator">=</span> w<span class="token punctuation">;</span>
                <span class="token keyword">var</span> anh <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">createAttribute</span><span class="token punctuation">(</span><span class="token string">"height"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                anh<span class="token punctuation">.</span>nodeValue <span class="token operator">=</span> h<span class="token punctuation">;</span>
                canvas<span class="token punctuation">.</span><span class="token function">setAttributeNode</span><span class="token punctuation">(</span>anw<span class="token punctuation">)</span><span class="token punctuation">;</span>
                canvas<span class="token punctuation">.</span><span class="token function">setAttributeNode</span><span class="token punctuation">(</span>anh<span class="token punctuation">)</span><span class="token punctuation">;</span>
                ctx<span class="token punctuation">.</span><span class="token function">drawImage</span><span class="token punctuation">(</span>that<span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">,</span> w<span class="token punctuation">,</span> h<span class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token comment">// 图像质量</span>
                <span class="token keyword">if</span><span class="token punctuation">(</span>obj<span class="token punctuation">.</span>quality <span class="token operator">&amp;&amp;</span> obj<span class="token punctuation">.</span>quality <span class="token operator">&lt;=</span> <span class="token number">1</span> <span class="token operator">&amp;&amp;</span> obj<span class="token punctuation">.</span>quality <span class="token operator">&gt;</span> <span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
                    quality <span class="token operator">=</span> obj<span class="token punctuation">.</span>quality<span class="token punctuation">;</span>
                <span class="token punctuation">}</span>
                <span class="token comment">// quality值越小，所绘制出的图像越模糊</span>
                <span class="token keyword">var</span> base64 <span class="token operator">=</span> canvas<span class="token punctuation">.</span><span class="token function">toDataURL</span><span class="token punctuation">(</span><span class="token string">'image/jpeg'</span><span class="token punctuation">,</span> quality<span class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token comment">// 回调函数返回base64的值</span>
                <span class="token function">callback</span><span class="token punctuation">(</span>base64<span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token function">convertBase64UrlToBlob</span><span class="token punctuation">(</span>urlData<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
            <span class="token keyword">var</span> arr <span class="token operator">=</span> urlData<span class="token punctuation">.</span><span class="token function">split</span><span class="token punctuation">(</span><span class="token string">','</span><span class="token punctuation">)</span><span class="token punctuation">,</span> mime <span class="token operator">=</span> arr<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">.</span><span class="token function">match</span><span class="token punctuation">(</span><span class="token regex">/:(.*?);/</span><span class="token punctuation">)</span><span class="token punctuation">[</span><span class="token number">1</span><span class="token punctuation">]</span><span class="token punctuation">,</span>
                bstr <span class="token operator">=</span> <span class="token function">atob</span><span class="token punctuation">(</span>arr<span class="token punctuation">[</span><span class="token number">1</span><span class="token punctuation">]</span><span class="token punctuation">)</span><span class="token punctuation">,</span> n <span class="token operator">=</span> bstr<span class="token punctuation">.</span>length<span class="token punctuation">,</span> u8arr <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">Uint8Array</span><span class="token punctuation">(</span>n<span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">while</span><span class="token punctuation">(</span>n<span class="token operator">--</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
                u8arr<span class="token punctuation">[</span>n<span class="token punctuation">]</span> <span class="token operator">=</span> bstr<span class="token punctuation">.</span><span class="token function">charCodeAt</span><span class="token punctuation">(</span>n<span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span>
            <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">Blob</span><span class="token punctuation">(</span><span class="token punctuation">[</span>u8arr<span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span>type<span class="token punctuation">:</span>mime<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token function">changeImage</span><span class="token punctuation">(</span>e<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">var</span> file <span class="token operator">=</span> e<span class="token punctuation">.</span>target<span class="token punctuation">.</span>files<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span>
            <span class="token keyword">let</span> data <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">FormData</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">let</span> that <span class="token operator">=</span> <span class="token keyword">this</span><span class="token punctuation">;</span>
            <span class="token keyword">if</span><span class="token punctuation">(</span>file<span class="token punctuation">.</span>size<span class="token operator">/</span><span class="token number">1024</span> <span class="token operator">&gt;</span> <span class="token number">1025</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
                <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token function">photoCompress</span><span class="token punctuation">(</span>file<span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>
                    quality<span class="token punctuation">:</span> <span class="token number">0.5</span>
                <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>base64Codes<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
                    <span class="token comment">//console.log("压缩后：" + base64Codes.length / 1024 + " " + base64Codes);die;</span>
                    file <span class="token operator">=</span> that<span class="token punctuation">.</span><span class="token function">convertBase64UrlToBlob</span><span class="token punctuation">(</span>base64Codes<span class="token punctuation">)</span><span class="token punctuation">;</span>
                    data<span class="token punctuation">.</span><span class="token function">append</span><span class="token punctuation">(</span><span class="token string">'token'</span><span class="token punctuation">,</span> that<span class="token punctuation">.</span>uploadToken<span class="token punctuation">)</span><span class="token punctuation">;</span>
                    data<span class="token punctuation">.</span><span class="token function">append</span><span class="token punctuation">(</span><span class="token string">'file'</span><span class="token punctuation">,</span> file<span class="token punctuation">)</span>
                    that<span class="token punctuation">.</span><span class="token function">axios</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
                        method<span class="token punctuation">:</span> <span class="token string">'post'</span><span class="token punctuation">,</span>
                        url<span class="token punctuation">:</span> <span class="token string">'http://upload-z2.qiniup.com'</span><span class="token punctuation">,</span>
                        data<span class="token punctuation">,</span>
                        headers<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                            <span class="token string">'Content-Type'</span><span class="token punctuation">:</span> <span class="token string">'multipart/form-data'</span>
                            <span class="token comment">// 'X-Requested-With': 'XMLHttpRequest'</span>
                        <span class="token punctuation">}</span>
                    <span class="token punctuation">}</span><span class="token punctuation">)</span>
                    <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>res <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
                        that<span class="token punctuation">.</span>producImg <span class="token operator">=</span> <span class="token string">'http://dingdanimage.ibabybaby.com/'</span> <span class="token operator">+</span> res<span class="token punctuation">.</span>data<span class="token punctuation">.</span>key
                    <span class="token punctuation">}</span><span class="token punctuation">)</span>
                    <span class="token punctuation">.</span><span class="token keyword">catch</span><span class="token punctuation">(</span>err <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
                        <span class="token function">Toast</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span>
                    <span class="token punctuation">}</span><span class="token punctuation">)</span>
                <span class="token punctuation">}</span>
                <span class="token punctuation">)</span><span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
                    data<span class="token punctuation">.</span><span class="token function">append</span><span class="token punctuation">(</span><span class="token string">'token'</span><span class="token punctuation">,</span> that<span class="token punctuation">.</span>uploadToken<span class="token punctuation">)</span><span class="token punctuation">;</span>
                    data<span class="token punctuation">.</span><span class="token function">append</span><span class="token punctuation">(</span><span class="token string">'file'</span><span class="token punctuation">,</span> file<span class="token punctuation">)</span>
                    that<span class="token punctuation">.</span><span class="token function">axios</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
                        method<span class="token punctuation">:</span> <span class="token string">'post'</span><span class="token punctuation">,</span>
                        url<span class="token punctuation">:</span> <span class="token string">'http://upload-z2.qiniup.com'</span><span class="token punctuation">,</span>
                        data<span class="token punctuation">,</span>
                        headers<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                            <span class="token string">'Content-Type'</span><span class="token punctuation">:</span> <span class="token string">'multipart/form-data'</span>
                            <span class="token comment">// 'X-Requested-With': 'XMLHttpRequest'</span>
                        <span class="token punctuation">}</span>
                    <span class="token punctuation">}</span><span class="token punctuation">)</span>
                    <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>res <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
                        that<span class="token punctuation">.</span>producImg <span class="token operator">=</span> <span class="token string">'http://dingdanimage.ibabybaby.com/'</span> <span class="token operator">+</span> res<span class="token punctuation">.</span>data<span class="token punctuation">.</span>key
                    <span class="token punctuation">}</span><span class="token punctuation">)</span>
                    <span class="token punctuation">.</span><span class="token keyword">catch</span><span class="token punctuation">(</span>err <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
                        <span class="token function">Toast</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span>
                    <span class="token punctuation">}</span><span class="token punctuation">)</span>
                <span class="token punctuation">}</span>
                <span class="token comment">// data.append('token', this.uploadToken);     //七牛需要的token，叫后台给，是七牛账号密码等组成的hash</span>
                <span class="token comment">// data.append('file', file);</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token function">created</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
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
                
{% endraw %}
