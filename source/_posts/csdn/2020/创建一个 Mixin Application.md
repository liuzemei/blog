---
title: 创建一个 Mixin Application
date: 2020-02-27 13:58:53
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/104535314)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>读完并如实操作后，您将获得：</p> 
<blockquote> 
 <p>一个 Mixin 机器人应用，及相关的开发信息</p> 
</blockquote> 
<h3><a id="1__3"></a>1. 前期准备</h3> 
<p>Mixin Messenger 手机应用，并成功注册登录。<br> <a href="https://blog.csdn.net/weixin_41884153/article/details/104531281">教程参见</a></p> 
<h3><a id="2__7"></a>2. 开始注册</h3> 
<ol><li>打开链接 <a href="https://developers.mixin.one/dashboard">https://developers.mixin.one/dashboard</a></li><li>如果是第一次打开，那应该就直接跳转扫码登录页面。<br> <img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy82OTYwNzc1LWRjYTA4Zjg3ZTMzODk0NDgucG5n?x-oss-process=image/format,png" alt="扫码登录页"></li><li>使用手机上的 Mixin Messenger App 扫码登录<br> <img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy82OTYwNzc1LTAwZDk5NzQ4YzFjYjA4NTkucG5n?x-oss-process=image/format,png" alt="成功登陆"></li><li>点击左上角新应用<br> <img src="https://img-blog.csdnimg.cn/20200309114952160.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTg4NDE1Mw==,size_16,color_FFFFFF,t_70" alt="新应用"></li></ol> 
<blockquote> 
 <p>这里进行相关介绍</p> 
 <ol><li>名称：机器人的昵称。</li><li>图标：机器人的头像。</li><li>简介：机器人的个人签名。</li><li>首页网址：您机器人点击右下角小猪鼻子进入的页面链接。</li><li>验证网址：使用 mixin.one/oauth/token/xxxxx 用户授权登录后，跳转的携带code的链接。(后边有 Demo 专门讲这个验证网址的使用)</li><li>域名白名单：可以把机器人里的链接直接分享出来一个卡片。如果没有配置的话，从机器人里分享出来的链接就是链接的形式。</li><li>沉浸式：开启之后，整个屏幕状态栏以下的都可以控制了，状态栏也可以控制背景颜色。</li></ol> 
</blockquote> 
<ol start="6"><li> <p>填写完毕点击 保存按钮<br> <img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy82OTYwNzc1LWQyY2MwYjUyY2M5Y2E2OWIucG5n?x-oss-process=image/format,png" alt="点击保存"></p> </li><li> <p>获取应用密钥 和 Session<br> <img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy82OTYwNzc1LWRlZGNhZmM0YjE0ZmYwMDIucG5n?x-oss-process=image/format,png" alt="生成新的密钥和 Session"></p> </li></ol> 
<blockquote> 
 <p>注意 生成新的密钥后要注意留存一下。<br> 在PC端生成新的 Session 。</p> 
</blockquote> 
<ol start="8"><li> <p>点击复制<br> <img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy82OTYwNzc1LTMzMTI3Yjc0Zjc1ZDhmNDUucG5n?x-oss-process=image/format,png" alt="点击Copy"></p> </li><li> <p>生成 keystore-xxxxxx.json 文件的处理<br> <img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy82OTYwNzc1LTllZjQwZTJmN2FhMTBhZjgucG5n?x-oss-process=image/format,png" alt="image.png"></p> </li></ol> 
<p>可以直接在里面添加一个 <code>client_secret</code> 字段，一起保存。如下：<br> <img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy82OTYwNzc1LTJkMmQwNjQzNjMxNDFhNmUucG5n?x-oss-process=image/format,png" alt="最终如上"></p> 
<p>到这里就留存这一份文件就 <code>ok</code> 了。</p>
                
{% endraw %}
