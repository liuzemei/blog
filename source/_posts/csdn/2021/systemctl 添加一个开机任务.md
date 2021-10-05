---
title: systemctl 添加一个开机任务
date: 2021-05-25 13:35:52
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/117254176)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <ol><li>进入工作目录</li></ol> 
<pre><code class="prism language-shell"><span class="token function">cd</span> /lib/systemd/system
</code></pre> 
<ol start="2"><li>在工作目录下，新建一个 <code>new-task.service</code> 任务</li></ol> 
<pre><code class="prism language-shell"><span class="token function">sudo</span> <span class="token function">vi</span> new-task.service
</code></pre> 
<ol start="3"><li>编辑 <code>new-task.service</code></li></ol> 
<pre><code class="prism language-service">[Unit]
Description=New Task
After=network.target

[Service]
User=one
Type=simple
WorkingDirectory=/home/one/xxx
ExecStart=/home/one/xxx/task
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
</code></pre> 
<ol start="4"><li>添加到开启启动项</li></ol> 
<pre><code class="prism language-shell"><span class="token function">sudo</span> systemctl <span class="token function">enable</span> new-task.service
</code></pre> 
<ol start="5"><li>用 systemctl 管理此任务</li></ol> 
<pre><code class="prism language-shell"><span class="token function">sudo</span> systemctl start new-task.service <span class="token comment"># 开启</span>
<span class="token function">sudo</span> systemctl restart new-task.service <span class="token comment"># 重启</span>
<span class="token function">sudo</span> systemctl stop new-task.service <span class="token comment"># 关闭</span>
</code></pre>
                
{% endraw %}
