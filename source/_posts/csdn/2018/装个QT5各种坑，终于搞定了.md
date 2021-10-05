---
title: 装个QT5各种坑，终于搞定了
date: 2018-08-30 09:12:12
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/82215835)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>转：https://blog.csdn.net/u013934107/article/details/80712418</p> 
<div id="content_views" class="htmledit_views"> 
 <p><br></p> 
 <p>&nbsp;&nbsp;<br>1、下载 Qt5 离线安装包</p> 
 <p>下载地址：<a href="http://www.qt.io/download-open-source/">http://www.qt.io/download-open-source/</a>&nbsp;<br>进入后，请注意页面最下方有个【View All Downloads】链接，点击它可找到离线安装包！&nbsp;<br><img src="https://img-blog.csdn.net/20151004135512998" alt="这里写图片描述" title=""></p> 
 <p>根据自己的操作系统版本，选择对应的安装包：&nbsp;<br><img src="https://img-blog.csdn.net/20151004135553245" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>2、添加执行权限</p> 
 <p>下载完成后，得到离线安装包，打开【终端】，进入离线安装包所在的目录，然后执行命令：</p> 
 <pre class="prettyprint"><code class="hljs lasso has-numbering apache"><span class="hljs-attribute">sudo</span> chmod <span class="hljs-subst">+</span>x qt<span class="hljs-attribute">-opensource</span><span class="hljs-attribute">-linux</span><span class="hljs-attribute">-x<span class="hljs-number">86</span></span><span class="hljs-subst">-</span><span class="hljs-number"><span class="hljs-number">5</span>.<span class="hljs-number">4</span></span><span class="hljs-number">.<span class="hljs-number">1</span></span><span class="hljs-built_in">.</span>run</code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p><img src="https://img-blog.csdn.net/20151004135725259" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>3、开始安装</p> 
 <p>添加执行权限后，可以开始安装Qt5，在步骤2的基础上，继续运行命令：</p> 
 <pre class="prettyprint"><code class="hljs lasso has-numbering apache"><span class="hljs-attribute">sudo</span> <span class="hljs-built_in">.</span>/qt<span class="hljs-attribute">-opensource</span><span class="hljs-attribute">-linux</span><span class="hljs-attribute">-x<span class="hljs-number">86</span></span><span class="hljs-subst">-</span><span class="hljs-number"><span class="hljs-number">5</span>.<span class="hljs-number">4</span></span><span class="hljs-number">.<span class="hljs-number">1</span></span><span class="hljs-built_in">.</span>run</code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p>可见如下窗口：&nbsp;<br><img src="https://img-blog.csdn.net/20151004135856181" alt="这里写图片描述" title=""></p> 
 <p>接下来按照编号指示的步骤依次操作：&nbsp;<br><img src="https://img-blog.csdn.net/20151004135956700" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140010808" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140021329" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140031610" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140040896" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>4、配置环境变量</p> 
 <p>在【终端】中执行如下命令：</p> 
 <pre class="prettyprint"><code class="hljs bash has-numbering"><span class="hljs-built_in">sudo</span> gedit /etc/profile</code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p>添加如下内容：&nbsp;<br>32位系统：</p> 
 <pre class="prettyprint"><code class="hljs bash has-numbering"></code>
  <ol class="hljs-ln"><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> QTDIR=/opt/Qt5.
      <span class="hljs-number">4.1</span>/
      <span class="hljs-number">5.4</span>
     </div>
    </div></li><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> PATH=
      <span class="hljs-variable"><span class="hljs-variable">$QTDIR</span></span>/gcc/bin:
      <span class="hljs-variable"><span class="hljs-variable">$PATH</span></span>
     </div>
    </div></li><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> LD_LIBRARY_PATH=
      <span class="hljs-variable"><span class="hljs-variable">$QTDIR</span></span>/gcc/lib:
      <span class="hljs-variable"><span class="hljs-variable">$LD_LIBRARY_PATH</span></span>
     </div>
    </div></li></ol>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li><li>2</li><li>3</li></ul> 
 <p>64位系统：</p> 
 <pre class="prettyprint"><code class="hljs bash has-numbering"></code>
  <ol class="hljs-ln"><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> QTDIR=/opt/Qt5.
      <span class="hljs-number">4.1</span>/
      <span class="hljs-number">5.4</span>
     </div>
    </div></li><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> PATH=
      <span class="hljs-variable"><span class="hljs-variable">$QTDIR</span></span>/gcc_64/bin:
      <span class="hljs-variable"><span class="hljs-variable">$PATH</span></span>
     </div>
    </div></li><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> LD_LIBRARY_PATH=
      <span class="hljs-variable"><span class="hljs-variable">$QTDIR</span></span>/gcc_64/lib:
      <span class="hljs-variable"><span class="hljs-variable">$LD_LIBRARY_PATH</span></span>
     </div>
    </div></li></ol>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li><li>2</li><li>3</li></ul> 
 <p>上面的路径，请自己对照所安装的版本更改！</p> 
 <p>保存退出，&nbsp;<br>执行命令：<code>source /etc/profile</code>&nbsp;<br>让环境变量生效！</p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>5、验证是否安装成功</p> 
 <p>终端下执行命令：<code>qmake -version</code></p> 
 <p>如果出现如下信息，表示配置安装成功：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140315305" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>6、测试实例</p> 
 <p>打开Qt Creator，点击New Project，创建一个新项目：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140359280" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140422767" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140439353" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140455572" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140513861" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140540636" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>7、解决错误</p> 
 <p>当尝试运行时，会有错误出现：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140621755" alt="这里写图片描述" title=""></p> 
 <p>根据错误提示，我们打开如下的界面：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140648941" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140715837" alt="这里写图片描述" title=""></p> 
 <p>出现上述错误是因为我们没有安装可用的g++编译器（基本上所有的linux发行版都自带安装了gcc编译器），在终端中执行如下命令：</p> 
 <pre class="prettyprint"><code class="hljs bash has-numbering"><span class="hljs-built_in">sudo</span> apt-get install g++</code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p>安装完成后，重新打开Qt Creator，可以发现已经找到编译器了：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140753453" alt="这里写图片描述" title=""></p> 
 <p>再编译一次：&nbsp;<br><img src="https://img-blog.csdn.net/20151004140822516" alt="这里写图片描述" title=""></p> 
 <p>会发现报如下的错误：&nbsp;<br><img src="https://img-blog.csdn.net/20151004140843238" alt="这里写图片描述" title=""></p> 
 <p>这是因为没有安装GL库，终端下执行命令：</p> 
 <pre class="prettyprint"><code class="hljs lasso has-numbering sql">sudo apt<span class="hljs-attribute">-get</span> <span class="hljs-keyword">install</span> libgl1<span class="hljs-attribute">-mesa</span><span class="hljs-attribute">-dev</span></code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p>安装完成后，再次编译，应该就能成功了！</p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>8、安装完成&nbsp;<br>经过上面的步骤，应该能成功编译并运行程序了，整个安装过程结束！</p> 
 <p><img src="https://img-blog.csdn.net/20151004140929100" alt="这里写图片描述" title=""></p> 
</div>
<div id="content_views" class="htmledit_views"> 
 <p><br></p> 
 <p>&nbsp;&nbsp;<br>1、下载 Qt5 离线安装包</p> 
 <p>下载地址：<a href="http://www.qt.io/download-open-source/">http://www.qt.io/download-open-source/</a>&nbsp;<br>进入后，请注意页面最下方有个【View All Downloads】链接，点击它可找到离线安装包！&nbsp;<br><img src="https://img-blog.csdn.net/20151004135512998" alt="这里写图片描述" title=""></p> 
 <p>根据自己的操作系统版本，选择对应的安装包：&nbsp;<br><img src="https://img-blog.csdn.net/20151004135553245" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>2、添加执行权限</p> 
 <p>下载完成后，得到离线安装包，打开【终端】，进入离线安装包所在的目录，然后执行命令：</p> 
 <pre class="prettyprint"><code class="hljs lasso has-numbering apache"><span class="hljs-attribute">sudo</span> chmod <span class="hljs-subst">+</span>x qt<span class="hljs-attribute">-opensource</span><span class="hljs-attribute">-linux</span><span class="hljs-attribute">-x<span class="hljs-number">86</span></span><span class="hljs-subst">-</span><span class="hljs-number"><span class="hljs-number">5</span>.<span class="hljs-number">4</span></span><span class="hljs-number">.<span class="hljs-number">1</span></span><span class="hljs-built_in">.</span>run</code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p><img src="https://img-blog.csdn.net/20151004135725259" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>3、开始安装</p> 
 <p>添加执行权限后，可以开始安装Qt5，在步骤2的基础上，继续运行命令：</p> 
 <pre class="prettyprint"><code class="hljs lasso has-numbering apache"><span class="hljs-attribute">sudo</span> <span class="hljs-built_in">.</span>/qt<span class="hljs-attribute">-opensource</span><span class="hljs-attribute">-linux</span><span class="hljs-attribute">-x<span class="hljs-number">86</span></span><span class="hljs-subst">-</span><span class="hljs-number"><span class="hljs-number">5</span>.<span class="hljs-number">4</span></span><span class="hljs-number">.<span class="hljs-number">1</span></span><span class="hljs-built_in">.</span>run</code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p>可见如下窗口：&nbsp;<br><img src="https://img-blog.csdn.net/20151004135856181" alt="这里写图片描述" title=""></p> 
 <p>接下来按照编号指示的步骤依次操作：&nbsp;<br><img src="https://img-blog.csdn.net/20151004135956700" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140010808" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140021329" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140031610" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140040896" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>4、配置环境变量</p> 
 <p>在【终端】中执行如下命令：</p> 
 <pre class="prettyprint"><code class="hljs bash has-numbering"><span class="hljs-built_in">sudo</span> gedit /etc/profile</code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p>添加如下内容：&nbsp;<br>32位系统：</p> 
 <pre class="prettyprint"><code class="hljs bash has-numbering"></code>
  <ol class="hljs-ln"><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> QTDIR=/opt/Qt5.
      <span class="hljs-number">4.1</span>/
      <span class="hljs-number">5.4</span>
     </div>
    </div></li><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> PATH=
      <span class="hljs-variable"><span class="hljs-variable">$QTDIR</span></span>/gcc/bin:
      <span class="hljs-variable"><span class="hljs-variable">$PATH</span></span>
     </div>
    </div></li><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> LD_LIBRARY_PATH=
      <span class="hljs-variable"><span class="hljs-variable">$QTDIR</span></span>/gcc/lib:
      <span class="hljs-variable"><span class="hljs-variable">$LD_LIBRARY_PATH</span></span>
     </div>
    </div></li></ol>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li><li>2</li><li>3</li></ul> 
 <p>64位系统：</p> 
 <pre class="prettyprint"><code class="hljs bash has-numbering"></code>
  <ol class="hljs-ln"><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> QTDIR=/opt/Qt5.
      <span class="hljs-number">4.1</span>/
      <span class="hljs-number">5.4</span>
     </div>
    </div></li><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> PATH=
      <span class="hljs-variable"><span class="hljs-variable">$QTDIR</span></span>/gcc_64/bin:
      <span class="hljs-variable"><span class="hljs-variable">$PATH</span></span>
     </div>
    </div></li><li>
    <div class="hljs-ln-numbers">
     <div class="hljs-ln-line hljs-ln-n"></div>
    </div>
    <div class="hljs-ln-code">
     <div class="hljs-ln-line">
      <span class="hljs-keyword"><span class="hljs-built_in">export</span></span> LD_LIBRARY_PATH=
      <span class="hljs-variable"><span class="hljs-variable">$QTDIR</span></span>/gcc_64/lib:
      <span class="hljs-variable"><span class="hljs-variable">$LD_LIBRARY_PATH</span></span>
     </div>
    </div></li></ol>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li><li>2</li><li>3</li></ul> 
 <p>上面的路径，请自己对照所安装的版本更改！</p> 
 <p>保存退出，&nbsp;<br>执行命令：<code>source /etc/profile</code>&nbsp;<br>让环境变量生效！</p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>5、验证是否安装成功</p> 
 <p>终端下执行命令：<code>qmake -version</code></p> 
 <p>如果出现如下信息，表示配置安装成功：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140315305" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>6、测试实例</p> 
 <p>打开Qt Creator，点击New Project，创建一个新项目：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140359280" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140422767" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140439353" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140455572" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140513861" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140540636" alt="这里写图片描述" title=""></p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>7、解决错误</p> 
 <p>当尝试运行时，会有错误出现：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140621755" alt="这里写图片描述" title=""></p> 
 <p>根据错误提示，我们打开如下的界面：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140648941" alt="这里写图片描述" title=""></p> 
 <p><img src="https://img-blog.csdn.net/20151004140715837" alt="这里写图片描述" title=""></p> 
 <p>出现上述错误是因为我们没有安装可用的g++编译器（基本上所有的linux发行版都自带安装了gcc编译器），在终端中执行如下命令：</p> 
 <pre class="prettyprint"><code class="hljs bash has-numbering"><span class="hljs-built_in">sudo</span> apt-get install g++</code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p>安装完成后，重新打开Qt Creator，可以发现已经找到编译器了：</p> 
 <p><img src="https://img-blog.csdn.net/20151004140753453" alt="这里写图片描述" title=""></p> 
 <p>再编译一次：&nbsp;<br><img src="https://img-blog.csdn.net/20151004140822516" alt="这里写图片描述" title=""></p> 
 <p>会发现报如下的错误：&nbsp;<br><img src="https://img-blog.csdn.net/20151004140843238" alt="这里写图片描述" title=""></p> 
 <p>这是因为没有安装GL库，终端下执行命令：</p> 
 <pre class="prettyprint"><code class="hljs lasso has-numbering sql">sudo apt<span class="hljs-attribute">-get</span> <span class="hljs-keyword">install</span> libgl1<span class="hljs-attribute">-mesa</span><span class="hljs-attribute">-dev</span></code>
  <div class="hljs-button {2}"></div></pre> 
 <ul class="pre-numbering"><li>1</li></ul> 
 <p>安装完成后，再次编译，应该就能成功了！</p> 
 <p>&nbsp;&nbsp;<br>&nbsp;&nbsp;<br>8、安装完成&nbsp;<br>经过上面的步骤，应该能成功编译并运行程序了，整个安装过程结束！</p> 
 <p><img src="https://img-blog.csdn.net/20151004140929100" alt="这里写图片描述" title=""></p> 
</div>
                
{% endraw %}
