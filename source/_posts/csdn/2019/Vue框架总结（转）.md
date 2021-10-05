---
title: Vue框架总结（转）
date: 2019-01-24 09:15:50
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/86620392)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h1><a id="_0"></a>一.框架和库的区别</h1> 
<p>框架（framework）：有着自己的语法特点、都有对应的各个模块。</p> 
<p>库（library）：专注于一点。</p> 
<p>框架的好处：</p> 
<p>提到代码的质量，开发速度</p> 
<p>提高代码的复用率</p> 
<p>降低模块之间的耦合度（高内聚低耦合）</p> 
<p>UI：user interface</p> 
<p>GUI：graphical user interface</p> 
<p>CLI：command line interface</p> 
<p>API：application interface</p> 
<p>思维模式的转换：从操作DOM的思维模式 切换到以数据为主。</p> 
<h1><a id="Vue_23"></a>二.Vue概述</h1> 
<h3><a id="1what_24"></a>1、what</h3> 
<p>是一个渐进式的构建用户界面的js框架</p> 
<h3><a id="2where_27"></a>2、where</h3> 
<p>小到的简单的表单处理，大到复杂的数据操作比较频繁的单页面应用程序</p> 
<h3><a id="3why_30"></a>3、why</h3> 
<p>方便阅读的中文文档</p> 
<p>容易上手 （学习曲线比较缓和）</p> 
<p>体积小</p> 
<p>基于组件化的开发方式</p> 
<p>代码的可读性、可维护性得到了提高</p> 
<h3><a id="4how_41"></a>4、how</h3> 
<p>工作方式：可以通过丰富的指令扩展模板，可以通过各种各样的插件来增强功能</p> 
<p>搭建环境<br> 方式1</p> 
<p>全局安装 vue-cli</p> 
<p><code>npm install --global vue-cli</code></p> 
<p>创建一个基于 webpack 模板的新项目</p> 
<p><code>vue init webpack my-project</code></p> 
<p>安装依赖，走你</p> 
<p><code>cd my-project</code></p> 
<p><code>npm install</code></p> 
<p><code>npm run dev</code></p> 
<p>方式2</p> 
<p>直接引入对应的js文件</p> 
<pre><code class="prism language-js"><span class="token operator">&lt;</span>script src<span class="token operator">=</span><span class="token string">"js/vue.js"</span><span class="token operator">&gt;</span><span class="token operator">&lt;</span><span class="token operator">/</span>script<span class="token operator">&gt;</span>
</code></pre> 
<h1><a id="Vue_71"></a>三.Vue中基础知识</h1> 
<h3><a id="1_72"></a>1、双花括号</h3> 
<p>mustache(胡子)/interpolation（插值表达式）</p> 
<p>语法：</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span><span class="token punctuation">&gt;</span></span>{<!-- -->{表达式}}<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>作用：将表达式执行的结果 输出当调用元素的innerHTML中；还可以将数据绑定到视图。</p> 
<h3><a id="2_81"></a>2、指令-循环指令</h3> 
<p>基本语法1：</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span> <span class="token attr-name">v-for</span><span class="token attr-value"><span class="token punctuation">=</span>“tmp</span> <span class="token attr-name">in</span> <span class="token attr-name">array”</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>基本语法2：</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span> <span class="token attr-name">v-for</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>(value,index) in array<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>作用：在遍历array这个集合时，将临时变量保存在tmp中，创建多个any标签。</p> 
<h3><a id="3_92"></a>3、指令-选择指令</h3> 
<p>语法：</p> 
<pre><code class="prism language-html">    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span> <span class="token attr-name">v-if</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>表达式<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>

    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span> <span class="token attr-name">v-else-if</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>表达式<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>

    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span> <span class="token attr-name">v-else</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>表达式<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>作用：根据表达式执行结果的真假，来决定是否要将当前的这个元素 挂载到DOM树</p> 
<h3><a id="4_103"></a>4、指令-事件绑定</h3> 
<p>语法：</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span> <span class="token attr-name"><span class="token namespace">v-on:</span>eventName</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>handleEvent<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>作用：给指定的元素 将handleEvent的方法绑定给指定eventName事件。</p> 
<h3><a id="5_110"></a>5、指令-属性绑定</h3> 
<p>基本语法：</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span> <span class="token attr-name"><span class="token namespace">v-bind:</span>myProp</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>表达式<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>补充，支持简写：</p> 
<pre><code class="prism language-html"> <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span> <span class="token attr-name">:myProp</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>表达式<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>作用：将表达式执行的结果绑定到当前元素的myProp属性。</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>img</span> <span class="token attr-name"><span class="token namespace">v-bind:</span>src</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span><span class="token punctuation">'</span>img/<span class="token punctuation">'</span>+myImg<span class="token punctuation">"</span></span> <span class="token attr-name">alt</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span><span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>img</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>动态样式绑定：</p> 
<pre><code class="prism language-html"> <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>p</span> <span class="token attr-name">:</span><span class="token style-attr language-css"><span class="token attr-name"><span class="token attr-name">style</span></span><span class="token punctuation">="</span><span class="token attr-value"><span class="token punctuation">{<!-- --></span><span class="token property">backgroundColor</span><span class="token punctuation">:</span>myBGColor<span class="token punctuation">}</span></span><span class="token punctuation">"</span></span> <span class="token punctuation">&gt;</span></span>动态样式绑定<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>p</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>动态样式类绑定：</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>h1</span> <span class="token attr-name">:class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>{myRed:false}<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>动态样式类的绑定<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>h1</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<h3><a id="6_131"></a>6、指令-双向数据绑定</h3> 
<p>方向1：数据绑定到视图</p> 
<p>方向2：将视图中（表单元素）用户操作的结果绑定到数据</p> 
<p>基本语法：</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>表单元素</span> <span class="token attr-name">v-model</span><span class="token attr-value"><span class="token punctuation">=</span>“变量”</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>表单元素</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<h1><a id="_140"></a>四.组件化</h1> 
<p>组件：组件就是可被反复使用的，带有特定功能的视图。</p> 
<p>所谓的组件化，就像玩积木一样，把封装的组件进行复用,把积木（组件）拼接在一起，构成一个复杂的页面应用程序。</p> 
<p>组件树就是由各个组件构成的一种数据结构，它存在的意义是为了帮梳理应用程序。</p> 
<h3><a id="1_147"></a>1、组件的创建</h3> 
<p>全局组件：</p> 
<pre><code class="prism language-js">Vue<span class="token punctuation">.</span><span class="token function">component</span><span class="token punctuation">(</span><span class="token string">'my-com'</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>
   template<span class="token punctuation">:</span><span class="token template-string"><span class="token string">`
      &lt;h2 &gt;it is a header&lt;/h2&gt;
   `</span></span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<p>局部组件：</p> 
<pre><code class="prism language-js"><span class="token keyword">new</span> <span class="token class-name">Vue</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
  components<span class="token punctuation">:</span><span class="token punctuation">{<!-- --></span>
    ‘my<span class="token operator">-</span>footer’<span class="token punctuation">:</span><span class="token punctuation">{<!-- --></span>
            template<span class="token punctuation">:</span><span class="token template-string"><span class="token string">`
               &lt;h2 &gt;it is a footer&lt;/h2&gt;  
             `</span></span>
        <span class="token punctuation">}</span>
   <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h3><a id="2_168"></a>2、组件使用</h3> 
<p>作为普通的标签去使用</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>my-com</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>my-com</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<h3><a id="3_175"></a>3、注意事项</h3> 
<p>组件的id和使用方式 遵循烤串式命名方式：a-b-c</p> 
<p>如果一个组件 要渲染多个元素，将多个元素放在一个顶层标签中，比如div、form</p> 
<p>全局组件可以用在id为example的范围内的任何一个组件内部，直接调用可以；但是局部组件只能在父模板中直接调用</p> 
<h3><a id="4_182"></a>4.自定义指令</h3> 
<p>创建：</p> 
<pre><code class="prism language-js">Vue<span class="token punctuation">.</span><span class="token function">directive</span><span class="token punctuation">(</span><span class="token string">'change'</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>
   bind<span class="token punctuation">:</span><span class="token keyword">function</span><span class="token punctuation">(</span>el<span class="token punctuation">,</span>bindinds<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    <span class="token comment">//首次调用</span>
   <span class="token punctuation">}</span><span class="token punctuation">,</span>
   update<span class="token punctuation">:</span><span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
     <span class="token comment">//解绑</span>
     <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<p>使用：</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span> <span class="token attr-name">v-change</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">'</span>count<span class="token punctuation">'</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<h3><a id="5_198"></a>5.过滤器</h3> 
<p>过滤器是针对一些数据 进行筛选、过滤、格式化等相关的处理，变成我们想要的数据。</p> 
<p>过滤器的本质 就是一个带有参数带有返回值的方法。</p> 
<p>Vue1.* 支持内置的过滤器，但是Vue2.* 就不再内置过滤器，但是支持自定义过滤器。</p> 
<h5><a id="51_205"></a>5.1、过滤器的创建和使用</h5> 
<p><strong>1.创建</strong></p> 
<pre><code class="prism language-js">Vue<span class="token punctuation">.</span><span class="token function">filter</span><span class="token punctuation">(</span>
   <span class="token string">'myFilter'</span><span class="token punctuation">,</span><span class="token keyword">function</span><span class="token punctuation">(</span>myInput<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
      <span class="token comment">//myInput是在调用过滤器时，管道前表达式执行的结果</span>
      <span class="token comment">// 针对myInput,按照业务需求做处理</span>
      <span class="token comment">// 返回</span>
     <span class="token keyword">return</span> ‘处理后的结果’
   <span class="token punctuation">}</span>
<span class="token punctuation">)</span>
</code></pre> 
<p><strong>2.使用</strong></p> 
<pre><code class="prism language-html">       <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span><span class="token punctuation">&gt;</span></span>{<!-- -->{expression | myFilter}}<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p><em>如何在调用过滤器时，完成参数的发送和接受</em><br> <strong>发送</strong></p> 
<pre><code class="prism language-html">   <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span><span class="token punctuation">&gt;</span></span>{<!-- -->{expression | myFilter(参数1，参数2)}}<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p><strong>接受</strong></p> 
<pre><code class="prism language-js">   Vue<span class="token punctuation">.</span><span class="token function">filter</span><span class="token punctuation">(</span><span class="token string">'myFilter'</span><span class="token punctuation">,</span><span class="token keyword">function</span><span class="token punctuation">(</span>myInput，参数<span class="token number">1</span>，参数<span class="token number">2</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
       <span class="token keyword">return</span> <span class="token string">'处理后的结果'</span>
   <span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h3><a id="6_232"></a>6.复合组件</h3> 
<p>知识回顾：</p> 
<pre><code class="prism language-js">     Vue<span class="token punctuation">.</span><span class="token function">component</span><span class="token punctuation">(</span><span class="token string">'my-header'</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>
       template<span class="token punctuation">:</span><span class="token template-string"><span class="token string">`&lt;div&gt;&lt;/div&gt;`</span></span>
     <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<pre><code class="prism language-html">     <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>my-header</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>my-header</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<p>复合组件：并不是新的概念，就是一个组件，只不过这个组件中 可以调用其他的组件。</p> 
<p>注意事项：</p> 
<blockquote> 
 <p>1.组件要渲染的内容 取决于在定义组件时template效果是出不来的。</p> 
</blockquote> 
<pre><code class="prism language-html">     <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>my-list</span><span class="token punctuation">&gt;</span></span>
       <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>my-item</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>my-item</span><span class="token punctuation">&gt;</span></span>
     <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>my-list</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<blockquote> 
 <p>2.允许在一个组件中，直接来调用另外一个组件。</p> 
</blockquote> 
<h3><a id="7_256"></a>7.生命周期</h3> 
<p>四个阶段：</p> 
<blockquote> 
 <p>create 准备工作 （数据的初始化。。。）<br> mount 挂载前后针对元素进行操作<br> update 数据发生变化，<br> destroy 清理工作 (关闭定时器、集合清空…)</p> 
</blockquote> 
<blockquote> 
 <p>beforeCreate/created<br> beforeMount/mounted<br> beforeUpdate/updated<br> beforeDestroy/destroyed</p> 
</blockquote> 
<h3><a id="8_269"></a>8.常用属性</h3> 
<h5><a id="81watch_270"></a>8.1、watch</h5> 
<blockquote> 
 <p>1.表单元素的双向数据绑定</p> 
</blockquote> 
<pre><code class="prism language-js">   v<span class="token operator">-</span>model<span class="token operator">=</span><span class="token string">"myValue"</span>
</code></pre> 
<blockquote> 
 <p>2.监听</p> 
</blockquote> 
<pre><code class="prism language-js">watch<span class="token punctuation">:</span><span class="token punctuation">{<!-- --></span>
       myValue<span class="token punctuation">:</span><span class="token keyword">function</span><span class="token punctuation">(</span>newValue<span class="token punctuation">,</span>oldValue<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
       <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> 
<h5><a id="82computed_283"></a>8.2、computed</h5> 
<p>计算属于是用于在模板中，搞定复杂的业务逻辑，因为有依赖缓存。</p> 
<p>指定计算属性</p> 
<pre><code class="prism language-js">computed<span class="token punctuation">:</span><span class="token punctuation">{<!-- --></span>
    myHandle<span class="token punctuation">:</span><span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    <span class="token keyword">return</span> 数据
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>2.调用</p> 
<pre><code class="prism language-html">   <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>any</span><span class="token punctuation">&gt;</span></span>{<!-- -->{myHandle}}<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>any</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<h3><a id="9_298"></a>9.组件间通信</h3> 
<h5><a id="91_props_down_299"></a>9.1、父与子通信 （props down）</h5> 
<blockquote> 
 <p>1.发送</p> 
</blockquote> 
<pre><code class="prism language-html">   <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>son</span> <span class="token attr-name">myName</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">'</span>zhangsan<span class="token punctuation">'</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>son</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<blockquote> 
 <p>2.接受到son组件：</p> 
</blockquote> 
<pre><code class="prism language-js">Vue<span class="token punctuation">.</span><span class="token function">component</span><span class="token punctuation">(</span><span class="token string">'son'</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>
        props<span class="token punctuation">:</span><span class="token punctuation">[</span><span class="token string">'myName'</span><span class="token punctuation">]</span><span class="token punctuation">,</span>
        template<span class="token punctuation">:</span><span class="token template-string"><span class="token string">`
          &lt;p&gt;{<!-- -->{myName}}&lt;/p&gt;
       `</span></span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>    
</code></pre> 
<h5><a id="92_events_up_313"></a>9.2、子与父通信 (events up)</h5> 
<blockquote> 
 <p>1.绑定</p> 
</blockquote> 
<pre><code class="prism language-js">       methods<span class="token punctuation">:</span><span class="token punctuation">{<!-- --></span>

        handleEvent<span class="token punctuation">:</span><span class="token keyword">function</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span>

       <span class="token punctuation">}</span>
</code></pre> 
<pre><code class="prism language-html">       <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>son</span> <span class="token attr-name">@customEvent</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>handleEvent<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>son</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<blockquote> 
 <p>2.触发</p> 
</blockquote> 
<p>子组件内部：</p> 
<pre><code class="prism language-html">       this.$emit(‘customEvent’,100);
</code></pre> 
<h5><a id="93refreference___331"></a>9.3、ref(reference 引用/参考 外号)</h5> 
<p>帮助在父组件中 得到子组件中的数据、方法。</p> 
<blockquote> 
 <p>1.指定ref属性</p> 
</blockquote> 
<pre><code class="prism language-html">   <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>son</span> <span class="token attr-name">ref</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>mySon<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>son</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<blockquote> 
 <p>2.根据ref得到子组件实例</p> 
</blockquote> 
<pre><code class="prism language-js">   <span class="token keyword">this</span><span class="token punctuation">.</span>$refs<span class="token punctuation">.</span>mySon
</code></pre> 
<h5><a id="94parent_342"></a>9.4、$parent</h5> 
<p>this.$parent得到父组件的实例</p> 
<h5><a id="95_345"></a>9.5、兄弟组件通信</h5> 
<pre><code class="prism language-js"><span class="token keyword">var</span> bus <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">Vue</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token comment">//1.接收方</span>
bus<span class="token punctuation">.</span><span class="token function">$on</span><span class="token punctuation">(</span><span class="token string">'eventName'</span><span class="token punctuation">,</span><span class="token keyword">function</span><span class="token punctuation">(</span>msg<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//2.发送方</span>
bus<span class="token punctuation">.</span><span class="token function">$emit</span><span class="token punctuation">(</span><span class="token string">'eventName'</span><span class="token punctuation">,</span><span class="token number">123</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<h3><a id="9_353"></a>9.补充组件创建的方式</h3> 
<p>直接在template属性中指定模板内容</p> 
<h5><a id="91_355"></a>9.1.全局组件</h5> 
<pre><code class="prism language-html">   Vue.component
</code></pre> 
<h5><a id="92_359"></a>9.2.局部组件</h5> 
<pre><code class="prism language-js">       <span class="token punctuation">{<!-- --></span>
         components<span class="token punctuation">:</span><span class="token punctuation">{<!-- --></span>
           <span class="token string">'my-footer'</span>：<span class="token punctuation">{<!-- --></span>template<span class="token punctuation">:</span><span class="token template-string"><span class="token string">``</span></span><span class="token punctuation">}</span>
         <span class="token punctuation">}</span>
       <span class="token punctuation">}</span>
</code></pre> 
<h6><a id="93vue_367"></a>9.3、.vue结尾的文件</h6> 
<pre><code class="prism language-html">       <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>template</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>template</span><span class="token punctuation">&gt;</span></span>
       <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>script</span><span class="token punctuation">&gt;</span></span><span class="token script language-javascript"></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>script</span><span class="token punctuation">&gt;</span></span>
       <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>style</span><span class="token punctuation">&gt;</span></span><span class="token style language-css"></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>style</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<h5><a id="94_373"></a>9.4、单独指定一个模板内容</h5> 
<pre><code class="prism language-html">       <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>script</span>
       <span class="token attr-name">id</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">'</span>myContent<span class="token punctuation">'</span></span>
       <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">'</span>text/x-template<span class="token punctuation">'</span></span><span class="token punctuation">&gt;</span></span><span class="token script language-javascript">
       </span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>script</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<pre><code class="prism language-js">       Vue<span class="token punctuation">.</span><span class="token function">component</span><span class="token punctuation">(</span><span class="token string">''</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>
         template<span class="token punctuation">:</span><span class="token string">'#myContent'</span>
       <span class="token punctuation">}</span><span class="token punctuation">)</span>
</code></pre> 
<h3><a id="10_385"></a>10.路由模块</h3> 
<blockquote> 
 <p>路由模块的本质 就是建立起url和页面之间的映射关系。</p> 
</blockquote> 
<blockquote> 
 <p>SPA的基本概念和工作原理<br> SPA：single page application 单一页面应用程序，只有一个完整的页面；它在加载页面时，不会加载整个页面，而是只更新某个指定的容器中内容，比如Gmail、移动的webApp。</p> 
</blockquote> 
<blockquote> 
 <p>工作原理：<br> 解析地址栏：完整的页面地址、路由地址<br> 根据路由地址从路由词典中找到真正的要加载的页面<br> 发起ajax请求：请求要加载的页面<br> 像指定的容器中插入加载来的页面</p> 
</blockquote> 
<h5><a id="_397"></a>路由模块的基本使用</h5> 
<p>专业术语：<br> router路由器<br> route路由<br> routes 路由数组（路由词典）</p> 
<pre><code class="prism language-js"><span class="token comment">//1.引入 vue.js vue-router.js</span>
<span class="token comment">//2.指定一个容器</span>
   <span class="token operator">&lt;</span>router<span class="token operator">-</span>view<span class="token operator">&gt;</span><span class="token operator">&lt;</span><span class="token operator">/</span>router<span class="token operator">-</span>view<span class="token operator">&gt;</span>
<span class="token comment">//3.创建业务所需要用到的组件类</span>
<span class="token keyword">var</span> MyLogin <span class="token operator">=</span> Vue<span class="token punctuation">.</span><span class="token function">component</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token comment">//4.配置路由词典</span>
    <span class="token keyword">const</span> myRoutes <span class="token operator">=</span> <span class="token punctuation">[</span>
     <span class="token punctuation">{<!-- --></span>path<span class="token punctuation">:</span><span class="token string">''</span><span class="token punctuation">,</span>component<span class="token punctuation">:</span>MyLogin<span class="token punctuation">}</span><span class="token punctuation">,</span>
     <span class="token punctuation">{<!-- --></span>path<span class="token punctuation">:</span><span class="token string">'/login'</span><span class="token punctuation">,</span>component<span class="token punctuation">:</span>MyLogin<span class="token punctuation">}</span>
    <span class="token punctuation">]</span><span class="token punctuation">;</span>
    <span class="token keyword">const</span> myRouter <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">VueRouter</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
     routes<span class="token punctuation">:</span>myRoutes
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token keyword">new</span> <span class="token class-name">Vue</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
      router<span class="token punctuation">:</span>myRouter
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token comment">//5.测试</span>
<span class="token comment">//修改地址栏中的路由地址，测试看加载的组件是否正确</span>
<span class="token comment">//注意事项：</span>
<span class="token comment">//1.先引入vue，再引入插件</span>
<span class="token comment">//2.一定要指定`router-view`</span>
<span class="token comment">//3.route路由 {path:'',component:}</span>
<span class="token comment">//routes：路由数组 []</span>
<span class="token comment">//router：路由器，按照指定的路由规则去访问对应的组件 new VueRouter</span>
<span class="token comment">//3、使用路由模块来实现页面跳转的方式</span>
<span class="token comment">//方式1：</span>
<span class="token comment">//直接修改地址栏</span>
<span class="token comment">//方式2：</span>
   <span class="token keyword">this</span><span class="token punctuation">.</span>$router<span class="token punctuation">.</span><span class="token function">push</span><span class="token punctuation">(</span>‘路由地址’<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token comment">//方式3：</span>
    <span class="token operator">&lt;</span>router<span class="token operator">-</span>link
    to<span class="token operator">=</span><span class="token string">"路由地址"</span><span class="token operator">&gt;</span><span class="token operator">&lt;</span><span class="token operator">/</span>router<span class="token operator">-</span>link<span class="token operator">&gt;</span>

<span class="token comment">//4、完成参数的传递</span>
<span class="token comment">//在页面之间跳转的时候，在有些场景下，需要同时指定参数</span>
<span class="token comment">//1.明确发送方和接收方</span>
   list <span class="token operator">--</span><span class="token number">20</span><span class="token operator">--</span><span class="token operator">&gt;</span> detail
<span class="token comment">//2.配置接收方的路由地址</span>
   <span class="token operator">/</span>detail <span class="token operator">--</span>》 <span class="token operator">/</span>detail<span class="token operator">/</span><span class="token punctuation">:</span>index
   <span class="token keyword">this</span><span class="token punctuation">.</span>$route<span class="token punctuation">.</span>params<span class="token punctuation">.</span>index
<span class="token comment">//3.发送</span>
   routerLink to<span class="token operator">=</span><span class="token string">"/detail/20"</span>
   <span class="token keyword">this</span><span class="token punctuation">.</span>$router<span class="token punctuation">.</span><span class="token function">push</span><span class="token punctuation">(</span><span class="token string">'/detail/20'</span><span class="token punctuation">)</span>

<span class="token comment">//5、路由嵌套</span>
<span class="token comment">//在一个路由中，path对应一个component，如果这个component需要根据不同的url再加载其他的component，称之为路由的嵌套</span>

<span class="token comment">//举例：比如A组件现在需要根据不同的url，加载B组件或者C组件</span>

<span class="token comment">//1.给A组件指定一个容器</span>
     <span class="token operator">&lt;</span>router<span class="token operator">-</span>view<span class="token operator">&gt;</span><span class="token operator">&lt;</span><span class="token operator">/</span>router<span class="token operator">-</span>view<span class="token operator">&gt;</span>
<span class="token comment">//2.配置路由词典</span>
     <span class="token punctuation">{<!-- --></span>
       path<span class="token punctuation">:</span><span class="token string">'/a'</span><span class="token punctuation">,</span>
       component<span class="token punctuation">:</span><span class="token constant">A</span><span class="token punctuation">,</span>
       children<span class="token punctuation">:</span><span class="token punctuation">[</span>
         <span class="token punctuation">{<!-- --></span>path<span class="token punctuation">:</span><span class="token string">'/b'</span><span class="token punctuation">,</span>component<span class="token punctuation">:</span><span class="token constant">B</span><span class="token punctuation">}</span>
       <span class="token punctuation">]</span>
     <span class="token punctuation">}</span>
<span class="token comment">//需求：现在有两个组件，分别是login/mail,建立SPA。</span>

<span class="token comment">//在此基础上，希望mail组件 嵌套inbox/outbox/draft</span>

<span class="token comment">//补充：在设置子路由，路由匹配规则依然是适用的，只不过路由地址为空和异常，要携带父组件的路由地址</span>

  <span class="token comment">//   /mail /mail/draft</span>
</code></pre> 
<h3><a id="11CLI_470"></a>11.搭建基于CLI开发环境的方式</h3> 
<p>1.指定一个文件夹： <code>C:\xampp\htdocs\framework\vue\project</code></p> 
<p>2.将tpls.zip拷贝到project中</p> 
<p>3.右键单击压缩包，解压缩到当前文件夹</p> 
<p>4.进入到tpls</p> 
<p>5.同时按下shift和鼠标右键，选择在此位置打开命令行串口</p> 
<p>6.执行npm install</p> 
<p>7.执行npm start</p> 
<p>重新排版了下，原文链接…<a href="https://blog.csdn.net/weixin_41646716/article/details/79946981">https://blog.csdn.net/weixin_41646716/article/details/79946981</a></p>
                
{% endraw %}
