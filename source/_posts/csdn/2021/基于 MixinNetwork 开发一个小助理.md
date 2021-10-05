---
title: 基于 MixinNetwork 开发一个小助理
date: 2021-09-30 18:07:46
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/120570817)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h1><a id="Mixin__1"></a>Mixin 小助理开发</h1> 
<p><a href="https://github.com/liuzemei/mixin-course-assistant">github仓库请点击</a></p> 
<p><a href="https://developers.mixinbots.com/courses/1e276ee9-18fb-42e3-915a-54b049679084/89329795-c5a2-4aa5-ab32-c52cf6649916">视频教程请点击</a></p> 
<p>本仓库旨在为学习 mixin messenger 的开发。<br> 学习完，将会熟悉</p> 
<ul><li>通过机器人与 mixin messenger 的用户进行消息通信</li><li>根据 <code>user_id/identity_number</code> 获取用户详情</li><li>根据 <code>asset_id/symbol</code> 查询 mixin network 的资产详情</li><li>根据 日期、机器人id、用户id，构建唯一的转账 id</li><li>通过机器人跟用户转账</li><li>将 url 构建成二维码，然后上传到 mixin 服务器，并发送给用户</li><li>文章消息/文本消息/图片消息/联系人消息/按钮消息 的发送</li><li>通过按钮组来让用户选择输入。</li></ul> 
<h3><a id="1__17"></a>1. 小助理介绍</h3> 
<p>（小助理机器人ID： 7000101422）主要是提供消息触发的服务机制。支持如下功能：</p> 
<ul><li>用户相关：发送 <code>user_id</code> 或 <code>identity_number</code> 回复指定用户的卡片及相关信息</li><li>资产相关：发送 <code>asset_id</code> 或者 <code>symbol</code> 回复指定资产相关信息</li></ul> 
<h3><a id="2__23"></a>2. 课程大纲</h3> 
<ol><li>项目搭建与初始化 sdk</li><li>完成用户相关逻辑</li><li>完成资产相关逻辑</li><li>完成签到相关逻辑</li><li>完成打赏相关逻辑</li><li>完成帮助相关逻辑</li><li>组装上述逻辑</li></ol> 
<h3><a id="3__32"></a>3. 正式开始开发</h3> 
<h4><a id="31___websocket_sdk_33"></a>3.1 项目搭建 与 websocket sdk引入</h4> 
<ol><li>项目搭建与初始化</li></ol> 
<blockquote> 
 <p>打开终端初始化项目</p> 
</blockquote> 
<pre><code class="prism language-shell"><span class="token function">mkdir</span> mixin-course-assistant
<span class="token builtin class-name">cd</span> mixin-course-assistant
<span class="token function">npm</span> init -y
<span class="token function">npm</span> <span class="token function">install</span> mixin-node-sdk
</code></pre> 
<ol start="2"><li>在根目录下添加环境变量 config.json<br> /config.json</li></ol> 
<pre><code class="prism language-json"><span class="token punctuation">{<!-- --></span>
  <span class="token string">"pin"</span><span class="token operator">:</span> <span class="token string">""</span><span class="token punctuation">,</span>
  <span class="token string">"client_id"</span><span class="token operator">:</span> <span class="token string">""</span><span class="token punctuation">,</span>
  <span class="token string">"session_id"</span><span class="token operator">:</span> <span class="token string">""</span><span class="token punctuation">,</span>
  <span class="token string">"pin_token"</span><span class="token operator">:</span> <span class="token string">""</span><span class="token punctuation">,</span>
  <span class="token string">"private_key"</span><span class="token operator">:</span> <span class="token string">""</span>
<span class="token punctuation">}</span>
</code></pre> 
<ol start="3"><li> <p>在根目录下创建 index.js</p> </li><li> <p>由于是消息服务，所以我们得连接 Mixin 的 websocket 用于接受消息</p> </li></ol> 
<pre><code class="prism language-js"><span class="token keyword">const</span> <span class="token punctuation">{<!-- --></span> BlazeClient <span class="token punctuation">}</span> <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'mixin-node-sdk'</span><span class="token punctuation">)</span>
<span class="token keyword">const</span> config <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'./config.json'</span><span class="token punctuation">)</span>

<span class="token comment">// 这里的 parse:true 是sdk来解析 base64 的消息</span>
<span class="token comment">// 这里的 syncAck:true 是sdk来帮我们 ack 消息</span>
<span class="token keyword">const</span> client <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">BlazeClient</span><span class="token punctuation">(</span>config<span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span> parse<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> syncAck<span class="token operator">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span><span class="token punctuation">)</span>

client<span class="token punctuation">.</span><span class="token function">loopBlaze</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
  <span class="token function">onMessage</span><span class="token punctuation">(</span><span class="token parameter">msg</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token comment">// 我们不处理 ack 的消息，所以放一个空函数，这样就不会走到 onMessage 的逻辑里</span>
  <span class="token function">onAckReceipt</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<ol start="5"><li>测试消息服务<br> 打开终端</li></ol> 
<pre><code class="prism language-shell">node index.js
</code></pre> 
<blockquote> 
 <p>打开手机跟自己的机器人发一条消息。看终端是否能打印出发送的消息。如果能，说明 websocket 连接成功。</p> 
</blockquote> 
<h4><a id="2__user_id__identity_number__83"></a>2. 编写 user_id 和 identity_number 的用户查询</h4> 
<ol><li>逻辑分析 
  <ul><li>用户给机器人发送 <code>user_id</code> 或 <code>identity_number</code></li><li>机器人收到消息后，进行查询。</li><li>如果没查到，说明用户的输入错误，结束。</li><li>如果查到了，则给用户发送卡片、转账button、转账二维码。</li><li>如果确认用户输入的是 <code>identity_number</code> ，则再多给用户发送一条 <code>user_id</code></li></ul> </li><li>代码实现</li></ol> 
<pre><code class="prism language-js"><span class="token keyword">const</span> QRCode <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'qrcode'</span><span class="token punctuation">)</span>
<span class="token comment">/**
 * 处理 identity_number 或者 user_id
 * 1. 联系人卡片 2. transfer btn 3. transfer qrcode 4. identity_number -&gt; user_id
 * @returns {boolean} 如果判断成功，那么回复消息并返回 true，否则返回 false
 * @param {<!-- -->{data: '', user_id: ''}} msg 
 */</span>
<span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">handleUser</span><span class="token punctuation">(</span><span class="token parameter"><span class="token punctuation">{<!-- --></span> data<span class="token punctuation">,</span> user_id <span class="token punctuation">}</span></span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token keyword">const</span> user <span class="token operator">=</span> <span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">readUser</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span> <span class="token comment">// 根据用户的输入来查询 user</span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span>user <span class="token operator">&amp;&amp;</span> user<span class="token punctuation">.</span>user_id<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 走到这里说明 user 已经查询到了。</span>
    <span class="token keyword">const</span> transferAction <span class="token operator">=</span> <span class="token template-string"><span class="token template-punctuation string">`</span><span class="token string">mixin://transfer/</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>user<span class="token punctuation">.</span>user_id<span class="token interpolation-punctuation punctuation">}</span></span><span class="token template-punctuation string">`</span></span> <span class="token comment">// 定义一个 transfer 的 schema 后边要用，</span>
    <span class="token comment">// 这里同时发送3-4条消息所以使用 promise.all</span>
    Promise<span class="token punctuation">.</span><span class="token function">all</span><span class="token punctuation">(</span><span class="token punctuation">[</span>
      client<span class="token punctuation">.</span><span class="token function">sendContactMsg</span><span class="token punctuation">(</span> <span class="token comment">// 给用户发送联系人卡片</span>
        user_id<span class="token punctuation">,</span>
        <span class="token punctuation">{<!-- --></span> user_id<span class="token operator">:</span> user<span class="token punctuation">.</span>user_id <span class="token punctuation">}</span>
      <span class="token punctuation">)</span><span class="token punctuation">,</span>
      client<span class="token punctuation">.</span><span class="token function">sendAppButtonMsg</span><span class="token punctuation">(</span> <span class="token comment">// 给用户发送转账的 button</span>
        user_id<span class="token punctuation">,</span>
        <span class="token punctuation">[</span>
          <span class="token punctuation">{<!-- --></span>
            label<span class="token operator">:</span> <span class="token template-string"><span class="token template-punctuation string">`</span><span class="token string">Transfer to </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>user<span class="token punctuation">.</span>full_name<span class="token interpolation-punctuation punctuation">}</span></span><span class="token template-punctuation string">`</span></span><span class="token punctuation">,</span>
            action<span class="token operator">:</span> transferAction<span class="token punctuation">,</span>
            color<span class="token operator">:</span> <span class="token string">'#000'</span>
          <span class="token punctuation">}</span>
        <span class="token punctuation">]</span>
      <span class="token punctuation">)</span><span class="token punctuation">,</span>
      <span class="token keyword">new</span> <span class="token class-name">Promise</span><span class="token punctuation">(</span><span class="token parameter">resolve</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 给用户发送转账的二维码</span>
        QRCode<span class="token punctuation">.</span><span class="token function">toBuffer</span><span class="token punctuation">(</span> <span class="token comment">// 将 transferAction -&gt; jpeg 的 buf</span>
          transferAction<span class="token punctuation">,</span>
          <span class="token keyword">async</span> <span class="token punctuation">(</span><span class="token parameter">err<span class="token punctuation">,</span> buf</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">const</span> <span class="token punctuation">{<!-- --></span> attachment_id <span class="token punctuation">}</span> <span class="token operator">=</span> <span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">uploadFile</span><span class="token punctuation">(</span>buf<span class="token punctuation">)</span> <span class="token comment">// 上传 buf</span>
            <span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">sendImageMsg</span><span class="token punctuation">(</span>user_id<span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 发送图片消息</span>
              attachment_id<span class="token punctuation">,</span> <span class="token comment">// 资源id</span>
              mime_type<span class="token operator">:</span> <span class="token string">"image/jpeg"</span><span class="token punctuation">,</span> 
              width<span class="token operator">:</span> <span class="token number">300</span><span class="token punctuation">,</span>
              height<span class="token operator">:</span> <span class="token number">300</span><span class="token punctuation">,</span>
              size<span class="token operator">:</span> buf<span class="token punctuation">.</span>length<span class="token punctuation">,</span>
              thumbnail<span class="token operator">:</span> Buffer<span class="token punctuation">.</span><span class="token function">from</span><span class="token punctuation">(</span>buf<span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">toString</span><span class="token punctuation">(</span><span class="token string">'base64'</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token comment">// 封面， buf 的base64</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span>
            <span class="token function">resolve</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
          <span class="token punctuation">}</span><span class="token punctuation">)</span>
      <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
      <span class="token keyword">new</span> <span class="token class-name">Promise</span><span class="token punctuation">(</span><span class="token keyword">async</span> <span class="token parameter">resolve</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 如果用户查询的是 identity_number 的话，则给用户发送 user_id</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token function">String</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span> <span class="token operator">===</span> user<span class="token punctuation">.</span>identity_number<span class="token punctuation">)</span>
          <span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">sendTextMsg</span><span class="token punctuation">(</span>user_id<span class="token punctuation">,</span> user<span class="token punctuation">.</span>user_id<span class="token punctuation">)</span>
        <span class="token function">resolve</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
      <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span>
    <span class="token keyword">return</span> <span class="token boolean">true</span>
  <span class="token punctuation">}</span>
  <span class="token keyword">return</span> <span class="token boolean">false</span>
<span class="token punctuation">}</span>
</code></pre> 
<ol start="3"><li>测试</li></ol> 
<pre><code class="prism language-js"><span class="token comment">//...</span>
client<span class="token punctuation">.</span><span class="token function">loopBlaze</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
  <span class="token function">onMessage</span><span class="token punctuation">(</span><span class="token parameter">msg</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// 改造一下这里</span>
    <span class="token function">handleUser</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token function">onAckReceipt</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//...</span>
</code></pre> 
<blockquote> 
 <ol><li>使用 mixin 移动端给机器人发送 <code>30265</code> ，看机器人是否会返回 4 条消息。</li><li>再把返回的 <code>user_id</code> 发送给机器人，看机器人是否会返回跟第一步相同的 3 条消息。</li><li>如果是则说明测试通过。</li></ol> 
</blockquote> 
<h4><a id="3__asset_id__symbol__166"></a>3. 编写 asset_id 和 symbol 的资产查询</h4> 
<ol><li>逻辑分析 
  <ul><li>用户给机器人发送 <code>asset_id</code> 或 <code>symbol</code></li><li>机器人收到消息后，进行查询。</li><li>如果没查到，说明用户的输入错误，结束。</li><li>如果查到了，则给用户发送查询到的 文章 消息，</li><li>如果确认用户输入的是 <code>symbol</code> ，则再多给用户发送一条 <code>asset_id</code>(查到的第1个资产第asset_id)</li></ul> </li><li>代码实现</li></ol> 
<pre><code class="prism language-js"><span class="token keyword">const</span> <span class="token punctuation">{<!-- --></span> validate<span class="token operator">:</span> isUUID <span class="token punctuation">}</span> <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'uuid'</span><span class="token punctuation">)</span> <span class="token comment">// mixin-node-sdk 包里有 uuid 了，所以可以直接引入</span>
<span class="token comment">/**
 * 处理 asset_id 或者 symbol
 * 1. 资产相关的文章消息 2. symbol -&gt; [0].asset_id
 * @returns {boolean} 如果判断成功，那么回复消息并返回 true，否则返回 false
 * @param {<!-- -->{data: '', user_id: ''}} msg 
 */</span>
<span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">handleAsset</span><span class="token punctuation">(</span><span class="token parameter"><span class="token punctuation">{<!-- --></span> data<span class="token punctuation">,</span> user_id <span class="token punctuation">}</span></span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token function">isUUID</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// 说明有可能是 asset_id</span>
    <span class="token keyword">const</span> asset <span class="token operator">=</span> <span class="token keyword">await</span> <span class="token function">readNetworkAsset</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span>asset <span class="token operator">&amp;&amp;</span> asset<span class="token punctuation">.</span>asset_id<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
      <span class="token comment">// 说明是 asset_id，且已经查询到了</span>
      <span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">sendPostMsg</span><span class="token punctuation">(</span>user_id<span class="token punctuation">,</span> <span class="token string">'```json\n'</span> <span class="token operator">+</span>
        <span class="token constant">JSON</span><span class="token punctuation">.</span><span class="token function">stringify</span><span class="token punctuation">(</span>asset<span class="token punctuation">,</span> <span class="token keyword">null</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">)</span> <span class="token operator">+</span>
        <span class="token string">'\n```'</span><span class="token punctuation">)</span><span class="token comment">// 发送 json 格式的 markdown</span>
      <span class="token keyword">return</span> <span class="token boolean">true</span>
    <span class="token punctuation">}</span>
  <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// 说明有可能是 symbol</span>
    <span class="token keyword">const</span> assets <span class="token operator">=</span> <span class="token keyword">await</span> <span class="token function">searchNetworkAsset</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span>assets<span class="token punctuation">.</span>length <span class="token operator">&gt;</span> <span class="token number">0</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
      <span class="token comment">// 说明是 symbol，且已经查询到了</span>
      <span class="token keyword">await</span> Promise<span class="token punctuation">.</span><span class="token function">all</span><span class="token punctuation">(</span><span class="token punctuation">[</span>
        client<span class="token punctuation">.</span><span class="token function">sendPostMsg</span><span class="token punctuation">(</span>user_id<span class="token punctuation">,</span> <span class="token string">'```json\n'</span> <span class="token operator">+</span>
          <span class="token constant">JSON</span><span class="token punctuation">.</span><span class="token function">stringify</span><span class="token punctuation">(</span>assets<span class="token punctuation">,</span> <span class="token keyword">null</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">)</span> <span class="token operator">+</span>
          <span class="token string">'\n```'</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token comment">// 返回 json 格式的 markdown</span>
        client<span class="token punctuation">.</span><span class="token function">sendTextMsg</span><span class="token punctuation">(</span>user_id<span class="token punctuation">,</span> assets<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">.</span>asset_id<span class="token punctuation">)</span> <span class="token comment">// 返回 查询到的第一个 asset_id</span>
      <span class="token punctuation">]</span><span class="token punctuation">)</span>
      <span class="token keyword">return</span> <span class="token boolean">true</span>
    <span class="token punctuation">}</span>
  <span class="token punctuation">}</span>
  <span class="token keyword">return</span> <span class="token boolean">false</span>
<span class="token punctuation">}</span>
</code></pre> 
<ol start="3"><li>测试</li></ol> 
<pre><code class="prism language-js"><span class="token comment">//...</span>
client<span class="token punctuation">.</span><span class="token function">loopBlaze</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
  <span class="token function">onMessage</span><span class="token punctuation">(</span><span class="token parameter">msg</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// 改造一下这里</span>
    <span class="token function">handleAsset</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token function">onAckReceipt</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//...</span>
</code></pre> 
<blockquote> 
 <ol><li>使用 mixin 移动端给机器人发送 <code>btc</code> ，看机器人是否会返回 2 条消息。</li><li>再把返回的 <code>asset_id</code> 发送给机器人，看机器人是否会返回 1 条 btc 的资产相关消息。</li><li>如果是则说明测试通过。</li></ol> 
</blockquote> 
<h4><a id="4__claim__1_CNB_231"></a>4. 编写 <code>/claim</code> 向机器人签到并领取 1 CNB</h4> 
<ol><li>逻辑分析 
  <ul><li>用户给机器人发送 <code>/claim</code></li><li>机器人收到消息后，进行查询该用户是否领取。</li><li>如果已领取，则发送 <code>您今日已领取，请明日再来。</code></li><li>如果没领取，则向该用户转账 <code>1cnb</code></li></ul> </li><li>代码实现</li></ol> 
<pre><code class="prism language-js"><span class="token keyword">const</span> cnb_asset_id <span class="token operator">=</span> <span class="token string">'965e5c6e-434c-3fa9-b780-c50f43cd955c'</span> <span class="token comment">// 预先查询到了 cnb 的 asset_id 备用。</span>
<span class="token comment">/**
 * 处理 /claim 的消息
 * 1. 给用户转账 1 cnb
 * @returns {boolean} 如果判断成功，那么回复消息并返回 true，否则返回 false
 * @param {<!-- -->{data: '', user_id: ''}} msg 
 */</span>
<span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">handleClaim</span><span class="token punctuation">(</span><span class="token parameter"><span class="token punctuation">{<!-- --></span>data<span class="token punctuation">,</span> user_id<span class="token punctuation">}</span></span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token keyword">const</span> trace_id <span class="token operator">=</span> client<span class="token punctuation">.</span><span class="token function">uniqueConversationID</span><span class="token punctuation">(</span>
    user_id <span class="token operator">+</span> client<span class="token punctuation">.</span>keystore<span class="token punctuation">.</span>client_id<span class="token punctuation">,</span>
    <span class="token keyword">new</span> <span class="token class-name">Date</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">toDateString</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
  <span class="token punctuation">)</span> <span class="token comment">// 用户这个用户今天唯一的 trace_id</span>
  <span class="token keyword">const</span> transfer <span class="token operator">=</span> <span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">readTransfer</span><span class="token punctuation">(</span>trace_id<span class="token punctuation">)</span> <span class="token comment">// 查询今天是否领取过</span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span>transfer <span class="token operator">&amp;&amp;</span> transfer<span class="token punctuation">.</span>snapshot_id<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// 已经领取</span>
    <span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">sendMessageText</span><span class="token punctuation">(</span>
      user_id<span class="token punctuation">,</span>
      <span class="token string">'您今日已领取，请明日再来。'</span>
    <span class="token punctuation">)</span>
  <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// 否则的话给用户转 1 cnb</span>
    <span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">transfer</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
      trace_id<span class="token punctuation">,</span> 
      asset_id<span class="token operator">:</span> cnb_asset_id<span class="token punctuation">,</span>
      amount<span class="token operator">:</span> <span class="token string">'1'</span><span class="token punctuation">,</span>
      opponent_id<span class="token operator">:</span> user_id<span class="token punctuation">,</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> 
<ol start="3"><li>测试</li></ol> 
<pre><code class="prism language-js"><span class="token comment">//...</span>
client<span class="token punctuation">.</span><span class="token function">loopBlaze</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
  <span class="token function">onMessage</span><span class="token punctuation">(</span><span class="token parameter">msg</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// 改造一下这里</span>
    <span class="token function">handleClaim</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token function">onAckReceipt</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//...</span>
</code></pre> 
<blockquote> 
 <ol><li>使用 mixin 移动端给机器人发送 <code>/claim</code> ，看机器人是否转账 1 cnb</li><li>再发送一次 <code>/claim</code> ，看机器人是否回复 <code>您今日已领取，请明日再来。</code></li><li>如果是则说明测试通过。</li></ol> 
</blockquote> 
<h4><a id="5__donate__288"></a>5. 编写 <code>/donate</code> 向机器人获取机器人转账地址</h4> 
<ol><li>逻辑分析 
  <ul><li>用户给机器人发送 <code>/donate</code></li><li>机器人收到消息后，给用户发送自己的转账按钮</li><li>若用户成功转账，则向用户回复 “打赏的 {amount}{symbol} 已收到，感谢您的支持。”</li></ul> </li><li>代码实现</li></ol> 
<pre><code class="prism language-js"><span class="token comment">// 1. 直接回复 donate 的按钮</span>
<span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">handleDonate</span><span class="token punctuation">(</span><span class="token parameter"><span class="token punctuation">{<!-- --></span>user_id<span class="token punctuation">}</span></span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  client<span class="token punctuation">.</span><span class="token function">sendAppButtonMsg</span><span class="token punctuation">(</span> <span class="token comment">// 给用户发送 donate 的 button</span>
    user_id<span class="token punctuation">,</span>
    <span class="token punctuation">[</span>
      <span class="token punctuation">{<!-- --></span>
        label<span class="token operator">:</span> <span class="token template-string"><span class="token template-punctuation string">`</span><span class="token string">点击向我捐赠</span><span class="token template-punctuation string">`</span></span><span class="token punctuation">,</span>
        action<span class="token operator">:</span> <span class="token template-string"><span class="token template-punctuation string">`</span><span class="token string">mixin://transfer/</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>client<span class="token punctuation">.</span>keystore<span class="token punctuation">.</span>client_id<span class="token interpolation-punctuation punctuation">}</span></span><span class="token template-punctuation string">`</span></span><span class="token punctuation">,</span>
        color<span class="token operator">:</span> <span class="token string">'#000'</span>
      <span class="token punctuation">}</span>
    <span class="token punctuation">]</span>
  <span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">// 2. 在 loopBlaze 的地方，需要监听收到转账的消息。</span>
client<span class="token punctuation">.</span><span class="token function">loopBlaze</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
  <span class="token operator">...</span><span class="token punctuation">,</span>
  <span class="token keyword">async</span> <span class="token function">onTransfer</span><span class="token punctuation">(</span><span class="token parameter"><span class="token punctuation">{<!-- --></span> data<span class="token punctuation">,</span> user_id <span class="token punctuation">}</span></span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token keyword">const</span> <span class="token punctuation">{<!-- --></span> amount<span class="token punctuation">,</span> asset_id <span class="token punctuation">}</span> <span class="token operator">=</span> data
    <span class="token keyword">const</span> <span class="token punctuation">{<!-- --></span> symbol <span class="token punctuation">}</span> <span class="token operator">=</span> <span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">readAsset</span><span class="token punctuation">(</span>asset_id<span class="token punctuation">)</span>
    client<span class="token punctuation">.</span><span class="token function">sendMessageText</span><span class="token punctuation">(</span>user_id<span class="token punctuation">,</span> <span class="token template-string"><span class="token template-punctuation string">`</span><span class="token string">打赏的 </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>amount<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string"> </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>symbol<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string"> 已收到，感谢您的支持。</span><span class="token template-punctuation string">`</span></span><span class="token punctuation">)</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h4><a id="6___2__321"></a>6. 帮助信息 + 2 个交互按钮</h4> 
<pre><code class="prism language-js"><span class="token keyword">const</span> helpMsg <span class="token operator">=</span> <span class="token template-string"><span class="token template-punctuation string">`</span><span class="token string">
1. 支持用户查询，请发送 user_id | identity_number
2. 支持资产查询，请发送 asset_id | symbol
3. 支持每日领取 1cnb，请发送 /claim 或点击签到
4. 支持打赏，请发送 /donate 或点击打赏
</span><span class="token template-punctuation string">`</span></span>
<span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">sendHelpMsgWithInfo</span><span class="token punctuation">(</span><span class="token parameter">user_id<span class="token punctuation">,</span> info</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 发送帮助消息</span>
  <span class="token keyword">await</span> Promise<span class="token punctuation">.</span><span class="token function">all</span><span class="token punctuation">(</span><span class="token punctuation">[</span>
    client<span class="token punctuation">.</span><span class="token function">sendTextMsg</span><span class="token punctuation">(</span>user_id<span class="token punctuation">,</span> info <span class="token operator">+</span> helpMsg<span class="token punctuation">)</span><span class="token punctuation">,</span>
    client<span class="token punctuation">.</span><span class="token function">sendAppButtonMsg</span><span class="token punctuation">(</span>user_id<span class="token punctuation">,</span> <span class="token punctuation">[</span>
      <span class="token punctuation">{<!-- --></span> label<span class="token operator">:</span> <span class="token string">"签到"</span><span class="token punctuation">,</span> action<span class="token operator">:</span> <span class="token string">"input:/claim"</span><span class="token punctuation">,</span> color<span class="token operator">:</span> <span class="token string">"#000"</span> <span class="token punctuation">}</span><span class="token punctuation">,</span>
      <span class="token punctuation">{<!-- --></span> label<span class="token operator">:</span> <span class="token string">"打赏"</span><span class="token punctuation">,</span> action<span class="token operator">:</span> <span class="token string">"input:/donate"</span><span class="token punctuation">,</span> color<span class="token operator">:</span> <span class="token string">"#000"</span> <span class="token punctuation">}</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span>
  <span class="token punctuation">]</span><span class="token punctuation">)</span>
  <span class="token keyword">return</span> <span class="token boolean">true</span>
<span class="token punctuation">}</span>
</code></pre> 
<h4><a id="7__341"></a>7. 组装逻辑</h4> 
<ol><li>逻辑分析</li></ol> 
<ul><li>如果用户输入的是 非文本消息，直接结束</li><li>如果用户输入的是 <code>/claim</code> 则直接走 <code>handleClaim</code>，然后直接结束</li><li>如果用户输入的是 <code>/donate</code> 则直接走 <code>handleDonate</code>，然后直接结束</li><li>如果用户输入的是 <code>uuid</code> 则同时查询 <code>user</code> 和 <code>asset</code>，然后结束</li><li>如果用户输入的是 <code>数字</code> 则只查询 <code>user</code>，然后结束</li><li>如果用户输入的是 <code>非数字</code> 则只查询 <code>asset</code>，然后结束</li><li>结束后判断，如果是 false，则返回帮助信息 + 2个 button</li></ul> 
<ol start="2"><li>代码实现</li></ol> 
<pre><code class="prism language-js"><span class="token comment">/**
 * 处理消息，如果处理成功则返回 true，否则返回 false
 * @param {<!-- -->{data: String, user_id: String}} msg 
 * @returns {boolean}
 */</span>
<span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">handleMsg</span><span class="token punctuation">(</span><span class="token parameter">msg</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token keyword">const</span> <span class="token punctuation">{<!-- --></span> data<span class="token punctuation">,</span> category<span class="token punctuation">,</span> user_id <span class="token punctuation">}</span> <span class="token operator">=</span> msg
  <span class="token keyword">if</span> <span class="token punctuation">(</span>category <span class="token operator">!==</span> <span class="token string">'PLAIN_TEXT'</span><span class="token punctuation">)</span>
    <span class="token keyword">return</span> <span class="token function">sendHelpMsgWithInfo</span><span class="token punctuation">(</span>user_id<span class="token punctuation">,</span> <span class="token string">"仅支持文本消息。"</span><span class="token punctuation">)</span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span>data <span class="token operator">===</span> <span class="token string">'/claim'</span><span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token function">handleClaim</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span> <span class="token comment">// 处理 /claim 消息</span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span>data <span class="token operator">===</span> <span class="token string">'/donate'</span><span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token function">handleDonate</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span> <span class="token comment">// 处理 /donate 消息</span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token function">isUUID</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 处理 uuid 消息</span>
    <span class="token keyword">const</span> res <span class="token operator">=</span> <span class="token keyword">await</span> Promise<span class="token punctuation">.</span><span class="token function">all</span><span class="token punctuation">(</span><span class="token punctuation">[</span>
      <span class="token function">handleUser</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span><span class="token punctuation">,</span>
      <span class="token function">handleAsset</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span>
    <span class="token punctuation">]</span><span class="token punctuation">)</span>
    <span class="token keyword">return</span> res<span class="token punctuation">.</span><span class="token function">some</span><span class="token punctuation">(</span><span class="token parameter">v</span> <span class="token operator">=&gt;</span> v<span class="token punctuation">)</span>
  <span class="token punctuation">}</span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token function">isNaN</span><span class="token punctuation">(</span><span class="token function">Number</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token function">handleAsset</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span> <span class="token comment">// 处理 symbol -&gt; assets 的消息</span>
  <span class="token keyword">else</span> <span class="token keyword">return</span> <span class="token function">handleUser</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span> <span class="token comment">// 处理 identity_number -&gt; user 的消息</span>
<span class="token punctuation">}</span>

</code></pre> 
<ol start="3"><li>在 <code>onMessage</code> 中调用。</li></ol> 
<pre><code class="prism language-js"><span class="token comment">//...</span>
client<span class="token punctuation">.</span><span class="token function">loopBlaze</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
  <span class="token comment">// 改造一下这里</span>
  <span class="token keyword">async</span> <span class="token function">onMessage</span><span class="token punctuation">(</span><span class="token parameter">msg</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token keyword">const</span> isHandle <span class="token operator">=</span> <span class="token keyword">await</span> <span class="token function">handleMsg</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span>
    <span class="token keyword">if</span><span class="token punctuation">(</span><span class="token operator">!</span>isHandle<span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token function">sendHelpMsgWithInfo</span><span class="token punctuation">(</span>msg<span class="token punctuation">.</span>user_id<span class="token punctuation">,</span> <span class="token string">"指令输入不正确。"</span><span class="token punctuation">)</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token function">onAckReceipt</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token function">onTransfer</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 这里可以再忽略一下转账消息</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//...</span>
</code></pre> 
<ol start="4"><li>测试</li></ol> 
<blockquote> 
 <p>可以把上述的测试全部再走一遍。<br> 全部通过，说明测试成功。</p> 
</blockquote>
                
{% endraw %}
