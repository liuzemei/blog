---
title: uniswap 运行逻辑
date: 2021-02-14 16:04:18
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/113808506)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <ol><li>uniswap 核心合约分为 3 个合约，工厂合约，配对合约，ERC20合约</li><li>核心合约部署时只需要部署工厂合约</li><li>工厂合约部署时构造函数只需要设定一个手续费管理员</li><li>在工厂合约部署之后，就可以进行创建配对的操作</li><li>要在交易所中进行交易，操作顺序是：创建交易对，添加流动性，交易。</li><li>添加配对时需要提供两个 token 的地址，随后工厂合约会为这个交易对部署一个新的配对合约。</li><li>配对合约的部署是通过 create2 的方法</li><li>两个 token 地址按 2 禁止大小排序后一起进行 hash，以这个 hash 值作为 create2 的 salt 进行部署</li><li>所以配对合约的地址是可以通过两个 token 地址进行 create2 计算的</li><li>用户可以将两个 token 存入到配对合约中，然后再配对合约中为用户生成一种兼容 ERC20 的 TOKEN。</li><li>配对合约中生成的 ERC20 TOKEN 可以成为流动性</li><li>用户可以将自己的流动性余额兑换成配对合约中的任何一种 token。</li><li>用户也可以取出流动性，配对合约将销毁流动性，并将两种 token 同时返还用户。</li><li>返还的数量将根据流动性数量和两种 token 的储备量重新计算，如果有手续费收益，用户也将得到收益。</li><li>用户可以通过一种 token 交换另一种 token，配对合约将扣除千分之 3 的手续费</li><li>在 uniswap 核心合约基础上，还有一个路由合约用来更好的操作核心合约</li><li>路由合约拥有 3 部分操作方法，添加流动性，移除流动性，交换</li><li>虽然配对合约已经可以完成所有的交易操作，但路由合约将所有操作整合，配合前端更好的完成交易</li><li>因为路由合约的代码量较多，部署时会超过 gas 限制，所以路由合约被分为两个版本，功能互相补充。</li></ol> 
<p>来源： https://www.bilibili.com/video/BV1jk4y1y7t9?p=4&amp;spm_id_from=pageDriver</p>
                
{% endraw %}
