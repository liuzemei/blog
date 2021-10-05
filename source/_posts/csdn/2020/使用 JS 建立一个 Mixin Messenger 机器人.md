---
title: 使用 JS 建立一个 Mixin Messenger 机器人
date: 2020-02-26 19:02:22
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/104522660)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <blockquote> 
 <p>官方推荐使用 golang ，对于前端人员的学习门槛还是有一些。所以在这里发布一个 js 写的教程。</p> 
</blockquote> 
<p>读完此篇文章您将获得：</p> 
<blockquote> 
 <p>一个收到消息会自动回复 hello mixin 的机器人。</p> 
</blockquote> 
<h3><a id="1__5"></a>1. 开发基础</h3> 
<ul><li>node 环境，笔者目前使用<code>v10.15.1</code>，更高亦可。</li><li>JavaScript 语法基础</li><li>Mixin 机器人 <code>session</code> 及 <code>secret</code></li></ul> 
<h3><a id="2__10"></a>2. 开发之前</h3> 
<p>能够找到并读到这篇文章，想必对 Mixin 以及 Mixin Messenger 都比较熟知。所以申请 Mixin 机器人的 <code>session</code> 和 <code>secret</code> 并不是本文的主要内容。如有需要请进传送门 <a href="https://www.jianshu.com/p/522e880a4233">Mixin Messenger 机器人接入指南</a></p> 
<blockquote> 
 <p>这个时候，你应该已经获取到了 Mixin 的 <code>session</code> 文件 和 <code>secret</code> 信息。</p> 
</blockquote> 
<p>session文件： 类似 <code>keystore-7000xxxxxx.json</code> 的一个文件。<br> secret： 64 位的一个长字符串。</p> 
<h3><a id="3__18"></a>3. 正式开发</h3> 
<p>其实开发也比较简单。主要依赖 <code>npm</code> 上的一个库 <code>mixin-node-sdk</code>。</p> 
<ol><li>创建并初始化工程</li></ol> 
<pre><code>mkdir js-mixin-bot
cd js-mixin-bot
touch index.js
npm init -y
</code></pre> 
<ol start="2"><li>安装核心库</li></ol> 
<pre><code>npm install mixin-node-sdk
</code></pre> 
<p>推荐使用 yarn ，或者 cnpm 亦可。<br> 3. 开始开发</p> 
<blockquote> 
 <p>可以先仔细看看 <a href="https://github.com/liuzemei/mixin-node-sdk/blob/master/Readme_zh_CN.md">中文文档</a></p> 
</blockquote> 
<pre><code class="prism language-js"><span class="token keyword">const</span> <span class="token punctuation">{<!-- --></span> MixinSocket <span class="token punctuation">}</span> <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'mixin-node-sdk'</span><span class="token punctuation">)</span>

<span class="token keyword">const</span> <span class="token constant">CLIENT_CONFIG</span> <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    client_id<span class="token punctuation">:</span> <span class="token string">'2cc0c869-xxxx-xxxx-xxxx-5b4a99fea2a9'</span><span class="token punctuation">,</span>
    client_secret<span class="token punctuation">:</span> <span class="token string">'f3689c1dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx562b4ff12882fc3bdf'</span><span class="token punctuation">,</span>
    pin<span class="token punctuation">:</span> <span class="token string">'918869'</span><span class="token punctuation">,</span>
    session_id<span class="token punctuation">:</span> <span class="token string">'1510f69c-xxxx-xxxx-xxxx-32560e710cb0'</span><span class="token punctuation">,</span>
    pin_token<span class="token punctuation">:</span> <span class="token string">'LLqI71tUUG0T6J1fZ7piKjrzx/hYxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx1BH7H+NXlV5mLgZ/TGEyPf0UdhgQWZW+33jSveg2YGczfrH667XqwMsO0poYUE0SKy+DlEmV6L4yKG40/aAQ9wNcMpW8zDm7O/r5OtH9o='</span><span class="token punctuation">,</span>
    private_key<span class="token punctuation">:</span> <span class="token template-string"><span class="token string">`-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxcGc250iYf+F7aMr
xPmKo+zlKCxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/Q2xG+F5/ouLfu3
1cBwdZVYoJxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxGkLetuu6QIDAQAB
AoGAFoVnjSxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxE7gnhOc8S4SO96F
7FO3ITwVuKxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxyD/U2kzT0iCwCc4
yr8i6IJ2L4xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxQDRn9OIpGLoFE16
FMDe3eHk40xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxKcWaOsOzWnin9v1
v4mLyw3XAkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxNytyRrUNjP9hGIp
UDsh0XJpJcxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx6qCn1YDEn3b5iq8
ta/775fPH2xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxkgUXm6KRQJAPP2m
2rZhA5abZExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxrnF+cyi5ufEfMcz
l4LzCpjTmfxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxfE8l2D1wQvwsa1/
fJ8KHnfjWjERGVnquCUm73MDJnXxqbivoXolv4tkuA==
-----END RSA PRIVATE KEY-----
`</span></span>
<span class="token punctuation">}</span>

<span class="token keyword">let</span> socket_client <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">MixinSocket</span><span class="token punctuation">(</span><span class="token constant">CLIENT_CONFIG</span><span class="token punctuation">)</span>
<span class="token comment">// 1.  重写这个接受消息的函数</span>
<span class="token comment">// 注意：有一个参数 message</span>
socket_client<span class="token punctuation">.</span>get_message_handler <span class="token operator">=</span> <span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>message<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>message<span class="token punctuation">.</span>action <span class="token operator">||</span> message<span class="token punctuation">.</span>action <span class="token operator">===</span> <span class="token string">'ACKNOWLEDGE_MESSAGE_RECEIPT'</span> <span class="token operator">||</span> message<span class="token punctuation">.</span>action <span class="token operator">===</span> <span class="token string">'LIST_PENDING_MESSAGES'</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">return</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span>message<span class="token punctuation">.</span>error<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>message<span class="token punctuation">.</span>error<span class="token punctuation">)</span>
        <span class="token keyword">return</span>
    <span class="token punctuation">}</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span>message<span class="token punctuation">.</span>data<span class="token punctuation">.</span>category <span class="token operator">===</span> <span class="token string">''</span><span class="token punctuation">)</span> <span class="token keyword">return</span>
    <span class="token comment">// 获取消息</span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>message<span class="token punctuation">)</span>
    <span class="token comment">// 执行已读消息</span>
    <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token function">read_message</span><span class="token punctuation">(</span>message<span class="token punctuation">)</span>
    <span class="token comment">// 发送文本消息</span>
    <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token function">send_text</span><span class="token punctuation">(</span><span class="token string">'hello mixin'</span><span class="token punctuation">,</span> message<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">// 2. 打开 websocket</span>
socket_client<span class="token punctuation">.</span><span class="token function">start</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
</code></pre> 
<ol start="4"><li>启动</li></ol> 
<pre><code>node index.js
</code></pre> 
<ol start="5"><li> <p>结束…<br> 去掉注释和配置的 config 信息，大概只需要4~5行就完成</p> </li><li> <p>去你的机器人里试试吧。<br> 发送任意信息，都会给你回复 hello mixin 的。</p> </li></ol>
                
{% endraw %}
