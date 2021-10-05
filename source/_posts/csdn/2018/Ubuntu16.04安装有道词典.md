---
title: Ubuntu16.04安装有道词典
date: 2018-08-30 12:23:04
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/82219462)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>转载：<a href="https://blog.csdn.net/dianzishijian/article/details/54025220">https://blog.csdn.net/dianzishijian/article/details/54025220</a></p> 
<p>untu的最新版本是64位的16.04系统，因为要经常阅读英文文献，所以就想安装类似有道之类的翻译词典，具体方法如下：</p> 
<p>1.下载安装包，网址是<a href="http://cidian.youdao.com/index-linux.html">http://cidian.youdao.com/index-linux.html</a> ，博主下载的是64位的；</p> 
<p>2.进入安装包的文件夹，进行安装</p> 
<p>sudo dpkg -i youdao-dict_1.1.0-0-deepin_amd64.deb</p> 
<p>但是，会吃西安问题，安装不成功，报错。这时的解决办法是执行下面指令：</p> 
<p>sudo apt-get -f dist-upgrade</p> 
<p>再来重新安装，</p> 
<p>sudo dpkg -i youdao-dict_1.1.0-0-deepin_amd64.deb</p> 
<p>3.等待安装成功</p> 
<p>4.运行效果</p> 
<p>另外需要注意的是： <br> 源有可能出现问题，出现问题的话要去更新一下源或者更换一下源。</p> 
<p>我用的是ali的源，还比较好用。</p>
                
{% endraw %}
