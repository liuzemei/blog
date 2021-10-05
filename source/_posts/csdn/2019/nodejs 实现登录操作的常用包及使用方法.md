---
title: nodejs 实现登录操作的常用包及使用方法
date: 2019-02-07 16:35:58
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/86772094)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h1><a id="Mongoose_1"></a>Mongoose</h1> 
<h3><a id="1_3"></a>1.安装包</h3> 
<p><code>Npm install mongoose</code></p> 
<h3><a id="2_appjs_9"></a>2. 在app.js入口文件中导入包</h3> 
<pre><code class="prism language-js"><span class="token keyword">const</span> mongoose <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">"mongoose"</span><span class="token punctuation">)</span>

</code></pre> 
<h3><a id="3appjs_16"></a>3.连接数据库（app.js）</h3> 
<pre><code class="prism language-js"><span class="token comment">//连接数据库，数据库名为：db_name</span>
mongoose<span class="token punctuation">.</span><span class="token function">connect</span><span class="token punctuation">(</span><span class="token string">"mongodb://localhost/db_name"</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    	console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">"MongoDB connected..."</span><span class="token punctuation">)</span><span class="token comment">//连接成功返回</span>
	<span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token keyword">catch</span><span class="token punctuation">(</span>err <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    	console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span><span class="token comment">//连接失败返回</span>
	<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h3><a id="4SchemacollectionNamejs_29"></a>4.创建Schema数据模型文件(collectionName.js)</h3> 
<pre><code class="prism language-js"><span class="token comment">//在app.js路径下，再创建一个新的文件，coolectionName.js</span>
<span class="token comment">//collectionName一般就直接是集合的名字了</span>
<span class="token keyword">const</span> mongoose <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'mongoose'</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">//导入mongoose文件</span>
<span class="token keyword">const</span> Schema <span class="token operator">=</span> mongoose<span class="token punctuation">.</span>Schema<span class="token punctuation">;</span> <span class="token comment">//定义一个Schema对象</span>
<span class="token keyword">const</span> collectionNameSchema <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">Schema</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token comment">//new一个Schema对象</span>
    key1<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span><span class="token comment">//键名</span>
        type<span class="token punctuation">:</span> String<span class="token punctuation">,</span> <span class="token comment">// 值类型</span>
        required<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">// 是否必须(如果为true，则必须传，否则不能添加)</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    key2<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
        type<span class="token punctuation">:</span> String<span class="token punctuation">,</span>
        required<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    key3<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
        type<span class="token punctuation">:</span> Date<span class="token punctuation">,</span>
        <span class="token keyword">default</span><span class="token punctuation">:</span> Date<span class="token punctuation">.</span>now<span class="token punctuation">,</span> <span class="token comment">//缺省值</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>

<span class="token comment">//将collectionNameSchema 挂载到 mongoose.model，用'collectionName'别名</span>
mongoose<span class="token punctuation">.</span><span class="token function">model</span><span class="token punctuation">(</span><span class="token string">'collectionName'</span><span class="token punctuation">,</span>collectionNameSchema<span class="token punctuation">)</span>

</code></pre> 
<h3><a id="5appjscollectionNamejs_56"></a>5.在app.js中导入collectionName.js</h3> 
<pre><code class="prism language-js"><span class="token comment">//引入模型</span>
<span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'./collectionName.js'</span><span class="token punctuation">)</span>

<span class="token comment">//实例化 model </span>
<span class="token keyword">const</span> CollectionName <span class="token operator">=</span> mongoose<span class="token punctuation">.</span><span class="token function">model</span><span class="token punctuation">(</span><span class="token string">'collectionName'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<h3><a id="6_66"></a>6.增删改查</h3> 
<pre><code class="prism language-js"><span class="token comment">// 增：</span>
<span class="token comment">// 先准备一个要插入的对象</span>
<span class="token comment">// 注意：前面还有一些代码，大概就是一个post请求。</span>
<span class="token keyword">const</span> newUser <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    title<span class="token punctuation">:</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>title<span class="token punctuation">,</span>
    details<span class="token punctuation">:</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>details
<span class="token punctuation">}</span>

<span class="token keyword">new</span> <span class="token class-name">CollectionName</span><span class="token punctuation">(</span>newUser<span class="token punctuation">)</span>
	<span class="token punctuation">.</span><span class="token function">save</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>idea <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    	res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/collection'</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">//这里重定向到新路由</span>
	<span class="token punctuation">}</span><span class="token punctuation">)</span>

<span class="token comment">// 查：</span>
<span class="token comment">// find =&gt; 获取所有的</span>
CollectionName<span class="token punctuation">.</span><span class="token function">find</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">)</span> <span class="token comment">//实例化的model .find()里面传一个空对象</span>
    <span class="token punctuation">.</span><span class="token function">sort</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>date<span class="token punctuation">:</span><span class="token string">"desc"</span><span class="token punctuation">}</span><span class="token punctuation">)</span> <span class="token comment">//按照时间降序排列</span>
    <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>items <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>    <span class="token comment">// 这个items就是所有的查询结果,是一个对象数组</span>
    	res<span class="token punctuation">.</span><span class="token function">render</span><span class="token punctuation">(</span><span class="token string">"items/index"</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span> <span class="token comment">//将拿到的数组结果传递给index</span>
            items<span class="token punctuation">:</span>items   <span class="token comment">//这个是指定要传过去的参数(选择的模版引擎是												handlebars)</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">// findOne ==&gt; 获取一个</span>
CollectionName<span class="token punctuation">.</span><span class="token function">findOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>_id<span class="token punctuation">:</span> req<span class="token punctuation">.</span>params<span class="token punctuation">.</span>id<span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>item <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    res<span class="token punctuation">.</span><span class="token function">render</span><span class="token punctuation">(</span><span class="token string">'items/edit'</span><span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span>item<span class="token punctuation">:</span> item<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>

<span class="token comment">// 改:</span>
<span class="token comment">// 先找到要更改的数据</span>
<span class="token comment">// findOne</span>
CollectionName<span class="token punctuation">.</span><span class="token function">findOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>_id<span class="token punctuation">:</span> req<span class="token punctuation">.</span>params<span class="token punctuation">.</span>id<span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span>item <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>  <span class="token comment">//返回的就是那个数据</span>
    item<span class="token punctuation">.</span>title <span class="token operator">=</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>title  <span class="token comment">//直接.属性重新复制就可以修改</span>
    item<span class="token punctuation">.</span>details <span class="token operator">=</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>details <span class="token comment">//要加上urlencodeParser才能解析</span>
    item<span class="token punctuation">.</span><span class="token function">save</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token comment">// 把这个数据返回到数据库(保存)</span>
      <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">//成功就执行这个函数</span>
        res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/items'</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>

<span class="token comment">// 删：</span>
CollectionName<span class="token punctuation">.</span><span class="token function">remove</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>_id<span class="token punctuation">:</span> req<span class="token punctuation">.</span>params<span class="token punctuation">.</span>id<span class="token punctuation">}</span><span class="token punctuation">)</span>
  <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/items/index'</span><span class="token punctuation">)</span>  
  <span class="token punctuation">}</span><span class="token punctuation">)</span>

</code></pre> 
<h1><a id="methodoverride_121"></a>method-override</h1> 
<p>功能：为提交方法，加入pute操作（更新）、delete操作（删除）</p> 
<h3><a id="1_129"></a>1.安装包</h3> 
<p><code>cnpm install method-override --save</code></p> 
<h3><a id="2appjsapp_135"></a>2.导入app.js并注册到app</h3> 
<pre><code class="prism language-js"><span class="token keyword">const</span> methodOverride <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'method-override'</span><span class="token punctuation">)</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token function">methodOverride</span><span class="token punctuation">(</span><span class="token string">'_method'</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
</code></pre> 
<h3><a id="3_142"></a>3.修改要请求的表单域</h3> 
<pre><code class="prism language-html"><span class="token comment">&lt;!--原来的表单域--&gt;</span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>form</span> <span class="token attr-name">action</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>/ideas<span class="token punctuation">"</span></span> <span class="token attr-name">method</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>post<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>form</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>修改为===&gt;</p> 
<pre><code class="prism language-html"><span class="token comment">&lt;!-- PUT --&gt;</span>
<span class="token comment">&lt;!--现在的表单域 --&gt;</span>
<span class="token comment">&lt;!-- 加入要修改的id(从后台传过来的) 其他是固定格式   --&gt;</span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>form</span> <span class="token attr-name">action</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>/ideas/{<!-- -->{item.id}}?_method=PUT<span class="token punctuation">"</span></span> <span class="token attr-name">method</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>post<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>hidden<span class="token punctuation">"</span></span> <span class="token attr-name">name</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>_method<span class="token punctuation">"</span></span> <span class="token attr-name">value</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>PUT<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>button</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>submit<span class="token punctuation">"</span></span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>btn btn-primary<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>提交<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>button</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>form</span><span class="token punctuation">&gt;</span></span>

<span class="token comment">&lt;!-- DELETE --&gt;</span>
<span class="token comment">&lt;!--现在的表单域 --&gt;</span>
<span class="token comment">&lt;!-- 加入要修改的id(从后台传过来的) 其他是固定格式   --&gt;</span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>form</span> <span class="token attr-name">action</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>/ideas/{<!-- -->{item.id}}?_method=DELETE<span class="token punctuation">"</span></span> <span class="token attr-name">method</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>post<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>hidden<span class="token punctuation">"</span></span> <span class="token attr-name">name</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>_method<span class="token punctuation">"</span></span> <span class="token attr-name">value</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>DELETE<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>submit<span class="token punctuation">"</span></span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>btn btn-danger btn-block<span class="token punctuation">"</span></span> <span class="token attr-name">value</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>删除<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>form</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<h3><a id="4PUTDELETE_172"></a>4.监听PUT、DELETE路由</h3> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token function">put</span><span class="token punctuation">(</span><span class="token string">'/item/:id'</span><span class="token punctuation">,</span> urlencodeParser<span class="token punctuation">,</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
app<span class="token punctuation">.</span><span class="token keyword">delete</span><span class="token punctuation">(</span><span class="token string">'/item/:id'</span><span class="token punctuation">,</span> urlencodeParser<span class="token punctuation">,</span> <span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h1><a id="expresssession_183"></a>express-session</h1> 
<p>功能：</p> 
<h3><a id="1_189"></a>1.安装包</h3> 
<p><code>cnpm i express-session</code></p> 
<h3><a id="2_appjs__195"></a>2.在 app.js 文件中导入包</h3> 
<pre><code class="prism language-js"><span class="token keyword">const</span> session <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'express-session'</span><span class="token punctuation">)</span>

app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token function">session</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
    secret<span class="token punctuation">:</span> <span class="token string">'secret'</span><span class="token punctuation">,</span>  <span class="token comment">// 对 session id 相关的cookie 进行签名</span>
    resave<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
    saveUninitialized<span class="token punctuation">:</span> <span class="token boolean">true</span>  <span class="token comment">// 是否保存未初始化的会话</span>
    cookie<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
    	maxAge<span class="token punctuation">:</span> <span class="token number">1000</span> <span class="token operator">*</span> <span class="token number">60</span> <span class="token operator">*</span> <span class="token number">3</span> <span class="token comment">//设置 session 的有效时间，单位毫秒</span>
	<span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">)</span>

<span class="token comment">// 获取登录页面</span>
app<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    res<span class="token punctuation">.</span><span class="token function">sendFile</span><span class="token punctuation">(</span>__dirname <span class="token operator">+</span> <span class="token string">'/login.html'</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 用户登录</span>
app<span class="token punctuation">.</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    <span class="token keyword">if</span><span class="token punctuation">(</span>req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>username <span class="token operator">==</span> <span class="token string">'admin'</span> <span class="token operator">&amp;&amp;</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>pwd <span class="token operator">==</span> <span class="token string">'admin123'</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
        req<span class="token punctuation">.</span>session<span class="token punctuation">.</span>userName <span class="token operator">=</span> req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>username<span class="token punctuation">;</span> <span class="token comment">// 登录成功，设置 session</span>
        res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token keyword">else</span><span class="token punctuation">{<!-- --></span>
        res<span class="token punctuation">.</span><span class="token function">json</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>ret_code <span class="token punctuation">:</span> <span class="token number">1</span><span class="token punctuation">,</span> ret_msg <span class="token punctuation">:</span> <span class="token string">'账号或密码错误'</span><span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span><span class="token comment">// 若登录失败，重定向到登录页面</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 获取主页</span>
app<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span>req<span class="token punctuation">.</span>session<span class="token punctuation">.</span>userName<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>  <span class="token comment">//判断session 状态，如果有效，则返回主页，否则转到登录页面</span>
        res<span class="token punctuation">.</span><span class="token function">render</span><span class="token punctuation">(</span><span class="token string">'home'</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>username <span class="token punctuation">:</span> req<span class="token punctuation">.</span>session<span class="token punctuation">.</span>userName<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
        res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'login'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>

<span class="token comment">// 退出</span>
app<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/logout'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    req<span class="token punctuation">.</span>session<span class="token punctuation">.</span>userName <span class="token operator">=</span> <span class="token keyword">null</span><span class="token punctuation">;</span> <span class="token comment">// 删除session</span>
    res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'login'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

app<span class="token punctuation">.</span><span class="token function">listen</span><span class="token punctuation">(</span><span class="token number">8000</span><span class="token punctuation">,</span><span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'http://127.0.0.1:8000'</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h1><a id="connectflash_247"></a>connect-flash</h1> 
<p>功能：设置一些改动提醒。</p> 
<h3><a id="1_251"></a>1.安装包</h3> 
<p><code>cnpm i connect-flash</code></p> 
<h3><a id="2app_255"></a>2.导入包，注册到app上</h3> 
<pre><code class="prism language-js"><span class="token keyword">const</span> flash <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'connect-flash'</span><span class="token punctuation">)</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token function">flash</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span>  <span class="token comment">//注意，这里注册的是个flash函数</span>
</code></pre> 
<h3><a id="3_264"></a>3.配置渲染的路由</h3> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">,</span> next<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    res<span class="token punctuation">.</span>locals<span class="token punctuation">.</span>success_msg <span class="token operator">=</span> req<span class="token punctuation">.</span><span class="token function">flash</span><span class="token punctuation">(</span><span class="token string">'success_msg'</span><span class="token punctuation">)</span>
    res<span class="token punctuation">.</span>locals<span class="token punctuation">.</span>error_msg <span class="token operator">=</span> req<span class="token punctuation">.</span><span class="token function">flash</span><span class="token punctuation">(</span><span class="token string">'error_msg'</span><span class="token punctuation">)</span>
    <span class="token function">next</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h3><a id="4_276"></a>4.在组件中使用</h3> 
<pre><code class="prism language-js">req<span class="token punctuation">.</span><span class="token function">flash</span><span class="token punctuation">(</span><span class="token string">'success_msg'</span><span class="token punctuation">,</span> <span class="token string">'成功了...'</span><span class="token punctuation">)</span>
res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/user/register'</span><span class="token punctuation">)</span> <span class="token comment">//一般req.flash后边接页面重定向</span>
</code></pre> 
<h1><a id="bcrypt_285"></a>bcrypt</h1> 
<p>功能：加密密码或者一些文件</p> 
<h3><a id="1__291"></a>1. 安装包</h3> 
<p><code>cnpm i bcrypt node-gyp --save</code></p> 
<p>（依赖于 node-gyp）所以都得安装</p> 
<h3><a id="2__299"></a>2. 引入包</h3> 
<pre><code class="prism language-js"><span class="token keyword">const</span> bcrypt <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'bcrypt'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token keyword">const</span> saltRounds <span class="token operator">=</span> <span class="token number">10</span><span class="token punctuation">;</span> <span class="token comment">//要哈希的长度</span>
<span class="token keyword">const</span> myPlaintextPassword <span class="token operator">=</span> <span class="token string">'s0/\/\P4$$w0rD'</span><span class="token comment">//要哈希的密码(明文密码)</span>
</code></pre> 
<h3><a id="3__310"></a>3. 直接哈希明文密码</h3> 
<pre><code class="prism language-js">bcrypt<span class="token punctuation">.</span><span class="token function">hash</span><span class="token punctuation">(</span>user<span class="token punctuation">.</span>password<span class="token punctuation">,</span> saltRounds<span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>err<span class="token punctuation">,</span> hash<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  user<span class="token punctuation">.</span>password <span class="token operator">=</span> hash <span class="token comment">//把加密后的密文赋值给原来的密码</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<h3><a id="4_320"></a>4.比较用户输入的密码跟哈希密码</h3> 
<pre><code class="prism language-js">bcrypt<span class="token punctuation">.</span><span class="token function">compare</span><span class="token punctuation">(</span>req<span class="token punctuation">.</span>body<span class="token punctuation">.</span>password<span class="token punctuation">,</span> user<span class="token punctuation">.</span>password<span class="token punctuation">,</span><span class="token punctuation">(</span>err<span class="token punctuation">,</span> isMatch<span class="token punctuation">)</span><span class="token operator">=&gt;</span><span class="token punctuation">{<!-- --></span>
    <span class="token keyword">if</span> <span class="token punctuation">(</span>isMatch<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
        <span class="token comment">//匹配成功</span>
    <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
        <span class="token comment">//匹配失败</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h1><a id="passport__passportlocal_334"></a>passport / passport-local</h1> 
<h3><a id="1_336"></a>1.安装包</h3> 
<p><code>cnpm i passport passport-local --save</code></p> 
<h3><a id="2__342"></a>2. 导入包</h3> 
<pre><code class="prism language-js"><span class="token keyword">const</span> passport <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'passport'</span><span class="token punctuation">)</span>
<span class="token keyword">const</span> LocalStrategy <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'passport-local'</span><span class="token punctuation">)</span><span class="token punctuation">.</span>Strategy
</code></pre> 
<h3><a id="3__351"></a>3. 配置策略</h3> 
<pre><code class="prism language-js">passport<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">LocalStrategy</span><span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span>usernameField<span class="token punctuation">:</span> <span class="token string">'email'</span><span class="token punctuation">,</span>
     passwordField<span class="token punctuation">:</span> <span class="token string">'passwd'</span><span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token punctuation">(</span>email<span class="token punctuation">,</span> passwd<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
        <span class="token comment">//获取到了用户输入的 email 和 passwd</span>
        <span class="token comment">//一般这个时候要与数据库进行比对</span>
        User<span class="token punctuation">.</span><span class="token function">findOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>email<span class="token punctuation">:</span> email<span class="token punctuation">}</span><span class="token punctuation">)</span>
            <span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span><span class="token punctuation">(</span>user<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
            <span class="token comment">//这里的message绑定的全局配置是flash变量中的：</span>
            <span class="token comment">//res.locals.error = req.flash('error')</span>
            <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>user<span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span><span class="token boolean">false</span><span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span>message<span class="token punctuation">:</span><span class="token string">'没有这个用户！'</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
            bcrypt<span class="token punctuation">.</span><span class="token function">compare</span><span class="token punctuation">(</span>passwd<span class="token punctuation">,</span> user<span class="token punctuation">.</span>passwd<span class="token punctuation">,</span> <span class="token punctuation">(</span>err<span class="token punctuation">,</span> isMatch<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
                <span class="token keyword">if</span> <span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token keyword">throw</span> err<span class="token punctuation">;</span>
                <span class="token comment">//成功之后，会在req里注册一个user，保存的就是User.findOne的信息</span>
                <span class="token keyword">if</span> <span class="token punctuation">(</span>isMatch<span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> user<span class="token punctuation">)</span>
                <span class="token keyword">else</span> <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span><span class="token boolean">false</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>message<span class="token punctuation">:</span><span class="token string">'密码错误！'</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">}</span>
    <span class="token comment">//在典型的网络应用中，登录请求中包含验证用户的认证信息。如果认证成功，用户浏览器中通过 cookie 创建并保存 sessionID。随后所有的请求不再需要验证，而是通过 sessionID 来识别用户。Passport 可以将 session 中的用户信息序列化或反序列化，以此支持 session 机制。</span>
    <span class="token comment">// 序列化 user   --默认格式</span>
    passport<span class="token punctuation">.</span><span class="token function">serializeUser</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span>user<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> user<span class="token punctuation">.</span>id<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token comment">// 反序列化 user  --默认格式</span>
    passport<span class="token punctuation">.</span><span class="token function">deserializeUser</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span>id<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        User<span class="token punctuation">.</span><span class="token function">findById</span><span class="token punctuation">(</span>id<span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>err<span class="token punctuation">,</span> user<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            <span class="token function">done</span><span class="token punctuation">(</span>err<span class="token punctuation">,</span> user<span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">)</span><span class="token punctuation">)</span>
</code></pre> 
<h3><a id="4_389"></a>4.添加两个中间件</h3> 
<pre><code class="prism language-js"><span class="token comment">//在 Express 应用中， passport.initialize() 中间件可初始化 Passport， passport.session() 中间件用来存储用户登录的 session 信息。</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span>passport<span class="token punctuation">.</span><span class="token function">initialize</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span>passport<span class="token punctuation">.</span><span class="token function">session</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span><span class="token comment">//要放在 express-session 初始化的后面</span>
</code></pre> 
<h3><a id="4_authenticatelogin_399"></a>4.认证 authenticate(login)</h3> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token string">'login'</span><span class="token punctuation">,</span> urlencodeParser<span class="token punctuation">,</span> <span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">,</span> next<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">//passport.authenticate() 中间件会自动触发 req.login() 。 </span>
    <span class="token comment">//req.login(user, function(err) {<!-- --></span>
  	<span class="token comment">//	if (err) { return next(err); }</span>
  	<span class="token comment">//	return res.redirect('/users/' + req.user.username);</span>
	<span class="token comment">//});</span>
    <span class="token comment">//上面这项功能主要使用在用户注册时，调用 req.login() 方法自动登录新注册的用户。</span>
    passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span>  <span class="token comment">//执行到这个local的时候，就会去获取配置策略的user</span>
        successRedirect<span class="token punctuation">:</span> <span class="token string">'/ideas'</span><span class="token punctuation">,</span>   <span class="token comment">// 获取成功返回这个重定向</span>
        failureRedirect<span class="token punctuation">:</span> <span class="token string">'/users/login'</span><span class="token punctuation">,</span>  <span class="token comment">//获取失败返回这个重定向</span>
        failureFlash<span class="token punctuation">:</span> <span class="token boolean">true</span>  <span class="token comment">// 是否接受配置失败的快报(需要配合 connect-flash 中间件)</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">,</span> next<span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h3><a id="5logout_419"></a>5.logout</h3> 
<pre><code class="prism language-js"><span class="token comment">//与 login() 相反，logout() 方法用来结束登录会话。 调用 logout() 方法会删除 req.user 属性并清除登录会话。</span>
app<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/logout'</span><span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
  req<span class="token punctuation">.</span><span class="token function">logout</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/user'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre>
                
{% endraw %}
