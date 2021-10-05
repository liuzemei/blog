---
title: webpack从入门到精通----（三）css-loader 及 less-loader
date: 2019-09-25 15:33:35
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/101368343)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h2><a id="_1"></a>第四课</h2> 
<h3><a id="lesscss_Loader_2"></a>less/css Loader</h3> 
<ol><li>安装<br> <code>yarn add css-loader style-loader less-loader less -D</code></li><li>在 webpack.config.js 文件中 使用</li></ol> 
<pre><code class="prism language-js">module<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 模块</span>
    rules<span class="token punctuation">:</span> <span class="token punctuation">[</span> <span class="token comment">// 规则  css-loader 主要用于解析 @import 语法的</span>
        <span class="token comment">// style-loader 他是把 css 插入 head 的标签中</span>
        <span class="token comment">// loader的特点 希望单一</span>
        <span class="token comment">// loader的用法： 字符串 只用一个loader</span>
        <span class="token comment">// 多个loader 需要 []</span>
        <span class="token comment">// loader的顺序 默认是从右向左(从下到上)执行， -&gt; 先解析 @import 再插入 head 中</span>
        <span class="token comment">// loader还可以写成 对象的方式</span>
        <span class="token punctuation">{<!-- --></span>
            test<span class="token punctuation">:</span> <span class="token regex">/\.css$/</span><span class="token punctuation">,</span>
            use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                <span class="token punctuation">{<!-- --></span>
                    loader<span class="token punctuation">:</span> <span class="token string">'style-loader'</span><span class="token punctuation">,</span>
                    options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                        insert<span class="token punctuation">:</span> <span class="token keyword">function</span> <span class="token function">insertAtTop</span><span class="token punctuation">(</span>element<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 之前是insertAt，现在是一个函数或者elementString</span>
                            <span class="token keyword">var</span> parent <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">querySelector</span><span class="token punctuation">(</span><span class="token string">'head'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                            <span class="token keyword">var</span> lastInsertedElement <span class="token operator">=</span>
                                window<span class="token punctuation">.</span>_lastElementInsertedByStyleLoader<span class="token punctuation">;</span>

                            <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>lastInsertedElement<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                parent<span class="token punctuation">.</span><span class="token function">insertBefore</span><span class="token punctuation">(</span>element<span class="token punctuation">,</span> parent<span class="token punctuation">.</span>firstChild<span class="token punctuation">)</span><span class="token punctuation">;</span>
                            <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token keyword">if</span> <span class="token punctuation">(</span>lastInsertedElement<span class="token punctuation">.</span>nextSibling<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                parent<span class="token punctuation">.</span><span class="token function">insertBefore</span><span class="token punctuation">(</span>element<span class="token punctuation">,</span> lastInsertedElement<span class="token punctuation">.</span>nextSibling<span class="token punctuation">)</span><span class="token punctuation">;</span>
                            <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
                                parent<span class="token punctuation">.</span><span class="token function">appendChild</span><span class="token punctuation">(</span>element<span class="token punctuation">)</span><span class="token punctuation">;</span>
                            <span class="token punctuation">}</span>
                            window<span class="token punctuation">.</span>_lastElementInsertedByStyleLoader <span class="token operator">=</span> element<span class="token punctuation">;</span>
                        <span class="token punctuation">}</span><span class="token punctuation">,</span>
                    <span class="token punctuation">}</span>
                <span class="token punctuation">}</span><span class="token punctuation">,</span>
                <span class="token string">'css-loader'</span><span class="token punctuation">,</span>
            <span class="token punctuation">]</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>
            test<span class="token punctuation">:</span> <span class="token regex">/\.less$/</span><span class="token punctuation">,</span>
            use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                <span class="token punctuation">{<!-- --></span>
                    loader<span class="token punctuation">:</span> <span class="token string">'style-loader'</span><span class="token punctuation">,</span>
                    options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                        insert<span class="token punctuation">:</span> <span class="token keyword">function</span> <span class="token function">insertAtTop</span><span class="token punctuation">(</span>element<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                            <span class="token keyword">var</span> parent <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">querySelector</span><span class="token punctuation">(</span><span class="token string">'head'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                            <span class="token comment">// eslint-disable-next-line no-underscore-dangle</span>
                            <span class="token keyword">var</span> lastInsertedElement <span class="token operator">=</span>
                                window<span class="token punctuation">.</span>_lastElementInsertedByStyleLoader<span class="token punctuation">;</span>

                            <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>lastInsertedElement<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                parent<span class="token punctuation">.</span><span class="token function">insertBefore</span><span class="token punctuation">(</span>element<span class="token punctuation">,</span> parent<span class="token punctuation">.</span>firstChild<span class="token punctuation">)</span><span class="token punctuation">;</span>
                            <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token keyword">if</span> <span class="token punctuation">(</span>lastInsertedElement<span class="token punctuation">.</span>nextSibling<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                parent<span class="token punctuation">.</span><span class="token function">insertBefore</span><span class="token punctuation">(</span>element<span class="token punctuation">,</span> lastInsertedElement<span class="token punctuation">.</span>nextSibling<span class="token punctuation">)</span><span class="token punctuation">;</span>
                            <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
                                parent<span class="token punctuation">.</span><span class="token function">appendChild</span><span class="token punctuation">(</span>element<span class="token punctuation">)</span><span class="token punctuation">;</span>
                            <span class="token punctuation">}</span>

                            <span class="token comment">// eslint-disable-next-line no-underscore-dangle</span>
                            window<span class="token punctuation">.</span>_lastElementInsertedByStyleLoader <span class="token operator">=</span> element<span class="token punctuation">;</span>
                        <span class="token punctuation">}</span><span class="token punctuation">,</span>
                    <span class="token punctuation">}</span>
                <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token comment">// 以 link 标签的方式插入到指定标签中</span>
                <span class="token string">'css-loader'</span><span class="token punctuation">,</span> <span class="token comment">// 解析 @import</span>
                <span class="token string">'less-loader'</span> <span class="token comment">// less -&gt; css</span>
            <span class="token punctuation">]</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>最终配置：</p> 
<pre><code class="prism language-js"><span class="token comment">// webpack 是node 写出来的 node的写法来运行</span>

<span class="token keyword">let</span> path <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'path'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">let</span> HtmlWebpackPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'html-webpack-plugin'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    devServer<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 开发服务器的配置</span>
        port<span class="token punctuation">:</span> <span class="token number">3000</span><span class="token punctuation">,</span> <span class="token comment">// 启动端口</span>
        progress<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">// 滚动条</span>
        contentBase<span class="token punctuation">:</span> <span class="token string">'./build'</span><span class="token punctuation">,</span> <span class="token comment">// 启动服务的路径</span>
        compress<span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token comment">//压缩</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    mode<span class="token punctuation">:</span> <span class="token string">'development'</span><span class="token punctuation">,</span> <span class="token comment">// 模式 默认两种 production(会压缩js文件) development</span>
    entry<span class="token punctuation">:</span> <span class="token string">'./src/index.js'</span><span class="token punctuation">,</span> <span class="token comment">//入口</span>
    output<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 出口</span>
        filename<span class="token punctuation">:</span> <span class="token string">'bundle.[hash:8].js'</span><span class="token punctuation">,</span> <span class="token comment">// 打包后的文件名 [hash:8] 只显示8位的hash文件</span>
        path<span class="token punctuation">:</span> path<span class="token punctuation">.</span><span class="token function">resolve</span><span class="token punctuation">(</span>__dirname<span class="token punctuation">,</span> <span class="token string">'build'</span><span class="token punctuation">)</span> <span class="token comment">// 路径必须是一个绝对路径</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span> <span class="token comment">// 数组 放着所有的webpack插件</span>
        <span class="token keyword">new</span> <span class="token class-name">HtmlWebpackPlugin</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
            template<span class="token punctuation">:</span> <span class="token string">'./src/index.html'</span><span class="token punctuation">,</span> <span class="token comment">// 打包的模板路径</span>
            filename<span class="token punctuation">:</span> <span class="token string">'index.html'</span><span class="token punctuation">,</span> <span class="token comment">// 打包之后的文件名</span>
            minify<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                removeAttributeQuotes<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
                collapseWhitespace<span class="token punctuation">:</span> <span class="token boolean">true</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            hash<span class="token punctuation">:</span> <span class="token boolean">true</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    module<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 模块</span>
        rules<span class="token punctuation">:</span> <span class="token punctuation">[</span> <span class="token comment">// 规则  css-loader 主要用于解析 @import 语法的</span>
            <span class="token comment">// style-loader 他是把 css 插入 head 的标签中</span>
            <span class="token comment">// loader的特点 希望单一</span>
            <span class="token comment">// loader的用法： 字符串 只用一个loader</span>
            <span class="token comment">// 多个loader 需要 []</span>
            <span class="token comment">// loader的顺序 默认是从右向左(从下到上)执行， -&gt; 先解析 @import 再插入 head 中</span>
            <span class="token comment">// loader还可以写成 对象的方式</span>
            <span class="token punctuation">{<!-- --></span>
                test<span class="token punctuation">:</span> <span class="token regex">/\.css$/</span><span class="token punctuation">,</span>
                use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                    <span class="token punctuation">{<!-- --></span>
                        loader<span class="token punctuation">:</span> <span class="token string">'style-loader'</span><span class="token punctuation">,</span>
                        options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                            insert<span class="token punctuation">:</span> <span class="token keyword">function</span> <span class="token function">insertAtTop</span><span class="token punctuation">(</span>element<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                <span class="token keyword">var</span> parent <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">querySelector</span><span class="token punctuation">(</span><span class="token string">'head'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                                <span class="token comment">// eslint-disable-next-line no-underscore-dangle</span>
                                <span class="token keyword">var</span> lastInsertedElement <span class="token operator">=</span>
                                    window<span class="token punctuation">.</span>_lastElementInsertedByStyleLoader<span class="token punctuation">;</span>

                                <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>lastInsertedElement<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                    parent<span class="token punctuation">.</span><span class="token function">insertBefore</span><span class="token punctuation">(</span>element<span class="token punctuation">,</span> parent<span class="token punctuation">.</span>firstChild<span class="token punctuation">)</span><span class="token punctuation">;</span>
                                <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token keyword">if</span> <span class="token punctuation">(</span>lastInsertedElement<span class="token punctuation">.</span>nextSibling<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                    parent<span class="token punctuation">.</span><span class="token function">insertBefore</span><span class="token punctuation">(</span>element<span class="token punctuation">,</span> lastInsertedElement<span class="token punctuation">.</span>nextSibling<span class="token punctuation">)</span><span class="token punctuation">;</span>
                                <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
                                    parent<span class="token punctuation">.</span><span class="token function">appendChild</span><span class="token punctuation">(</span>element<span class="token punctuation">)</span><span class="token punctuation">;</span>
                                <span class="token punctuation">}</span>

                                <span class="token comment">// eslint-disable-next-line no-underscore-dangle</span>
                                window<span class="token punctuation">.</span>_lastElementInsertedByStyleLoader <span class="token operator">=</span> element<span class="token punctuation">;</span>
                            <span class="token punctuation">}</span><span class="token punctuation">,</span>
                        <span class="token punctuation">}</span>
                    <span class="token punctuation">}</span><span class="token punctuation">,</span>
                    <span class="token string">'css-loader'</span><span class="token punctuation">,</span>
                <span class="token punctuation">]</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token punctuation">{<!-- --></span>
                test<span class="token punctuation">:</span> <span class="token regex">/\.less$/</span><span class="token punctuation">,</span>
                use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                    <span class="token punctuation">{<!-- --></span>
                        loader<span class="token punctuation">:</span> <span class="token string">'style-loader'</span><span class="token punctuation">,</span>
                        options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                            insert<span class="token punctuation">:</span> <span class="token keyword">function</span> <span class="token function">insertAtTop</span><span class="token punctuation">(</span>element<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                <span class="token keyword">var</span> parent <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">querySelector</span><span class="token punctuation">(</span><span class="token string">'head'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                                <span class="token comment">// eslint-disable-next-line no-underscore-dangle</span>
                                <span class="token keyword">var</span> lastInsertedElement <span class="token operator">=</span>
                                    window<span class="token punctuation">.</span>_lastElementInsertedByStyleLoader<span class="token punctuation">;</span>

                                <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>lastInsertedElement<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                    parent<span class="token punctuation">.</span><span class="token function">insertBefore</span><span class="token punctuation">(</span>element<span class="token punctuation">,</span> parent<span class="token punctuation">.</span>firstChild<span class="token punctuation">)</span><span class="token punctuation">;</span>
                                <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token keyword">if</span> <span class="token punctuation">(</span>lastInsertedElement<span class="token punctuation">.</span>nextSibling<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                                    parent<span class="token punctuation">.</span><span class="token function">insertBefore</span><span class="token punctuation">(</span>element<span class="token punctuation">,</span> lastInsertedElement<span class="token punctuation">.</span>nextSibling<span class="token punctuation">)</span><span class="token punctuation">;</span>
                                <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
                                    parent<span class="token punctuation">.</span><span class="token function">appendChild</span><span class="token punctuation">(</span>element<span class="token punctuation">)</span><span class="token punctuation">;</span>
                                <span class="token punctuation">}</span>

                                <span class="token comment">// eslint-disable-next-line no-underscore-dangle</span>
                                window<span class="token punctuation">.</span>_lastElementInsertedByStyleLoader <span class="token operator">=</span> element<span class="token punctuation">;</span>
                            <span class="token punctuation">}</span><span class="token punctuation">,</span>
                        <span class="token punctuation">}</span>
                    <span class="token punctuation">}</span><span class="token punctuation">,</span>
                    <span class="token string">'css-loader'</span><span class="token punctuation">,</span>
                    <span class="token string">'less-loader'</span>
                <span class="token punctuation">]</span>
            <span class="token punctuation">}</span>
        <span class="token punctuation">]</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre>
                
{% endraw %}
