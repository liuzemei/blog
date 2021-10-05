---
title: go语言学习第一天
date: 2018-10-05 23:12:14
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/82947920)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>go语言学习第一天。</p> 
<p>直接上代码：主要内容为变量相关：</p> 
<blockquote> 
 <ul><li>变量</li></ul> 
 <ol><li>变量命名</li><li>变量声明</li><li>变量赋值</li></ol> 
 <ul><li>常量及iota</li><li>数据类型：</li></ul> 
 <ol><li>整数</li><li>浮点数</li><li>复数</li><li>字符串</li><li>指针</li><li>结构体</li></ol> 
 <ul><li>作用域</li><li>数据的输入和输出</li></ul> 
</blockquote> 
<p>代码如下~</p> 
<pre class=" language-go"><code class="prism  language-go"><span class="token keyword">package</span> main

<span class="token keyword">import</span> <span class="token punctuation">(</span>
	<span class="token string">"fmt"</span>
	<span class="token string">"time"</span>
<span class="token punctuation">)</span>

<span class="token comment">//var Age int</span>

<span class="token keyword">type</span> Age <span class="token builtin">int</span>

<span class="token comment">//var age Age</span>
<span class="token keyword">type</span> Score <span class="token builtin">int</span>

<span class="token comment">//type Score struct{<!-- --></span>
<span class="token comment">//	age int</span>
<span class="token comment">//	name string</span>
<span class="token comment">//}</span>

<span class="token keyword">func</span> <span class="token punctuation">(</span>s Score<span class="token punctuation">)</span> <span class="token function">Info</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">//类的成员函数，叫方法</span>
	<span class="token keyword">if</span> s <span class="token operator">==</span> <span class="token number">100</span> <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">" 优秀"</span><span class="token punctuation">)</span>
		i <span class="token operator">:=</span> <span class="token number">10</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"i="</span><span class="token punctuation">,</span> i<span class="token punctuation">)</span>
	<span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">" 垃圾"</span><span class="token punctuation">)</span>
		<span class="token comment">//fmt.Println("i=", i)</span>
	<span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token comment">//三种输入三种输出函数</span>
<span class="token keyword">func</span> <span class="token function">IO</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token comment">//三种输出</span>
	fmt<span class="token punctuation">.</span><span class="token function">Print</span><span class="token punctuation">(</span><span class="token string">"Hello"</span><span class="token punctuation">)</span>   <span class="token comment">//不自动换行</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"World"</span><span class="token punctuation">)</span> <span class="token comment">//自动换行</span>
	a <span class="token operator">:=</span> <span class="token number">10</span>
	b <span class="token operator">:=</span> <span class="token number">20</span> <span class="token comment">/*
		fmt.Printf("%d,%d\n", a, b) //格式化的输出,不自动换行
		//三种输入
		//1  输入两个变量时，中间的分隔符可以是空格、tab 键和回车键。
		fmt.Scan(&amp;a, &amp;b)
		fmt.Println("a=", a, "b=", b)
		//2  输入两个变量时，中间的分隔符可以是空格、Tab 键，回车键表示输入的结束
		//回车以后的变量是之前的值，如果只定义未初始化，就是零值。
		fmt.Scanln(&amp;a, &amp;b)
	//	fmt.Println("a=", a, "b=", b)*/</span>
	<span class="token comment">//3  格式化的输入，不自动换行</span>
	<span class="token comment">//输入分隔符和第一个参数中的分隔符要一致</span>
	<span class="token comment">//如果不用那个分隔符的话，就只赋值前面的一个数，后面的数是之前变量的值。</span>
	fmt<span class="token punctuation">.</span><span class="token function">Scanf</span><span class="token punctuation">(</span><span class="token string">"%d,%d"</span><span class="token punctuation">,</span> <span class="token operator">&amp;</span>a<span class="token punctuation">,</span> <span class="token operator">&amp;</span>b<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"a="</span><span class="token punctuation">,</span> a<span class="token punctuation">,</span> <span class="token string">"b="</span><span class="token punctuation">,</span> b<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//分支结构：打印月份的天数</span>
<span class="token keyword">func</span> <span class="token function">switchDemo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">var</span> month <span class="token builtin">int</span>
	<span class="token keyword">var</span> Jan <span class="token builtin">int</span> <span class="token operator">=</span> <span class="token number">1</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"请输入月份"</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Scan</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>month<span class="token punctuation">)</span>

	<span class="token keyword">switch</span> month <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">case</span> Jan<span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">,</span> <span class="token number">7</span><span class="token punctuation">,</span> <span class="token number">8</span><span class="token punctuation">,</span> <span class="token number">10</span><span class="token punctuation">,</span> <span class="token number">12</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"31天"</span><span class="token punctuation">)</span>
	<span class="token keyword">case</span> <span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">6</span><span class="token punctuation">,</span> <span class="token number">9</span><span class="token punctuation">,</span> <span class="token number">11</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"30天"</span><span class="token punctuation">)</span>
	<span class="token keyword">case</span> <span class="token number">2</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"28天or29天"</span><span class="token punctuation">)</span>
	<span class="token keyword">default</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">" 月份输入错误！"</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
	<span class="token keyword">var</span> month1 <span class="token builtin">string</span>
	<span class="token keyword">switch</span> month1 <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">case</span> <span class="token string">"Jan"</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"31days"</span><span class="token punctuation">)</span>

	<span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token comment">//打印成绩的等级</span>
<span class="token keyword">func</span> <span class="token function">switchDemo2</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">" 请输入您的成绩"</span><span class="token punctuation">)</span>
	<span class="token keyword">var</span> score <span class="token builtin">float32</span>
	fmt<span class="token punctuation">.</span><span class="token function">Scan</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>score<span class="token punctuation">)</span>
	<span class="token keyword">switch</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">case</span> score <span class="token operator">&lt;=</span> <span class="token number">100</span> <span class="token operator">&amp;&amp;</span> score <span class="token operator">&gt;=</span> <span class="token number">90</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"A"</span><span class="token punctuation">)</span>
	<span class="token keyword">case</span> score <span class="token operator">&lt;</span> <span class="token number">90</span> <span class="token operator">&amp;&amp;</span> score <span class="token operator">&gt;=</span> <span class="token number">80</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"B"</span><span class="token punctuation">)</span>
	<span class="token keyword">case</span> score <span class="token operator">&lt;</span> <span class="token number">80</span> <span class="token operator">&amp;&amp;</span> score <span class="token operator">&gt;=</span> <span class="token number">60</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"C"</span><span class="token punctuation">)</span>
	<span class="token keyword">case</span> score <span class="token operator">&lt;</span> <span class="token number">60</span> <span class="token operator">&amp;&amp;</span> score <span class="token operator">&gt;=</span> <span class="token number">0</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>score<span class="token punctuation">)</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"D"</span><span class="token punctuation">)</span>
	<span class="token keyword">default</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"输入成绩有误"</span><span class="token punctuation">)</span>

	<span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">forDemo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	s <span class="token operator">:=</span> <span class="token number">0</span>
	<span class="token comment">//1  完整表述</span>
	<span class="token comment">//for ( i := 1; i &lt;= 100; i++ ) {//不能有小括号，有就报错</span>
	<span class="token comment">//	for ; i &lt;= 100; i++ {<!-- --></span>
	<span class="token comment">//		s += i</span>
	<span class="token comment">//	}</span>
	<span class="token comment">//2  省略表达式1</span>
	<span class="token comment">//i := 1</span>
	<span class="token comment">//	for ; i &lt;= 100; i++ {<!-- --></span>
	<span class="token comment">//		s += i</span>
	<span class="token comment">//	}</span>
	<span class="token comment">//3  省略表达式2</span>
	<span class="token comment">//	i := 1</span>
	<span class="token comment">//	for ; ; i++ {<!-- --></span>
	<span class="token comment">//		if i &gt; 100 {<!-- --></span>
	<span class="token comment">//			break</span>
	<span class="token comment">//		}</span>
	<span class="token comment">//		s += i</span>
	<span class="token comment">//	}</span>
	<span class="token comment">//4  省略所有表达式</span>
	i <span class="token operator">:=</span> <span class="token number">1</span>
	<span class="token keyword">for</span> <span class="token punctuation">{<!-- --></span>

		<span class="token keyword">if</span> i <span class="token operator">&gt;</span> <span class="token number">100</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">//表达式2</span>
			<span class="token keyword">break</span>
		<span class="token punctuation">}</span>
		s <span class="token operator">+=</span> i <span class="token comment">//循环体</span>
		i<span class="token operator">++</span>    <span class="token comment">//表达式3</span>
	<span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>s<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//多元赋值与多赋值语句的区别</span>
<span class="token keyword">func</span> <span class="token function">manyValue</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	array <span class="token operator">:=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">,</span> <span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">,</span> <span class="token number">6</span><span class="token punctuation">,</span> <span class="token number">7</span><span class="token punctuation">}</span>
	<span class="token comment">//	for i, j := 0, len(array)-1; i &lt; j; i, j = i+1, j-1 {<!-- --></span>
	<span class="token comment">//		array[i], array[j] = array[j], array[i]</span>
	<span class="token comment">//	}</span>
	<span class="token comment">//	fmt.Println(array)</span>

	i<span class="token punctuation">,</span> j <span class="token operator">:=</span> <span class="token number">0</span><span class="token punctuation">,</span> <span class="token function">len</span><span class="token punctuation">(</span>array<span class="token punctuation">)</span><span class="token operator">-</span><span class="token number">1</span>
	<span class="token keyword">for</span> <span class="token punctuation">{<!-- --></span>
		<span class="token keyword">if</span> i <span class="token operator">&gt;</span> j <span class="token punctuation">{<!-- --></span>
			<span class="token keyword">break</span>
		<span class="token punctuation">}</span>
		array<span class="token punctuation">[</span>i<span class="token punctuation">]</span><span class="token punctuation">,</span> array<span class="token punctuation">[</span>j<span class="token punctuation">]</span> <span class="token operator">=</span> array<span class="token punctuation">[</span>j<span class="token punctuation">]</span><span class="token punctuation">,</span> array<span class="token punctuation">[</span>i<span class="token punctuation">]</span>
		i<span class="token operator">++</span>
		j<span class="token operator">--</span>
	<span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>array<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">const</span> <span class="token punctuation">(</span>
	Sunday <span class="token operator">=</span> <span class="token boolean">iota</span>
	Monday
	Tuesday
	Wednesday
	Thursday
	Friday
	Saturday
<span class="token punctuation">)</span>

<span class="token keyword">func</span> <span class="token function">continueDemo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">for</span> i <span class="token operator">:=</span> <span class="token number">0</span><span class="token punctuation">;</span> i <span class="token operator">&lt;=</span> <span class="token number">100</span><span class="token punctuation">;</span> i<span class="token operator">++</span> <span class="token punctuation">{<!-- --></span>
		<span class="token keyword">if</span> i <span class="token operator">&gt;</span> <span class="token number">50</span> <span class="token punctuation">{<!-- --></span>
			<span class="token keyword">goto</span> FINISH <span class="token comment">//goto 语句</span>
		<span class="token punctuation">}</span>
		<span class="token keyword">if</span> i<span class="token operator">%</span><span class="token number">5</span> <span class="token operator">!=</span> <span class="token number">0</span> <span class="token punctuation">{<!-- --></span>
			<span class="token keyword">continue</span> <span class="token comment">//结束本次循环</span>
		<span class="token punctuation">}</span>
		fmt<span class="token punctuation">.</span><span class="token function">Print</span><span class="token punctuation">(</span>i<span class="token punctuation">,</span> <span class="token string">" "</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">""</span><span class="token punctuation">)</span>
FINISH<span class="token punctuation">:</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">""</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//数组的演示</span>
<span class="token keyword">func</span> <span class="token function">ArrayDemo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token comment">//1  一般格式的声明</span>
	<span class="token keyword">var</span> arr1 <span class="token punctuation">[</span><span class="token number">3</span><span class="token punctuation">]</span><span class="token builtin">int</span> <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token number">3</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">}</span>
	<span class="token keyword">var</span> arr2 <span class="token punctuation">[</span><span class="token number">3</span><span class="token punctuation">]</span><span class="token builtin">int</span>
	arr2 <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token number">3</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">,</span> <span class="token number">6</span><span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>arr1<span class="token punctuation">,</span> arr2<span class="token punctuation">)</span>
	<span class="token comment">//2  简短声明</span>
	arr3 <span class="token operator">:=</span> <span class="token punctuation">[</span><span class="token number">3</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">7</span><span class="token punctuation">,</span> <span class="token number">8</span><span class="token punctuation">,</span> <span class="token number">9</span><span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>arr3<span class="token punctuation">,</span> <span class="token function">len</span><span class="token punctuation">(</span>arr3<span class="token punctuation">)</span><span class="token punctuation">)</span>
	arr4 <span class="token operator">:=</span> <span class="token punctuation">[</span><span class="token operator">...</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">23</span><span class="token punctuation">,</span> <span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">,</span> <span class="token number">6</span><span class="token punctuation">,</span> <span class="token number">7</span><span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>arr4<span class="token punctuation">,</span> <span class="token function">len</span><span class="token punctuation">(</span>arr4<span class="token punctuation">)</span><span class="token punctuation">,</span> arr4<span class="token punctuation">[</span><span class="token number">3</span><span class="token punctuation">]</span><span class="token punctuation">)</span>

	arr5 <span class="token operator">:=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">9</span><span class="token punctuation">:</span> <span class="token number">10</span><span class="token punctuation">}</span> <span class="token comment">//切片</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>arr5<span class="token punctuation">,</span> <span class="token function">len</span><span class="token punctuation">(</span>arr5<span class="token punctuation">)</span><span class="token punctuation">)</span>

	arr6 <span class="token operator">:=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">}</span> <span class="token comment">//切片</span>
	arr6<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token number">10</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>arr6<span class="token punctuation">)</span>

	<span class="token comment">//3  数组遍历</span>
	<span class="token keyword">for</span> i <span class="token operator">:=</span> <span class="token number">0</span><span class="token punctuation">;</span> i <span class="token operator">&lt;</span> <span class="token function">len</span><span class="token punctuation">(</span>arr4<span class="token punctuation">)</span><span class="token punctuation">;</span> i<span class="token operator">++</span> <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Print</span><span class="token punctuation">(</span>arr4<span class="token punctuation">[</span>i<span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token string">" "</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">""</span><span class="token punctuation">)</span>

	<span class="token keyword">for</span> i<span class="token punctuation">,</span> v <span class="token operator">:=</span> <span class="token keyword">range</span> arr4 <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Print</span><span class="token punctuation">(</span>i<span class="token punctuation">,</span> <span class="token string">" "</span><span class="token punctuation">)</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>v<span class="token punctuation">,</span> <span class="token string">" "</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">""</span><span class="token punctuation">)</span>

<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">SetValueByArray</span><span class="token punctuation">(</span>arr <span class="token punctuation">[</span><span class="token number">5</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	arr<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token number">100</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">SetValueBySlice</span><span class="token punctuation">(</span>slice <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	slice<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token number">100</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">SliceDemo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token comment">//1  一般声明方式</span>
	<span class="token keyword">var</span> slice1 <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span> <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">,</span> <span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>slice1<span class="token punctuation">)</span>
	<span class="token comment">//2  基于数组创建切片</span>
	arr <span class="token operator">:=</span> <span class="token punctuation">[</span><span class="token operator">...</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">,</span> <span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">}</span> <span class="token comment">//值类型</span>
	slice2 <span class="token operator">:=</span> arr<span class="token punctuation">[</span><span class="token punctuation">:</span><span class="token punctuation">]</span>               <span class="token comment">//引用类型，左闭右开</span>

	<span class="token comment">//slice2 := arr[:]</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>arr<span class="token punctuation">,</span> slice2<span class="token punctuation">)</span>
	<span class="token comment">//3  基于切片创建切片</span>
	slice3 <span class="token operator">:=</span> slice2<span class="token punctuation">[</span><span class="token punctuation">:</span><span class="token punctuation">]</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>slice3<span class="token punctuation">)</span>
	arr<span class="token punctuation">[</span><span class="token number">1</span><span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token number">20</span>
	slice3<span class="token punctuation">[</span><span class="token number">2</span><span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token number">100</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>arr<span class="token punctuation">,</span> slice2<span class="token punctuation">,</span> slice3<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>slice3<span class="token punctuation">[</span><span class="token number">4</span><span class="token punctuation">]</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>arr<span class="token punctuation">[</span><span class="token number">4</span><span class="token punctuation">]</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>arr<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>slice3<span class="token punctuation">)</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"arr = "</span><span class="token punctuation">,</span> arr<span class="token punctuation">)</span>
	<span class="token comment">//4  使用 make 创建切片</span>
	slice4 <span class="token operator">:=</span> <span class="token function">make</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">,</span> <span class="token number">10</span><span class="token punctuation">)</span>
	slice5 <span class="token operator">:=</span> <span class="token function">make</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">,</span> <span class="token number">10</span><span class="token punctuation">)</span>
	slice4 <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">,</span> <span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">}</span>
	<span class="token comment">//slice5 = []int{1, 2, 3, 4, 5}</span>
	<span class="token comment">//slice4[6] = 6</span>
	<span class="token comment">//申请新内存</span>
	<span class="token comment">//复制数据</span>
	<span class="token comment">//删除旧内存</span>
	<span class="token comment">//slice5[4] = 6</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>slice4<span class="token punctuation">,</span> <span class="token function">len</span><span class="token punctuation">(</span>slice4<span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token function">cap</span><span class="token punctuation">(</span>slice4<span class="token punctuation">)</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>slice5<span class="token punctuation">,</span> <span class="token function">len</span><span class="token punctuation">(</span>slice4<span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token function">cap</span><span class="token punctuation">(</span>slice5<span class="token punctuation">)</span><span class="token punctuation">)</span>
	<span class="token comment">//5  追加元素</span>
	slice4 <span class="token operator">=</span> <span class="token function">append</span><span class="token punctuation">(</span>slice4<span class="token punctuation">,</span> <span class="token number">10</span><span class="token punctuation">,</span> <span class="token number">20</span><span class="token punctuation">,</span> <span class="token number">30</span><span class="token punctuation">)</span>
	slice5 <span class="token operator">=</span> <span class="token function">append</span><span class="token punctuation">(</span>slice5<span class="token punctuation">,</span> <span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">)</span>
	slice5 <span class="token operator">=</span> <span class="token function">append</span><span class="token punctuation">(</span>slice4<span class="token punctuation">,</span> slice5<span class="token operator">...</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>slice4<span class="token punctuation">,</span> <span class="token function">len</span><span class="token punctuation">(</span>slice4<span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token function">cap</span><span class="token punctuation">(</span>slice4<span class="token punctuation">)</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>slice5<span class="token punctuation">,</span> <span class="token function">len</span><span class="token punctuation">(</span>slice4<span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token function">cap</span><span class="token punctuation">(</span>slice5<span class="token punctuation">)</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token boolean">nil</span><span class="token punctuation">)</span>

	<span class="token comment">//6  切片复制</span>
	slice6 <span class="token operator">:=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">10</span><span class="token punctuation">,</span> <span class="token number">20</span><span class="token punctuation">,</span> <span class="token number">30</span><span class="token punctuation">}</span>
	slice7 <span class="token operator">:=</span> <span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">3</span><span class="token punctuation">,</span> <span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">}</span>
	<span class="token comment">//copy(slice6, slice7)//多放少，有多少放多少、把7复制给6之后，有多少放多少，后面的就不放了。</span>
	<span class="token function">copy</span><span class="token punctuation">(</span>slice7<span class="token punctuation">,</span> slice6<span class="token punctuation">)</span> <span class="token comment">//少放多，有多少放多少、后面的就不变。</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>slice7<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">mapDemo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token comment">//1  声明的一般语法</span>
	<span class="token keyword">var</span> map1 <span class="token keyword">map</span><span class="token punctuation">[</span><span class="token builtin">string</span><span class="token punctuation">]</span><span class="token builtin">int</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>map1<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>map1 <span class="token operator">==</span> <span class="token boolean">nil</span><span class="token punctuation">)</span>
	<span class="token comment">//map1["str1"] = 10//不允许</span>

	<span class="token comment">//2  创建映射</span>
	map1 <span class="token operator">=</span> <span class="token function">make</span><span class="token punctuation">(</span><span class="token keyword">map</span><span class="token punctuation">[</span><span class="token builtin">string</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">,</span> <span class="token number">10</span><span class="token punctuation">)</span>
	map1<span class="token punctuation">[</span><span class="token string">"str1"</span><span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token number">10</span>
	map1<span class="token punctuation">[</span><span class="token string">"str2"</span><span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token number">20</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>map1<span class="token punctuation">)</span>

	<span class="token comment">//3  简短声明,并初始化</span>
	map2 <span class="token operator">:=</span> <span class="token keyword">map</span><span class="token punctuation">[</span><span class="token builtin">string</span><span class="token punctuation">]</span><span class="token builtin">int</span><span class="token punctuation">{<!-- --></span><span class="token string">"str1"</span><span class="token punctuation">:</span> <span class="token number">10</span><span class="token punctuation">,</span> <span class="token string">"str2"</span><span class="token punctuation">:</span> <span class="token number">20</span><span class="token punctuation">,</span> <span class="token string">"str3"</span><span class="token punctuation">:</span> <span class="token number">30</span><span class="token punctuation">}</span>
	map2<span class="token punctuation">[</span><span class="token string">"str4"</span><span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token number">40</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>map2<span class="token punctuation">)</span>
	<span class="token comment">//4  删除元素</span>
	<span class="token function">delete</span><span class="token punctuation">(</span>map2<span class="token punctuation">,</span> <span class="token string">"str4"</span><span class="token punctuation">)</span>
	<span class="token function">delete</span><span class="token punctuation">(</span>map2<span class="token punctuation">,</span> <span class="token string">"str4"</span><span class="token punctuation">)</span> <span class="token comment">//删除一个不存在的元素不会导致错误</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>map2<span class="token punctuation">)</span>
	<span class="token comment">//5  使用元素</span>
	<span class="token keyword">if</span> v<span class="token punctuation">,</span> ok <span class="token operator">:=</span> map2<span class="token punctuation">[</span><span class="token string">"str3"</span><span class="token punctuation">]</span><span class="token punctuation">;</span> ok <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>v<span class="token punctuation">)</span>
	<span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">" 不存在该值"</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>

	<span class="token comment">//6  遍历映射</span>
	<span class="token keyword">for</span> k<span class="token punctuation">,</span> v <span class="token operator">:=</span> <span class="token keyword">range</span> map2 <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>k<span class="token punctuation">,</span> v<span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
	<span class="token comment">//不能对映射取地址。</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>map2<span class="token punctuation">[</span><span class="token string">"str1"</span><span class="token punctuation">]</span> <span class="token comment">/*, &amp;map2["str1"]*/</span><span class="token punctuation">)</span>

<span class="token punctuation">}</span>

<span class="token comment">//五、函数的演示</span>
<span class="token comment">// 1  一般函数的演示</span>
<span class="token keyword">func</span> <span class="token function">Max</span><span class="token punctuation">(</span>a<span class="token punctuation">,</span> b <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">(</span><span class="token builtin">int</span><span class="token punctuation">,</span> <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">if</span> a <span class="token operator">&gt;</span> b <span class="token punctuation">{<!-- --></span>
		<span class="token keyword">return</span> a<span class="token punctuation">,</span> b
	<span class="token punctuation">}</span>

	<span class="token keyword">return</span> b<span class="token punctuation">,</span> a
<span class="token punctuation">}</span>

<span class="token comment">//2  可变参数的函数</span>
<span class="token keyword">func</span> <span class="token function">Sum</span><span class="token punctuation">(</span>nums <span class="token operator">...</span><span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token builtin">int</span> <span class="token punctuation">{<!-- --></span>
	total <span class="token operator">:=</span> <span class="token number">0</span>
	<span class="token keyword">for</span> <span class="token boolean">_</span><span class="token punctuation">,</span> v <span class="token operator">:=</span> <span class="token keyword">range</span> nums <span class="token punctuation">{<!-- --></span>
		total <span class="token operator">+=</span> v
	<span class="token punctuation">}</span>
	<span class="token keyword">return</span> total
<span class="token punctuation">}</span>

<span class="token comment">//3  多返回值</span>
<span class="token keyword">func</span> <span class="token function">AddSum</span><span class="token punctuation">(</span>a<span class="token punctuation">,</span> b <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">(</span><span class="token builtin">int</span><span class="token punctuation">,</span> <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">return</span> a <span class="token operator">+</span> b<span class="token punctuation">,</span> a <span class="token operator">-</span> b

<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">AddSum1</span><span class="token punctuation">(</span>a<span class="token punctuation">,</span> b <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">(</span>add <span class="token builtin">int</span><span class="token punctuation">,</span> sub <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	add <span class="token operator">=</span> a <span class="token operator">+</span> b
	sub <span class="token operator">=</span> a <span class="token operator">-</span> b
	<span class="token keyword">return</span> add<span class="token punctuation">,</span> sub
<span class="token punctuation">}</span>

<span class="token comment">//4  使用递归实现阶乘</span>
<span class="token keyword">func</span> <span class="token function">Factorial</span><span class="token punctuation">(</span>num <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token builtin">int</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">if</span> num <span class="token operator">&lt;=</span> <span class="token number">1</span> <span class="token punctuation">{<!-- --></span>
		<span class="token keyword">return</span> <span class="token number">1</span>
	<span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
		<span class="token keyword">return</span> num <span class="token operator">*</span> <span class="token function">Factorial</span><span class="token punctuation">(</span>num<span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">Fibonacci</span><span class="token punctuation">(</span>num <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token builtin">int</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">if</span> num <span class="token operator">&lt;=</span> <span class="token number">2</span> <span class="token punctuation">{<!-- --></span>
		<span class="token keyword">return</span> <span class="token number">1</span>
	<span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
		<span class="token keyword">return</span> <span class="token function">Fibonacci</span><span class="token punctuation">(</span>num<span class="token operator">-</span><span class="token number">2</span><span class="token punctuation">)</span> <span class="token operator">+</span> <span class="token function">Fibonacci</span><span class="token punctuation">(</span>num<span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
<span class="token punctuation">}</span>


<span class="token keyword">func</span> <span class="token function">main</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>

	<span class="token keyword">var</span> num <span class="token builtin">int</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"这是一个求斐波那契数列的函数"</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"请输入您希望显示的斐波那契数列数量："</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Scan</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>num<span class="token punctuation">)</span>
	t1 <span class="token operator">:=</span> time<span class="token punctuation">.</span><span class="token function">Now</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token function">Fibonacci1</span><span class="token punctuation">(</span>num<span class="token punctuation">)</span><span class="token punctuation">)</span>
	elapsed <span class="token operator">:=</span> time<span class="token punctuation">.</span><span class="token function">Since</span><span class="token punctuation">(</span>t1<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"App elapsed:"</span><span class="token punctuation">,</span> elapsed<span class="token punctuation">)</span>
	<span class="token comment">//fmt.Println(Factorial(1))</span>

	<span class="token comment">//函数的多返回值演示</span>
	<span class="token comment">//fmt.Println(AddSum(5, 3))</span>

	<span class="token comment">//可变参数的函数演示</span>
	<span class="token comment">//	fmt.Println(Sum(1, 2, 3, 4, 5))</span>
	<span class="token comment">//	fmt.Println(Sum(1, 2, 3, 4, 5, 6, 7, 8, 9))</span>
	<span class="token comment">//	slice := []int{1, 23, 4, 5}</span>
	<span class="token comment">//	fmt.Println(Sum(slice...)) //打散</span>

	<span class="token comment">//一般函数演示</span>
	<span class="token comment">//fmt.Println(Max(10, 5))</span>
	<span class="token comment">//mapDemo()</span>
	<span class="token comment">//SliceDemo()</span>
	<span class="token comment">//	arr := [...]int{1, 2, 3, 4, 5}</span>
	<span class="token comment">//	//slice := arr[:]</span>
	<span class="token comment">//	//	SetValueByArray(arr) //数组是值传递,所以数据不变</span>
	<span class="token comment">//	//SetValueBySlice(slice)</span>
	<span class="token comment">//	SetValueBySlice(arr[:])</span>
	<span class="token comment">//	fmt.Println(arr)</span>
	<span class="token comment">//	//ArrayDemo()</span>
	<span class="token comment">//continueDemo()</span>
	<span class="token comment">//	fmt.Println(Sunday)</span>
	<span class="token comment">//	fmt.Println(Monday)</span>

	<span class="token comment">//manyValue()</span>
	<span class="token comment">//forDemo()</span>
	<span class="token comment">//switchDemo2()</span>
	<span class="token comment">//switchDemo()</span>
	<span class="token comment">//IO()</span>
	<span class="token comment">/*
		var age Age = 18
		fmt.Println(age)

		var s Score = 100
		fmt.Println(s)

		var i int = 80
		fmt.Println(i)
		//type 定义类型，意味着Age 和 Score 是两个新的类型，虽然内存结构相同
		//但是不能直接相互复制，需要强制转换类型（值）
		//"一人(一个基础类型)千面(多个概念)"
		age = Age(i) //需要赋值时需要强制类型转换
		fmt.Println(age)
		s.Info()
		Score(i).Info() //调用函数也是需要强制类型转换
	*/</span>

<span class="token punctuation">}</span>

</code></pre>
                
{% endraw %}
