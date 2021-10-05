---
title: go语言学习第三天
date: 2018-10-11 10:55:32
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/83009230)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <pre><code class="prism language-go"><span class="token comment">// day03</span>
<span class="token keyword">package</span> main

<span class="token keyword">import</span> <span class="token punctuation">(</span>
	<span class="token string">"fmt"</span>
<span class="token punctuation">)</span>

<span class="token comment">//defer</span>
<span class="token comment">//  3 4 2 1（</span>
<span class="token comment">//  延迟执行-----先进后出</span>
<span class="token keyword">func</span> <span class="token function">defer1</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">defer</span> fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"1"</span><span class="token punctuation">)</span> <span class="token comment">//延迟执行的函数</span>
	<span class="token keyword">defer</span> fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"2"</span><span class="token punctuation">)</span> <span class="token comment">//延迟执行的函数</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"3"</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"4"</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//defer 后的函数使用变量的情况</span>
<span class="token keyword">func</span> <span class="token function">defer2</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">var</span> a <span class="token builtin">int</span> <span class="token operator">=</span> <span class="token number">10</span>
	<span class="token keyword">defer</span> fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>a<span class="token punctuation">)</span> <span class="token comment">//10 延迟执行——虽然延迟执行，但在编译的时候就已经确定了。</span>
	a<span class="token operator">++</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>a<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//defer   调用的函数参数的值在defer 被定义时就确定了</span>
<span class="token comment">//而defer  函数内部所使用的变量的值是在这个函数执行的时候才确定。</span>

<span class="token keyword">func</span> <span class="token function">defer3</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">var</span> a <span class="token builtin">int</span> <span class="token operator">=</span> <span class="token number">10</span>
	<span class="token keyword">defer</span> <span class="token keyword">func</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">//延迟执行</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>a<span class="token punctuation">)</span> <span class="token comment">// 11</span>
	<span class="token punctuation">}</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	a<span class="token operator">++</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>a<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//defer 函数调用的执行时机是外层函数设置返回值之后，并且在即将返回之前。</span>
<span class="token keyword">func</span> <span class="token function">double</span><span class="token punctuation">(</span>x <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token builtin">int</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">return</span> x <span class="token operator">+</span> x
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">triple</span><span class="token punctuation">(</span>x <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">(</span>r <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">defer</span> <span class="token keyword">func</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
		r <span class="token operator">+=</span> x
	<span class="token punctuation">}</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	<span class="token keyword">return</span> <span class="token function">double</span><span class="token punctuation">(</span>x<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//panic 和recover 函数的演示</span>
<span class="token keyword">func</span> <span class="token function">foo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">defer</span> <span class="token keyword">func</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"deferfunc_start"</span><span class="token punctuation">)</span>
		<span class="token comment">//程序从异常中恢复。</span>
		<span class="token keyword">if</span> err <span class="token operator">:=</span> <span class="token function">recover</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span> err <span class="token operator">!=</span> <span class="token boolean">nil</span> <span class="token punctuation">{<!-- --></span>
			fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span>
		<span class="token punctuation">}</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"deferfunc_end"</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"foo.start"</span><span class="token punctuation">)</span>
	<span class="token function">panic</span><span class="token punctuation">(</span><span class="token string">"foo 函数中产生的异常"</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"foo.end"</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//1  结构体的声明</span>
<span class="token keyword">type</span> Person <span class="token keyword">struct</span> <span class="token punctuation">{<!-- --></span>
	Name <span class="token builtin">string</span>
	Age  <span class="token builtin">int</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">structDemo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token comment">//结构体的定义和初始化的三种方法</span>
	p1 <span class="token operator">:=</span> Person<span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span>
	p1<span class="token punctuation">.</span>Name <span class="token operator">=</span> <span class="token string">"张三"</span>
	p1<span class="token punctuation">.</span>Age <span class="token operator">=</span> <span class="token number">18</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>p1<span class="token punctuation">)</span>
	p2 <span class="token operator">:=</span> Person<span class="token punctuation">{<!-- --></span><span class="token string">"李四"</span><span class="token punctuation">,</span> <span class="token number">20</span><span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>p2<span class="token punctuation">)</span>
	p3 <span class="token operator">:=</span> Person<span class="token punctuation">{<!-- --></span>Age<span class="token punctuation">:</span> <span class="token number">25</span><span class="token punctuation">,</span> Name<span class="token punctuation">:</span> <span class="token string">"王五"</span><span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>p3<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//2  匿名组合（实现继承）</span>
<span class="token keyword">type</span> Student <span class="token keyword">struct</span> <span class="token punctuation">{<!-- --></span>
	Person
	Major <span class="token builtin">string</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">Inherit</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	s1 <span class="token operator">:=</span> Student<span class="token punctuation">{<!-- --></span>Person<span class="token punctuation">{<!-- --></span><span class="token string">"张飞"</span><span class="token punctuation">,</span> <span class="token number">18</span><span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token string">"计算机应用"</span><span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>s1<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>s1<span class="token punctuation">.</span>Name<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>s1<span class="token punctuation">.</span>Person<span class="token punctuation">.</span>Name<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>s1<span class="token punctuation">.</span>Age<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>s1<span class="token punctuation">.</span>Major<span class="token punctuation">)</span>
	<span class="token comment">//3  匿名组合的重名问题</span>
	<span class="token comment">//	s2 := Student{Person{"张飞", 18}, "计算机应用", "李四"}</span>
	<span class="token comment">//fmt.Println(s2)</span>
<span class="token punctuation">}</span>

<span class="token comment">//3  匿名组合的重名问题</span>
<span class="token keyword">type</span> Base1 <span class="token keyword">struct</span> <span class="token punctuation">{<!-- --></span>
	Name <span class="token builtin">string</span>
<span class="token punctuation">}</span>
<span class="token keyword">type</span> Base2 <span class="token keyword">struct</span> <span class="token punctuation">{<!-- --></span>
	Name <span class="token builtin">string</span>
<span class="token punctuation">}</span>

<span class="token comment">//Child 继承了Base1和Base2</span>
<span class="token keyword">type</span> Child <span class="token keyword">struct</span> <span class="token punctuation">{<!-- --></span>
	Base1
	<span class="token operator">*</span>Base2
	Name <span class="token builtin">string</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">ManyInherit</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	c1 <span class="token operator">:=</span> Child<span class="token punctuation">{<!-- --></span>Base1<span class="token punctuation">{<!-- --></span><span class="token string">"base1"</span><span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token operator">&amp;</span>Base2<span class="token punctuation">{<!-- --></span><span class="token string">"base2"</span><span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token string">"child"</span><span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>c1<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>c1<span class="token punctuation">.</span>Name<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>c1<span class="token punctuation">.</span>Base1<span class="token punctuation">.</span>Name<span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>c1<span class="token punctuation">.</span>Base2<span class="token punctuation">.</span>Name<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//4  匿名结构体</span>

<span class="token keyword">func</span> <span class="token function">AnonymousStruct</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	s <span class="token operator">:=</span> <span class="token keyword">struct</span> <span class="token punctuation">{<!-- --></span>
		Name <span class="token builtin">string</span>
		Age  <span class="token builtin">int</span>
	<span class="token punctuation">}</span><span class="token punctuation">{<!-- --></span>
		<span class="token string">"张三"</span><span class="token punctuation">,</span>
		<span class="token number">18</span><span class="token punctuation">,</span>
	<span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>s<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//5  空结构体</span>

<span class="token keyword">func</span> <span class="token function">EmptyStruct</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	empty <span class="token operator">:=</span> <span class="token keyword">struct</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>empty<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//   方法：</span>
<span class="token comment">//1  66行，为Person 这个类型增加方法，接收器为类型Person,</span>
<span class="token comment">// this Person  这个就是接收器</span>
<span class="token keyword">func</span> <span class="token punctuation">(</span>this Person<span class="token punctuation">)</span> <span class="token function">ShowInfo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	fmt<span class="token punctuation">.</span><span class="token function">Printf</span><span class="token punctuation">(</span><span class="token string">"姓名：%s\n年龄：%d\n"</span><span class="token punctuation">,</span> this<span class="token punctuation">.</span>Name<span class="token punctuation">,</span> this<span class="token punctuation">.</span>Age<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">WayDemo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	p1 <span class="token operator">:=</span> Person<span class="token punctuation">{<!-- --></span><span class="token string">"张三"</span><span class="token punctuation">,</span> <span class="token number">18</span><span class="token punctuation">}</span>
	p1<span class="token punctuation">.</span><span class="token function">ShowInfo</span><span class="token punctuation">(</span><span class="token punctuation">)</span>

	<span class="token comment">//2类型指针作为接收器演示</span>
	p1<span class="token punctuation">.</span><span class="token function">SetName</span><span class="token punctuation">(</span><span class="token string">" 张三丰"</span><span class="token punctuation">)</span>
	p1<span class="token punctuation">.</span><span class="token function">SetAge</span><span class="token punctuation">(</span><span class="token number">100</span><span class="token punctuation">)</span>
	p1<span class="token punctuation">.</span><span class="token function">ShowInfo</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//2  类型指针作为接收器。引用传递才可以修改引用对象的值。</span>
<span class="token keyword">func</span> <span class="token punctuation">(</span>p <span class="token operator">*</span>Person<span class="token punctuation">)</span> <span class="token function">SetName</span><span class="token punctuation">(</span>name <span class="token builtin">string</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	p<span class="token punctuation">.</span>Name <span class="token operator">=</span> name
	<span class="token comment">//等价于(*p).Name = name</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token punctuation">(</span>this <span class="token operator">*</span>Person<span class="token punctuation">)</span> <span class="token function">SetAge</span><span class="token punctuation">(</span>age <span class="token builtin">int</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	this<span class="token punctuation">.</span>Age <span class="token operator">=</span> age
<span class="token punctuation">}</span>

<span class="token comment">//对子类进行添加方法</span>
<span class="token comment">//3  接收器是类型指针</span>

<span class="token keyword">func</span> <span class="token punctuation">(</span>ps <span class="token operator">*</span>Student<span class="token punctuation">)</span> <span class="token function">SetMajor</span><span class="token punctuation">(</span>major <span class="token builtin">string</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	ps<span class="token punctuation">.</span>Major <span class="token operator">=</span> major
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token punctuation">(</span>s Student<span class="token punctuation">)</span> <span class="token function">ShowInfo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	fmt<span class="token punctuation">.</span><span class="token function">Printf</span><span class="token punctuation">(</span><span class="token string">"姓名：%s\n年龄:%d\n专业:%s\n"</span><span class="token punctuation">,</span>
		s<span class="token punctuation">.</span>Name<span class="token punctuation">,</span> s<span class="token punctuation">.</span>Age<span class="token punctuation">,</span> s<span class="token punctuation">.</span>Major<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">StudentTool</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	a1 <span class="token operator">:=</span> Student<span class="token punctuation">{<!-- --></span>Person<span class="token punctuation">{<!-- --></span><span class="token string">"张三"</span><span class="token punctuation">,</span> <span class="token number">18</span><span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token string">"计算机应用"</span><span class="token punctuation">}</span>

	<span class="token comment">//调用Student类型的ShowInfo方法</span>
	a1<span class="token punctuation">.</span><span class="token function">ShowInfo</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	<span class="token comment">//调用Person类型的ShowInfo方法</span>
	a1<span class="token punctuation">.</span>Person<span class="token punctuation">.</span><span class="token function">ShowInfo</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	a1<span class="token punctuation">.</span><span class="token function">SetName</span><span class="token punctuation">(</span><span class="token string">"张三丰"</span><span class="token punctuation">)</span>
	a1<span class="token punctuation">.</span><span class="token function">SetAge</span><span class="token punctuation">(</span><span class="token number">100</span><span class="token punctuation">)</span>
	a1<span class="token punctuation">.</span><span class="token function">SetMajor</span><span class="token punctuation">(</span><span class="token string">"太极拳"</span><span class="token punctuation">)</span>
	a1<span class="token punctuation">.</span><span class="token function">ShowInfo</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">// 4  方法值和方法表达式</span>
<span class="token keyword">type</span> Integer <span class="token builtin">int</span> <span class="token comment">//某个对象</span>

<span class="token keyword">func</span> <span class="token punctuation">(</span>i Integer<span class="token punctuation">)</span> <span class="token function">Add</span><span class="token punctuation">(</span>j Integer<span class="token punctuation">)</span> Integer <span class="token punctuation">{<!-- --></span> <span class="token comment">//某个对象的方法</span>
	<span class="token keyword">return</span> i <span class="token operator">+</span> j
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">Way</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>

	<span class="token keyword">var</span> a Integer
	<span class="token keyword">var</span> b Integer
	<span class="token comment">//对象的方法，称为方法值</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>a<span class="token punctuation">.</span><span class="token function">Add</span><span class="token punctuation">(</span><span class="token number">100</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
	<span class="token comment">//</span>
	add <span class="token operator">:=</span> b<span class="token punctuation">.</span>Add
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token function">add</span><span class="token punctuation">(</span><span class="token number">100</span><span class="token punctuation">)</span><span class="token punctuation">)</span>

	<span class="token comment">//2  类型的方法，称为方法表达式</span>
	add2 <span class="token operator">:=</span> Integer<span class="token punctuation">.</span>Add         <span class="token comment">//类型的方法就是方法表达式</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token function">add2</span><span class="token punctuation">(</span><span class="token number">100</span><span class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token comment">//但第一个参数作为接收器。</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>Integer<span class="token punctuation">.</span><span class="token function">Add</span><span class="token punctuation">(</span><span class="token number">100</span><span class="token punctuation">,</span> <span class="token number">200</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//六</span>
<span class="token comment">//.</span>
<span class="token comment">//接</span>
<span class="token comment">//口</span>
<span class="token comment">//演</span>
<span class="token comment">//示</span>

<span class="token comment">//定义一个接口</span>
<span class="token keyword">type</span> IPhone <span class="token keyword">interface</span> <span class="token punctuation">{<!-- --></span>
	<span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//定义类型实现接口</span>
<span class="token keyword">type</span> DumbPhone <span class="token keyword">struct</span> <span class="token punctuation">{<!-- --></span>
	Name <span class="token builtin">string</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token punctuation">(</span>d DumbPhone<span class="token punctuation">)</span> <span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"使用"</span> <span class="token operator">+</span> d<span class="token punctuation">.</span>Name <span class="token operator">+</span> <span class="token string">"打电话..."</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">InterfaceDemo</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token comment">//1  将一个对象赋值给一个接口</span>
	<span class="token keyword">var</span> phone IPhone             <span class="token comment">//1.定义了一个接口</span>
	phone <span class="token operator">=</span> DumbPhone<span class="token punctuation">{<!-- --></span><span class="token string">"诺基亚非智能机"</span><span class="token punctuation">}</span> <span class="token comment">//2.将一个对象赋值给一个接口</span>
	phone<span class="token punctuation">.</span><span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>                 <span class="token comment">//3.直接使用接口调用函数</span>
	<span class="token comment">//2  将对象地址赋值给一个接口</span>
	pDumbPhone <span class="token operator">:=</span> <span class="token operator">&amp;</span>DumbPhone<span class="token punctuation">{<!-- --></span><span class="token string">"非智能机"</span><span class="token punctuation">}</span>
	pDumbPhone<span class="token punctuation">.</span><span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//  相机接口</span>
<span class="token keyword">type</span> ICamera <span class="token keyword">interface</span> <span class="token punctuation">{<!-- --></span>
	<span class="token function">TakePicture</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">type</span> DigitalCamera <span class="token keyword">struct</span> <span class="token punctuation">{<!-- --></span>
	Name <span class="token builtin">string</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token punctuation">(</span>d DigitalCamera<span class="token punctuation">)</span> <span class="token function">TakePicture</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"使用"</span> <span class="token operator">+</span> d<span class="token punctuation">.</span>Name <span class="token operator">+</span> <span class="token string">"照相"</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">Camera</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">var</span> ic ICamera
	ic <span class="token operator">=</span> <span class="token operator">&amp;</span>DigitalCamera<span class="token punctuation">{<!-- --></span><span class="token string">"佳能数据相机"</span><span class="token punctuation">}</span>
	ic<span class="token punctuation">.</span><span class="token function">TakePicture</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//一个接口赋值给另一个接口</span>

<span class="token keyword">type</span> IPhoneCamera <span class="token keyword">interface</span> <span class="token punctuation">{<!-- --></span>
	IPhone
	ICamera
<span class="token punctuation">}</span>

<span class="token keyword">type</span> ICameraPhone <span class="token keyword">interface</span> <span class="token punctuation">{<!-- --></span>
	<span class="token function">TakePicture</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	<span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token comment">//以上两个接口IPhoneCamera 和 ICameraPhone 是等价的。</span>
<span class="token comment">//方法列表相同（次序可以不同），那么这两个接口可以相互赋值</span>

<span class="token comment">//实现 IPhoneCamera 接口</span>
<span class="token keyword">type</span> SmartPhone <span class="token keyword">struct</span> <span class="token punctuation">{<!-- --></span>
	Name <span class="token builtin">string</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token punctuation">(</span>sp SmartPhone<span class="token punctuation">)</span> <span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"使用"</span> <span class="token operator">+</span> sp<span class="token punctuation">.</span>Name <span class="token operator">+</span> <span class="token string">"打电话..."</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token punctuation">(</span>sp SmartPhone<span class="token punctuation">)</span> <span class="token function">TakePicture</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">" 使用"</span> <span class="token operator">+</span> sp<span class="token punctuation">.</span>Name <span class="token operator">+</span> <span class="token string">"照相..."</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">UseSmartPhone</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">var</span> ipc IPhoneCamera
	ipc <span class="token operator">=</span> <span class="token operator">&amp;</span>SmartPhone<span class="token punctuation">{<!-- --></span><span class="token string">"华为智能机"</span><span class="token punctuation">}</span>
	ipc<span class="token punctuation">.</span><span class="token function">TakePicture</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	ipc<span class="token punctuation">.</span><span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	<span class="token comment">//将一个接口赋值给另一个接口</span>
	<span class="token comment">//两个等价接口的赋值</span>
	<span class="token keyword">var</span> icp ICameraPhone
	icp <span class="token operator">=</span> ipc
	icp<span class="token punctuation">.</span><span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	icp<span class="token punctuation">.</span><span class="token function">TakePicture</span><span class="token punctuation">(</span><span class="token punctuation">)</span>

	<span class="token comment">//由大到小的接口赋值(小接口 = 大接口  父类 = 子类 ）</span>
	<span class="token keyword">var</span> ip IPhone
	ip <span class="token operator">=</span> ipc
	ip<span class="token punctuation">.</span><span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">""</span><span class="token punctuation">)</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>ip<span class="token punctuation">.</span><span class="token punctuation">(</span>ICameraPhone<span class="token punctuation">)</span><span class="token punctuation">)</span>
	<span class="token keyword">if</span> v<span class="token punctuation">,</span> ok <span class="token operator">:=</span> ip<span class="token punctuation">.</span><span class="token punctuation">(</span>ICameraPhone<span class="token punctuation">)</span><span class="token punctuation">;</span> ok <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"-----接口查询-----"</span><span class="token punctuation">)</span>
		v<span class="token punctuation">.</span><span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
		v<span class="token punctuation">.</span><span class="token function">TakePicture</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"-----接口查询-----"</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"ip 接口操作对象没有实现 icp 接口"</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token comment">//空接口演示</span>
<span class="token keyword">func</span> <span class="token function">emptyInterface</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token comment">//使用空接口可以直接接受任何基本类型</span>
	<span class="token keyword">var</span> object <span class="token keyword">interface</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span>
	object <span class="token operator">=</span> <span class="token number">10</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>object<span class="token punctuation">)</span>
	object <span class="token operator">=</span> <span class="token string">"ten"</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>object<span class="token punctuation">)</span>
	object <span class="token operator">=</span> <span class="token number">10.25</span>
	fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span>object<span class="token punctuation">)</span>

	<span class="token comment">//使用空间口接收自定义类型</span>
	sp <span class="token operator">:=</span> SmartPhone<span class="token punctuation">{<!-- --></span><span class="token string">"华为智能机"</span><span class="token punctuation">}</span>
	sp<span class="token punctuation">.</span><span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	object <span class="token operator">=</span> sp
	<span class="token comment">//	object = SmartPhone{"华为智能机"}</span>

	<span class="token keyword">switch</span> v <span class="token operator">:=</span> object<span class="token punctuation">.</span><span class="token punctuation">(</span><span class="token keyword">type</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">//固定写法</span>
	<span class="token keyword">case</span> <span class="token builtin">int</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"int 类型"</span><span class="token punctuation">,</span> v<span class="token punctuation">)</span>
	<span class="token keyword">case</span> <span class="token builtin">string</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"string 类型"</span><span class="token punctuation">,</span> v<span class="token punctuation">)</span>
	<span class="token keyword">case</span> <span class="token builtin">float64</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"float64 类型"</span><span class="token punctuation">,</span> v<span class="token punctuation">)</span>
	<span class="token keyword">case</span> SmartPhone<span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"SmartPhone"</span><span class="token punctuation">,</span> v<span class="token punctuation">)</span>
	<span class="token keyword">default</span><span class="token punctuation">:</span>
		fmt<span class="token punctuation">.</span><span class="token function">Println</span><span class="token punctuation">(</span><span class="token string">"未知类型"</span><span class="token punctuation">,</span> v<span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
<span class="token punctuation">}</span>

<span class="token comment">//使用空接口作为函数的参数</span>
<span class="token keyword">func</span> <span class="token function">CallWithInterface</span><span class="token punctuation">(</span>i <span class="token keyword">interface</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token keyword">if</span> v<span class="token punctuation">,</span> ok <span class="token operator">:=</span> i<span class="token punctuation">.</span><span class="token punctuation">(</span>IPhone<span class="token punctuation">)</span><span class="token punctuation">;</span> ok <span class="token punctuation">{<!-- --></span>
		v<span class="token punctuation">.</span><span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
	<span class="token keyword">if</span> v<span class="token punctuation">,</span> ok <span class="token operator">:=</span> i<span class="token punctuation">.</span><span class="token punctuation">(</span>ICamera<span class="token punctuation">)</span><span class="token punctuation">;</span> ok <span class="token punctuation">{<!-- --></span>
		v<span class="token punctuation">.</span><span class="token function">TakePicture</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	<span class="token punctuation">}</span>
	<span class="token comment">//switch v:=i.(type)</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	phone <span class="token operator">:=</span> DumbPhone<span class="token punctuation">{<!-- --></span><span class="token string">"诺基亚"</span><span class="token punctuation">}</span>
	<span class="token function">CallWithInterface</span><span class="token punctuation">(</span>phone<span class="token punctuation">)</span>
	camera <span class="token operator">:=</span> DigitalCamera<span class="token punctuation">{<!-- --></span><span class="token string">"佳能"</span><span class="token punctuation">}</span>
	<span class="token function">CallWithInterface</span><span class="token punctuation">(</span>camera<span class="token punctuation">)</span>
<span class="token punctuation">}</span>

<span class="token keyword">func</span> <span class="token function">main</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
	<span class="token function">Call</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	<span class="token comment">//	emptyInterface()</span>
	<span class="token comment">//	UseSmartPhone()</span>
	<span class="token comment">//	Camera()</span>
	<span class="token comment">//	InterfaceDemo()</span>
	<span class="token comment">//	方法值和方法表达式</span>
	<span class="token comment">//	Way()</span>
	<span class="token comment">//	StudentTool()</span>
	<span class="token comment">//	WayDemo()</span>
	<span class="token comment">//	EmptyStruct()</span>
	<span class="token comment">//	AnonymousStruct()</span>
	<span class="token comment">//	ManyInherit()</span>
	<span class="token comment">//	Inherit()</span>
	<span class="token comment">//	structDemo()</span>
	<span class="token comment">//	fmt.Println(" 程序开始执行...")</span>
	<span class="token comment">//	foo()</span>
	<span class="token comment">//	fmt.Println(" 主程序执行中...")</span>
	<span class="token comment">//	fmt.Println(" 程序执行结束...")</span>
	<span class="token comment">//	fmt.Println(triple(3))	//defer3()</span>
	<span class="token comment">//	defer2()</span>
	<span class="token comment">//	defer1()</span>

<span class="token punctuation">}</span>
</code></pre>
                
{% endraw %}
