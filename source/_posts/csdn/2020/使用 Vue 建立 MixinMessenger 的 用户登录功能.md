---
title: 使用 Vue 建立 MixinMessenger 的 用户登录功能
date: 2020-03-09 11:45:14
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/104749122)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <blockquote> 
 <p>项目中不涉及后端代码，仅供学习参考使用。关于API的使用，详情请参见文档：<a href="https://developers.mixin.one/api">Mixin API</a>，或者部分 <a href="http://mixindocument.liuzemei.com">中文文档</a></p> 
</blockquote> 
<p>读完此篇文章，您将获得</p> 
<blockquote> 
 <ol><li>Mixin Messenger的 <strong>登录</strong> 功能，可以获取用户的基本信息，手机号等信息。</li><li>掌握 Mixin Messenger Auth 的调用流程</li></ol> 
</blockquote> 
<h4><a id="_6"></a>技术栈</h4> 
<blockquote> 
 <p><a href="https://cn.vuejs.org/">Vue.js</a><br> <a href="https://router.vuejs.org/zh/">Vue-Router</a><br> <a href="https://www.kancloud.cn/yunye/axios/234845">Axios</a></p> 
</blockquote> 
<p>这里直接使用的 <a href="https://cli.vuejs.org/zh/">Vue-cli3</a> 创建工程</p> 
<h4><a id="_13"></a>相关代码参见</h4> 
<blockquote> 
 <p><a href="https://github.com/liuzemei/vue-mixin-demo">https://github.com/liuzemei/vue-mixin-demo</a></p> 
</blockquote> 
<h4><a id="Demo__16"></a>Demo 参见</h4> 
<blockquote> 
 <p><a href="http://mixin-auth-demo.liuzemei.com/">http://mixin-auth-demo.liuzemei.com/</a></p> 
</blockquote> 
<p>以下进入正文</p> 
<h2><a id="1__20"></a>1. 基本概念解读</h2> 
<h4><a id="_21"></a>第三方登录</h4> 
<p>相信大家对 QQ、微信 登录 并不陌生，在第一个第三方的平台上，使用 QQ 登录，或者微信扫码登录，然后平台就可以获取到你在 QQ 或者微信 上的头像、昵称，甚至可以授权手机号查看，这样第三方平台就可以获取到你在 QQ或者微信 上保留的手机号信息了。</p> 
<p>Mixin 登录道理也是一样的。我们即将要开发的机器人，就是一个第三方平台，而 Mixin Messenger 就相当于上述的 QQ 或者微信。</p> 
<p>我们的目的很简单，就是让用户省去填写各种繁琐注册信息的麻烦，而直接用 Mixin Messenger 扫码就可以完成注册、登录，并体验您应用的核心功能。</p> 
<h2><a id="2__28"></a>2. 认证思路解读</h2> 
<h4><a id="1__29"></a>1. 认证过程</h4> 
<blockquote> 
 <ol><li>用户打开您的网站</li><li>您的网站发现没有登录(出现登录框或者)，直接自动跳转 Mixin 的认证页面</li><li>用户点击确认授权</li><li>网站自动跳转到相应的页面</li><li>完成认证(注册、登录)</li></ol> 
</blockquote> 
<p>下载 <a href="https://mixin.one/messenger">Mixin Messenger</a> 移动端后，用上述 Demo 扫码即可登录。</p> 
<h2><a id="3__37"></a>3. 从零开始实现</h2> 
<h4><a id="1__Mixin_Application_38"></a>1. 注册一个 Mixin Application</h4> 
<p><a href="https://blog.csdn.net/weixin_41884153/article/details/104535314">详情参见</a></p> 
<h4><a id="2__40"></a>2. 详细代码</h4> 
<p><a href="https://github.com/liuzemei/vue-mixin-demo">https://github.com/liuzemei/vue-mixin-demo</a></p> 
<h4><a id="3__demo_42"></a>3. 运行 demo</h4> 
<ol><li>拉下代码</li></ol> 
<pre><code>git clone https://github.com/liuzemei/vue-mixin-demo
</code></pre> 
<ol start="2"><li>修改机器人信息<br> 更换 <code>keystore.json</code> 的 <code>client_id</code> 和 <code>client_secret</code></li></ol> 
<blockquote> 
 <p>这里的 <code>client_id</code> 和 <code>client_secret</code> 的获取，请看 <code>3.1 注册一个 Mixin Application</code></p> 
</blockquote> 
<ol start="3"><li>更改 <strong>Mixin开发者后台</strong></li></ol> 
<ul><li>打开 <a href="https://developers.mixin.one/dashboard">https://developers.mixin.one/dashboard</a></li><li>找到上述对映 <code>client_id</code> 的机器人。</li><li>首页网址改成： <code>http://localhost:8080</code></li><li>验证网址改成： <code>http://localhost:8080/auth</code></li><li>点击保存。</li></ul> 
<p><img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy82OTYwNzc1LTU4YWI5NDYxNjRmOTBiNjgucG5n?x-oss-process=image/format,png" alt="Mixin开发者后台"></p> 
<ol start="4"><li>回到项目运行</li></ol> 
<pre><code>npm install
npm run dev
</code></pre> 
<blockquote> 
 <p>这里默认你的 <code>8080</code> 端口 没有占用，如果占用的话，按照终端里显示的端口再配置一下开发者后台的端口。</p> 
</blockquote> 
<ol start="5"><li>项目演示<br> 浏览器打开 <code>http://localhost:8080</code><br> 会自动跳转 <code>Mixin 授权页</code>，然后 授权成功后，会显示用户的基本信息。</li></ol> 
<blockquote> 
 <p>如果是在 MixinMessenger 客户端内打开的话，会直接弹出授权提示。</p> 
</blockquote> 
<h4><a id="4__70"></a>4. 核心代码片段解析</h4> 
<h5><a id="41_srcAppvue_71"></a>4.1. <code>src/App.vue</code></h5> 
<pre><code class="prism language-js"><span class="token keyword">import</span> <span class="token punctuation">{<!-- --></span> client_id <span class="token punctuation">}</span> <span class="token keyword">from</span> <span class="token string">"../keystore.json"</span><span class="token punctuation">;</span>
<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{<!-- --></span>
  methods<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
    <span class="token function">to_auth</span><span class="token punctuation">(</span>url<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
      window<span class="token punctuation">.</span>localStorage<span class="token punctuation">.</span><span class="token function">clear</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      url <span class="token operator">=</span> url <span class="token operator">||</span> <span class="token string">"/"</span><span class="token punctuation">;</span>
      window<span class="token punctuation">.</span>location<span class="token punctuation">.</span>href <span class="token operator">=</span> <span class="token template-string"><span class="token string">`https://mixin.one/oauth/authorize?client_id=</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>client_id<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">&amp;scope=SNAPSHOTS:READ+PROFILE:READ+PHONE:READ+ASSETS:READ+CONTACTS:READ&amp;response_type=code&amp;return_to=</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>url<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">`</span></span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token function">mounted</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    window<span class="token punctuation">.</span>_vm <span class="token operator">=</span> <span class="token keyword">this</span><span class="token punctuation">;</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span>window<span class="token punctuation">.</span>location<span class="token punctuation">.</span>pathname <span class="token operator">===</span> <span class="token string">"/auth"</span><span class="token punctuation">)</span> <span class="token keyword">return</span><span class="token punctuation">;</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>window<span class="token punctuation">.</span>localStorage<span class="token punctuation">.</span><span class="token function">getItem</span><span class="token punctuation">(</span><span class="token string">"token"</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token function">to_auth</span><span class="token punctuation">(</span>url<span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">;</span>
</code></pre> 
<ol><li><code>_vm</code>：初始化的时候，将根实例挂在到<code>window</code>对象上，方便全局访问。<br> 实际项目中可以用 <code>eventBus</code> 其他方案来取代。</li><li><code>token</code>：这里很关键的一步，就是在初始化的时候，判断一下 <code>localStorage</code> 中是否有 <code>token</code> ，没有 <code>token</code> 的话就要跳转到登录页去获取 token。</li><li><code>to_auth</code>：<br> 参数：<code>url</code> 表示通过授权之后返回的 <code>pathname</code> 。<br> 功能：去到授权页面，并指定授权之后返回的 url。<br> 例1：本例中并没有使用参数 <code>url</code> ，所以默认授权成功后，会跳转 <a href="https://developers.mixin.one/dashboard">https://developers.mixin.one/dashboard</a> 中配置的 <code>验证网址</code>，并携带这里传入的 url 和 code，也就是形如<br> <code>http://192.168.0.106:8080/auth?code=xxxxxxxxxxxx&amp;return_to=/</code><br> 例2：假如传入 url=’/about’，授权成功之后，就会跳转<br> <code>http://192.168.0.106:8080/auth?code=xxxxxxxxxxxx&amp;return_to=/abount</code></li></ol> 
<h5><a id="42_srccomponentsAuthvue_99"></a>4.2. <code>src/components/Auth.vue</code></h5> 
<pre><code class="prism language-js"><span class="token keyword">import</span> <span class="token punctuation">{<!-- --></span> authenticate <span class="token punctuation">}</span> <span class="token keyword">from</span> <span class="token string">"../api"</span><span class="token punctuation">;</span>

<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{<!-- --></span>
  <span class="token keyword">async</span> <span class="token function">mounted</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token keyword">let</span> <span class="token punctuation">{<!-- --></span> _vm <span class="token punctuation">}</span> <span class="token operator">=</span> window<span class="token punctuation">;</span>
    <span class="token keyword">let</span> error <span class="token operator">=</span> <span class="token function">getUrlParameter</span><span class="token punctuation">(</span><span class="token string">"error"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">let</span> authorizationCode <span class="token operator">=</span> <span class="token function">getUrlParameter</span><span class="token punctuation">(</span><span class="token string">"code"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">let</span> returnTo <span class="token operator">=</span> <span class="token function">getUrlParameter</span><span class="token punctuation">(</span><span class="token string">"return_to"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>authorizationCode <span class="token operator">||</span> error <span class="token operator">===</span> <span class="token string">"access_denied"</span><span class="token punctuation">)</span> <span class="token keyword">return</span> _vm<span class="token punctuation">.</span><span class="token function">to_auth</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    returnTo <span class="token operator">=</span> <span class="token operator">!</span>returnTo <span class="token operator">?</span> <span class="token string">"/"</span> <span class="token punctuation">:</span> returnTo<span class="token punctuation">;</span>
    <span class="token keyword">let</span> <span class="token punctuation">{<!-- --></span> data <span class="token punctuation">}</span> <span class="token operator">=</span> <span class="token keyword">await</span> <span class="token function">authenticate</span><span class="token punctuation">(</span>authorizationCode<span class="token punctuation">)</span><span class="token punctuation">;</span>
    window<span class="token punctuation">.</span>localStorage<span class="token punctuation">.</span><span class="token function">setItem</span><span class="token punctuation">(</span><span class="token string">"token"</span><span class="token punctuation">,</span> data<span class="token punctuation">.</span>access_token<span class="token punctuation">)</span><span class="token punctuation">;</span>
    window<span class="token punctuation">.</span>localStorage<span class="token punctuation">.</span><span class="token function">setItem</span><span class="token punctuation">(</span><span class="token string">"scope"</span><span class="token punctuation">,</span> data<span class="token punctuation">.</span>scope<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">this</span><span class="token punctuation">.</span>$router<span class="token punctuation">.</span><span class="token function">push</span><span class="token punctuation">(</span>returnTo<span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">;</span>

<span class="token keyword">function</span> <span class="token function">getUrlParameter</span><span class="token punctuation">(</span>name<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  name <span class="token operator">=</span> name<span class="token punctuation">.</span><span class="token function">replace</span><span class="token punctuation">(</span><span class="token regex">/[\[]/</span><span class="token punctuation">,</span> <span class="token string">"\\["</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">replace</span><span class="token punctuation">(</span><span class="token regex">/[\]]/</span><span class="token punctuation">,</span> <span class="token string">"\\]"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token keyword">var</span> regex <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">RegExp</span><span class="token punctuation">(</span><span class="token string">"[\\?&amp;]"</span> <span class="token operator">+</span> name <span class="token operator">+</span> <span class="token string">"=([^&amp;#]*)"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token keyword">var</span> results <span class="token operator">=</span> regex<span class="token punctuation">.</span><span class="token function">exec</span><span class="token punctuation">(</span>window<span class="token punctuation">.</span>location<span class="token punctuation">.</span>search<span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token keyword">return</span> results <span class="token operator">===</span> <span class="token keyword">null</span>
    <span class="token operator">?</span> <span class="token string">""</span>
    <span class="token punctuation">:</span> <span class="token function">decodeURIComponent</span><span class="token punctuation">(</span>results<span class="token punctuation">[</span><span class="token number">1</span><span class="token punctuation">]</span><span class="token punctuation">.</span><span class="token function">replace</span><span class="token punctuation">(</span><span class="token regex">/\+/g</span><span class="token punctuation">,</span> <span class="token string">" "</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre> 
<ol><li><code>getUrlParameter</code>: 获取 url 的参数。<br> 核心是获取到 <code>code</code><br> 根据 <code>code</code> 然后再通过调用 authenticate<br> (实际上就是请求 <code>POST</code> <code>https://api.mixin.one/oauth/token</code>)</li><li><code>_vm</code>： 其实就是在 <code>App.vue</code> 的实例。</li><li><code>access_token</code>： 这一步比较重要，就是要留住 access_token。以后所有需要请求<code>api.mixin.one</code>的操作，都需要这个 <code>access_token</code>，可以直接理解为身份凭证。<br> Demo中的代码比较简单，正常项目中，肯定是要把<code>POST</code> <code>https://api.mixin.one/oauth/token</code>这一步放到后端的，避免 <code>client_secret</code> 暴露了。</li><li><code>return_to</code> ：在这里就可以拿到 <code>4.1</code> 所述的 <code>url</code> 并进行一些操作了。</li></ol> 
<h5><a id="43_srcapijs_136"></a>4.3 <code>src/api.js</code></h5> 
<pre><code class="prism language-js">ajax<span class="token punctuation">.</span>interceptors<span class="token punctuation">.</span>request<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span>config <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
  <span class="token keyword">let</span> <span class="token punctuation">{<!-- --></span> _vm <span class="token punctuation">}</span> <span class="token operator">=</span> window
  <span class="token keyword">let</span> token <span class="token operator">=</span> window<span class="token punctuation">.</span>localStorage<span class="token punctuation">.</span><span class="token function">getItem</span><span class="token punctuation">(</span><span class="token string">"token"</span><span class="token punctuation">)</span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>token<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token function">setTimeout</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
      _vm<span class="token punctuation">.</span><span class="token function">to_auth</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token number">100</span><span class="token punctuation">)</span>
  <span class="token punctuation">}</span>
  config<span class="token punctuation">.</span>headers<span class="token punctuation">.</span>Authorization <span class="token operator">=</span> <span class="token string">"Bearer "</span> <span class="token operator">+</span> token
  <span class="token keyword">return</span> config
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<ol><li><code>interceptors</code>：这个请求拦截器主要是为了判断是否有 <code>token</code>，并把 token 包装在 <code>headers</code> <code>{Authorization: "Bearer " + token}</code>，然后再发起请求。<br> 实际情况下，这里的 <code>token</code> 一般使用后端生成后的 token，而实际的 access_token 保存在后端，方便请求。</li></ol> 
<h5><a id="43_srccomponentsHomevue_152"></a>4.3 <code>src/components/Home.vue</code></h5> 
<pre><code class="prism language-js"><span class="token operator">&lt;</span>template<span class="token operator">&gt;</span>
  <span class="token operator">&lt;</span>div<span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span>div <span class="token keyword">class</span><span class="token operator">=</span><span class="token string">"uinfo"</span><span class="token operator">&gt;</span>
      个人信息
      <span class="token operator">&lt;</span>ul<span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span>img <span class="token punctuation">:</span>src<span class="token operator">=</span><span class="token string">"uinfo.avatar_url"</span> <span class="token operator">/</span><span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span>li<span class="token operator">&gt;</span>User <span class="token constant">ID</span>：<span class="token operator">&lt;</span>br <span class="token operator">/</span><span class="token operator">&gt;</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">{<!-- --></span>uinfo<span class="token punctuation">.</span>user_id<span class="token punctuation">}</span><span class="token punctuation">}</span><span class="token operator">&lt;</span><span class="token operator">/</span>li<span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span>li<span class="token operator">&gt;</span>昵称：<span class="token punctuation">{<!-- --></span><span class="token punctuation">{<!-- --></span>uinfo<span class="token punctuation">.</span>full_name<span class="token punctuation">}</span><span class="token punctuation">}</span><span class="token operator">&lt;</span><span class="token operator">/</span>li<span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span>li<span class="token operator">&gt;</span>Identity Number：<span class="token punctuation">{<!-- --></span><span class="token punctuation">{<!-- --></span>uinfo<span class="token punctuation">.</span>identity_number<span class="token punctuation">}</span><span class="token punctuation">}</span><span class="token operator">&lt;</span><span class="token operator">/</span>li<span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span>li<span class="token operator">&gt;</span>Phone：<span class="token punctuation">{<!-- --></span><span class="token punctuation">{<!-- --></span>uinfo<span class="token punctuation">.</span>phone<span class="token punctuation">}</span><span class="token punctuation">}</span><span class="token operator">&lt;</span><span class="token operator">/</span>li<span class="token operator">&gt;</span>
        <span class="token operator">&lt;</span>li<span class="token operator">&gt;</span>个人签名：<span class="token punctuation">{<!-- --></span><span class="token punctuation">{<!-- --></span>uinfo<span class="token punctuation">.</span>biography<span class="token punctuation">}</span><span class="token punctuation">}</span><span class="token operator">&lt;</span><span class="token operator">/</span>li<span class="token operator">&gt;</span>
      <span class="token operator">&lt;</span><span class="token operator">/</span>ul<span class="token operator">&gt;</span>
    <span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
  <span class="token operator">&lt;</span><span class="token operator">/</span>div<span class="token operator">&gt;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>template<span class="token operator">&gt;</span>

<span class="token operator">&lt;</span>script<span class="token operator">&gt;</span>
<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token punctuation">{<!-- --></span>
  name<span class="token punctuation">:</span> <span class="token string">"Home"</span><span class="token punctuation">,</span>
  <span class="token function">data</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token keyword">return</span> <span class="token punctuation">{<!-- --></span>
      uinfo<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token keyword">async</span> <span class="token function">mounted</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token keyword">this</span><span class="token punctuation">.</span>uinfo <span class="token operator">=</span> <span class="token keyword">await</span> <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token constant">APIS</span><span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">"/me"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">;</span>
<span class="token operator">&lt;</span><span class="token operator">/</span>script<span class="token operator">&gt;</span>
</code></pre> 
<p>好了，终于进入到业务的页面了。如果这个页面能够加载成功，那么就可以恭喜你登录成功了。<br> 这个时候，页面上应该已经显示了你的基本信息了。</p> 
<blockquote> 
 <p>最后：再把git地址列出来。详细代码参见：<br> <a href="https://github.com/liuzemei/vue-mixin-demo">https://github.com/liuzemei/vue-mixin-demo</a></p> 
</blockquote> 
<p>如有问题，也欢迎在Mixin Messenger上直接联系我。</p> 
<p><img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy82OTYwNzc1LTNlNTVlZTZjZjRjMTFhYjYucG5n?x-oss-process=image/format,png" alt="在 Mixin 中扫码添加"></p>
                
{% endraw %}
