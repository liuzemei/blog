---
title: 调试技巧——宏定义开关和printf
date: 2018-08-26 08:28:27
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/82077625)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>printf 的宏定义版本</p> 
<p>转：<a href="https://blog.csdn.net/guanyasu/article/details/51866984">https://blog.csdn.net/guanyasu/article/details/51866984</a></p> 
<p>前言： <br> 我们在写程序的时候，总是或多或少会加入一些printf之类的语句用于输出调试信息，但是printf语句有个很不方便的地方就是当我们需要发布程序的时候要一条一条的把这些语句删除，而一旦需要再次调试的时候，这些语句又不得不一条条的加上，这给我们带来了很大的不便，浪费了我们很多的时间，也造成了调试的效率低下。所以，很多人会选择使用宏定义的方式来输出调试语句。</p> 
<p>比如，定义一个宏开关：</p> 
<h1 id="define-debug">define __DEBUG</h1> 
<p>当需要调试的时候，使用语句：</p> 
<h1 id="ifdef-debug">ifdef __DEBUG</h1> 
<p>printf(xxx);</p> 
<h1 id="endif">endif</h1> 
<p>这种方式的调试，可以通过undef __DEBUG的方式让告知编译器不编译这些语句，从而不再输出这些语句。但是这种方式的麻烦之处也是显而易见的，每一条调试语句都需要使用两条宏定义来包围，这不但在代码的编写上不便，源码结构也不好看，工作量依然不小。</p> 
<p>如果我们能够把这三条语句编程一条，那该多舒服呀~，于是，我们想到使用这样的语句：</p> 
<h1 id="ifdef-debug-1">ifdef __DEBUG</h1> 
<h1 id="define-debuginfo-printfinfo">define DEBUG(info) printf(info)</h1> 
<h1 id="else">else</h1> 
<h1 id="define-debuginfo">define DEBUG(info)</h1> 
<h1 id="endif-1">endif</h1> 
<p>这样，我们在编写代码的时候，使用DEBUG一条语句就可以了，我们把宏开关__DEBUG打开，所有的DEBUG(info)宏定义信息都会被替换为printf(info)，关上则会被替换成空，因此不会被编译。嗯，这次方便多了，一条语句就可以了~~~ 但是，问题也随之而来了，printf是支持多个参数的，而且是不定参数，当你使用下面这样的语句时就会报错：</p> 
<p>DEBUG(“%s”,msg)</p> 
<p>这是因为，DEBUG(info)这条宏定义只支持一个参数的替换。</p> 
<p>因此，我们希望DEBUG能够像printf那样，支持多个参数，并且这些参数刚好展开成为printf语句本身使用的参数，譬如：我们希望DEBUG(“%s”,msg)能够展开为printf(“%s”,msg)</p> 
<p>正文：</p> 
<p>通过网上的资料查阅，发现自C99规范以后，编译器就开始支持不定参数的宏定义，就像printf一样。</p> 
<p>大家可以看看这篇文章：<a href="http://blog.csdn.net/aobai219/archive/2010/12/22/6092292.aspx">http://blog.csdn.net/aobai219/archive/2010/12/22/6092292.aspx</a></p> 
<p>（这个链接也转的，我已经找不到原始作者到底是谁了，唉，互联网啊。。。）</p> 
<p>于是，我们定义了一个这样的东东：</p> 
<h1 id="define-debugformat-printf-format-vaargs-的意思是如果可变参数被忽略或为空将使预处理器-preprocessor-去除掉它前面的那个逗号">define DEBUG(format, …) printf (format, ##<strong>VA_ARGS</strong>)（’ ## ‘的意思是，如果可变参数被忽略或为空，将使预处理器（ preprocessor ）去除掉它前面的那个逗号。）</h1> 
<p>于是乎，我们神奇地发现，DEBUG完全取代了printf，所有的DEBUG(…)都被完成的替换成了printf(…)，再也不会因那个可恶的逗号而烦恼了。</p> 
<p>但是，我们发现，光有printf还不够，虽然调试信息是输出了，可是很多的调试信息输出，我们并不能一下子知道这条信息到底是在那里打印出来的，于是，我们又想，能不能把当前所在文件名和源码行位置也打印出来呢，这样不就一目了然了吗，哪里还用的着去想，去找调试信息在哪里输出的呢，都已经打印出来了！</p> 
<p>于是我们就有了下面的故事。。。</p> 
<p>编译器内置宏：</p> 
<p>先介绍几个编译器内置的宏定义，这些宏定义不仅可以帮助我们完成跨平台的源码编写，灵活使用也可以巧妙地帮我们输出非常有用的调试信息。</p> 
<p>ANSI C标准中有几个标准预定义宏（也是常用的）：</p> 
<p><strong>LINE</strong>：在源代码中插入当前源代码行号；</p> 
<p><strong>FILE</strong>：在源文件中插入当前源文件名；</p> 
<p><strong>DATE</strong>：在源文件中插入当前的编译日期</p> 
<p><strong>TIME</strong>：在源文件中插入当前编译时间；</p> 
<p><strong>STDC</strong>：当要求程序严格遵循ANSI C标准时该标识被赋值为1；</p> 
<p>__cplusplus：当编写C++程序时该标识符被定义。</p> 
<p>编译器在进行源码编译的时候，会自动将这些宏替换为相应内容。</p> 
<p>看到这里，你的眼睛应该一亮了吧，嗯，是的，<strong>FILE</strong>和<strong>LINE</strong>正是我们前面想要的输出的，于是，我们的每一条语句都变成了：</p> 
<p>DEBUG(“FILE: %s, LINE: %d…”,<strong>FILE</strong>,<strong>LINE</strong>,…)</p> 
<p>其实没有必要，<strong>FILE</strong>本身就会被编译器置换为字符常量，于是乎我们的语句又变成了这样：</p> 
<p>DEBUG(“FILE:”<strong>FILE</strong>“, LINE: %d…”,<strong>LINE</strong>,…)</p> 
<p>但是，我们还是不满足，依然发现，还是很讨厌，为什么每条语句都要写”FILE:”<strong>FILE</strong>“, LINE: %d 以及,__LINE,这两个部分呢？这不是浪费我们时间么？</p> 
<p>哈哈，是的，这就是本次大结局，把DEBUG写成这样：</p> 
<p>DEBUG(format,…) printf(“FILE: “<strong>FILE</strong>“, LINE: %d: “format”/n”, <strong>LINE</strong>, ##<strong>VA_ARGS</strong>)</p> 
<p>没错，就是这样！下面，所有的DEBUG信息都会按照这样的方式输出：</p> 
<p>FILE: xxx, LINE: xxx, …….</p> 
<p>最后：</p> 
<p>最后，老规矩，coding测试。</p> 
<p>view plain <br> ·········10········20········30········40········50········60········70········80········90········100·······110·······120·······130·······140·······150 <br> //============================================================================ <br> // Name : debug.cpp <br> // Author : boyce <br> // Version : 1.0 <br> // Copyright : pku <br> // Description : Hello World in C++, Ansi-style <br> //============================================================================ </p> 
<h1 id="include">include</h1> 
<h1 id="define-debug-1">define <strong>DEBUG</strong></h1> 
<h1 id="ifdef-debug-2">ifdef <strong>DEBUG</strong></h1> 
<h1 id="define-debugformat-printffile-file-line-05d-formatn-line-vaargs">define DEBUG(format,…) printf(“File: “<strong>FILE</strong>“, Line: %05d: “format”/n”, <strong>LINE</strong>, ##<strong>VA_ARGS</strong>)</h1> 
<h1 id="else-1">else</h1> 
<h1 id="define-debugformat">define DEBUG(format,…)</h1> 
<h1 id="endif-2">endif</h1> 
<p>int main() { <br> char str[]=”Hello World”; <br> DEBUG(“A ha, check me: %s”,str); <br> return 0; <br> } </p> 
<p>测试结果：</p>
                
{% endraw %}
