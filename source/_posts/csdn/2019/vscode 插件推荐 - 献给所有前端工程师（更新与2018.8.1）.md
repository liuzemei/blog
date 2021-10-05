---
title: vscode 插件推荐 - 献给所有前端工程师（更新与2018.8.1）
date: 2019-01-28 09:28:23
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/86672184)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p><a href="https://www.cnblogs.com/vivaxiaonan/p/7380099.html">https://www.cnblogs.com/vivaxiaonan/p/7380099.html</a></p> 
<p>VScode现在已经越来越完善。性能远超Atom和webstorm,你有什么理由不用它?<br> 在这里，我会给你们推荐很多实用的插件，让你对 vscode 有更深刻的体会，渐渐地你就会知道它有多好用。</p> 
<p>走马观花前，请先将你的 vscode 更新到最新版本。</p> 
<p>通用插件<br> HTML Snippets<br> 超级实用且初级的 H5代码片段以及提示</p> 
<p>HTML CSS Support<br> 让 html 标签上写class 智能提示当前项目所支持的样式<br> 新版已经支持scss文件检索</p> 
<p>Debugger for Chrome<br> 让 vscode 映射 chrome 的 debug功能，静态页面都可以用 vscode 来打断点调试，真666~<br> 配置稍微复杂一些，哪天心情好我再另写教程吧~</p> 
<p>jQuery Code Snippets<br> jquery 重度患者必须品，废话不多说，上图</p> 
<p>vscode-icon<br> 让 vscode 资源树目录加上图标，必备良品！</p> 
<p>Path Intellisense<br> 自动路劲补全，默认不带这个功能的，赶紧装</p> 
<p>Npm Intellisense<br> require 时的包提示（最新版的vscode已经集成此功能）</p> 
<p>Document this<br> js 的注释模板 （注意：最新版的vscode已经原生支持）</p> 
<p>ESlint<br> ESlint 接管原生 js 提示，可以自定制提示规则。这个比较高玩，不会的就算了，我之前发过一篇文章 sublime 配置 Atom js 语法校验中有提到，他们的配置文件是通用的。</p> 
<p>HTMLHint<br> html代码检测</p> 
<p>Project Manager<br> 在多个项目之前快速切换的工具</p> 
<p>beautify<br> 格式化代码的工具</p> 
<p>Bootstrap 3 Sinnpet<br> 常用 bootstrap 的可以下</p> 
<p>Atuo Rename Tag<br> 修改 html 标签，自动帮你完成尾部闭合标签的同步修改，不过有些bug。</p> 
<p>GitLens<br> 丰富的git日志插件</p> 
<p>fileheader<br> 顶部注释模板，可定义作者、时间等信息，并会自动更新最后修改时间</p> 
<p>filesize<br> 在底部状态栏显示当前文件大小，点击后还可以看到详细创建、修改时间</p> 
<p>Bracket Pair Colorizer<br> 让括号拥有独立的颜色，易于区分。可以配合任意主题使用。</p> 
<p>Quokka<br> 精选！15个必备的VSCode插件</p> 
<p>使用：先shift+cmd+p （ctrl+shift+p）输入 quokka 选择 new javascript 就行了</p> 
<p>Quokka 是一个调试工具插件，能够根据你正在编写的代码提供实时反馈。它易于配置，并能够预览变量的函数和计算值结果。另外，在使用 JSX 或 TypeScript 项目中，它能够开箱即用。</p> 
<p>/<em>?</em>/在某个表达式之后（或//?在语句之后）插入特殊注释将仅记录该表达式的值。</p> 
<p>例如，</p> 
<p>a.b()/<em>?</em>/.c().d()<br> 将输出a.b()表达式的结果，和</p> 
<p>a.b().c().d() /<em>?</em>/<br> // or just<br> a.b().c().d() //?<br> 将输出完整a.b().c().d()表达式的结果。</p> 
<p>/<em>?.</em>/ 在任何表达式之后插入特殊注释将报告执行表达式所花费的时间。</p> 
<p>a() //?. $<br> 显示<br> a()<br> 执行时间和结果。</p> 
<p>插件地址：<a href="https://quokkajs.com/">https://quokkajs.com/</a></p> 
<p>CSS Peek<br> 精选！15个必备的VSCode插件</p> 
<p>使用此插件，你可以追踪至样式表中 CSS 类和 ids 定义的地方。当你在 HTML 文件中右键单击选择器时，选择“ Go to Definition 和 Peek definition ”选项，它便会给你发送样式设置的 CSS 代码。</p> 
<p>插件地址：</p> 
<p><a href="https://marketplace.visualstudio.com/items?itemName=pranaygp.vscode-css-peek">https://marketplace.visualstudio.com/items?itemName=pranaygp.vscode-css-peek</a></p> 
<p>HTML Boilerplate<br> 精选！15个必备的VSCode插件</p> 
<p>通过使用 HTML 模版插件，你就摆脱了为 HTML 新文件重新编写头部和正文标签的苦恼。你只需在空文件中输入 html，并按 Tab 键，即可生成干净的文档结构。</p> 
<p>插件地址：</p> 
<p><a href="https://marketplace.visualstudio.com/items?itemName=sidthesloth.html5-boilerplate">https://marketplace.visualstudio.com/items?itemName=sidthesloth.html5-boilerplate</a></p> 
<p>Prettier<br> 精选！15个必备的VSCode插件</p> 
<p>Prettier 是目前 Web 开发中最受欢迎的代码格式化程序。安装了这个插件，它就能够自动应用 Prettier，并将整个 JS 和 CSS 文档快速格式化为统一的代码样式。如果你还想使用 ESLint，那么还有个 Prettier – Eslint 插件，你可不要错过咯！</p> 
<p>插件地址：</p> 
<p><a href="https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode">https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode</a></p> 
<p>Color Info<br> 精选！15个必备的VSCode插件</p> 
<p>这个便捷的插件，将为你提供你在 CSS 中使用颜色的相关信息。你只需在颜色上悬停光标，就可以预览色块中色彩模型的（HEX、 RGB、HSL 和 CMYK）相关信息了。</p> 
<p>插件地址：</p> 
<p><a href="https://marketplace.visualstudio.com/items?itemName=bierner.color-info">https://marketplace.visualstudio.com/items?itemName=bierner.color-info</a></p> 
<p>Icon Fonts<br> 精选！15个必备的VSCode插件</p> 
<p>这是一个能够在项目中添加图标字体的插件。该插件支持超过 20 个热门的图标集，包括了 Font Awesome、Ionicons、Glyphicons 和 Material Design Icons。</p> 
<p>插件地址：</p> 
<p><a href="https://marketplace.visualstudio.com/items?itemName=idleberg.icon-fonts">https://marketplace.visualstudio.com/items?itemName=idleberg.icon-fonts</a></p> 
<p>Minify<br> 精选！15个必备的VSCode插件</p> 
<p>这是一款用于压缩合并 JavaScript 和 CSS 文件的应用程序。它提供了大量自定义的设置，以及自动压缩保存并导出为.min文件的选项。它能够分别通过 uglify-js、clean-css 和 html-minifier，与 JavaScript、CSS 和 HTML 协同工作。</p> 
<p>使用F1 运行文件缩小器Minify</p> 
<p>插件地址：</p> 
<p><a href="https://marketplace.visualstudio.com/items?itemName=HookyQR.minify">https://marketplace.visualstudio.com/items?itemName=HookyQR.minify</a></p> 
<p>Vue插件<br> 以下推荐vue框架所需的插件</p> 
<p>vetur<br> 语法高亮、智能感知、Emmet等</p> 
<p>VueHelper<br> snippet代码片段</p> 
<p>主题<br> Material<br> 冷门、好看、实用。此主题已停更许久</p> 
<p>Dracula<br> 目前我觉得是vscode上最漂亮的主题,vscode 1.11+允许自定义statusBar等全局ui后,该主题也跟进改了很多小细节,良心!~</p> 
<p>One Dark Pro<br> 源于Atom,老版本的Atom One Dark主题可以扔了.</p> 
<p>Themes<br> 精选！15个必备的VSCode插件</p> 
<p>当然，在众多的实用插件中，岂能少了漂亮的主题呢？你每天都会与你的 VSCode 编辑器进行“亲密的接触”，为何不把它打扮得更漂亮些呢？这里有一些帮助你更改侧边栏的配色方案，以及图标的相关主题，与大家分享：</p> 
<p>• One Monokai</p> 
<p>• Aglia</p> 
<p>• One Dark</p> 
<p>• Material Icon</p> 
<p>没有一款字体能够让所有人都喜欢。但是，总有一款字体能够让你满意。在等宽字体中，我推荐五款我觉得十分养眼的给大家，希望你们也喜欢。</p> 
<p>1、Source Code Pro</p> 
<p>这款来自Adobe的开源字体，是我的最爱。</p> 
<p>Source Code Pro<br> 2、Menlo</p> 
<p>Menlo<br> 3、Consolas</p> 
<p>Consolas<br> 4、Monaco</p> 
<p>Monaco<br> 5、Courier New</p>
                
{% endraw %}
