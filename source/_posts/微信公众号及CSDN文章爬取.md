---
title: 微信公众号及CSDN文章爬取
date: 2021-10-07 12:28:50
tags:
---

# 写在前面
最近刚开了自己的博客，就想着把原来写的一些文章都放到这里来。
[https://blog.liuzemei.com](https://blog.liuzemei.com)

准备做筛选，然后一篇篇的把微信公众号的文章复制过来的，结果发现
1. 太多了，而且不好筛选。
2. 复制的文章都是不带格式的，也不大好看。

于是就想着写个脚本，直接把带格式的 html 抓过来，于是就有了本篇教程。

开发环境
> nodejs.v16
> 抓包工具

# 开始
## 一、 微信公众号文章的爬取
[https://zhuanlan.zhihu.com/p/77438394](https://zhuanlan.zhihu.com/p/77438394)

关于 python 的细节可以直接查看上述的链接。我这里是用的 nodejs，相当于稍微翻译了一下。

### 1. 从抓包工具获取 `__biz` `uin` 和 `key`

### 2. 构建获取的脚本
```js
const axios = require('axios')
const fs = require('fs')
const cheerio = require('cheerio')
const moment = require('moment')
const path = require('path')

const __biz = ""
const uin = ""
const key = ""

const ins = axios.create({
  headers: {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) MicroMessenger/6.8.0(0x16080000) MacWechat/3.2(0x13020013) Chrome/39.0.2171.95 Safari/537.36 NetType/WIFI WindowsWechat"
  }
})

async function craw(index) {
  let url = "https://mp.weixin.qq.com/mp/profile_ext"
  let params = {
    __biz, uin, key,
    'action': 'getmsg',
    'f': 'json',
    'offset': index * 10,
    'count': '10',
    'is_ok': '1',
    'scene': '124',
    'wxtoken': '',
    'x5': '0',
  }
  let { data } = await ins.get(url, { params })
  return data.general_msg_list
}

async function writeArticleToFile({ app_msg_ext_info, comm_msg_info: { datetime } }) {
  const { title, content_url, cover, author } = app_msg_ext_info
  const imgFileName = datetime + ".png"
  datetime = moment(datetime * 1000)
  const year = datetime.year()
  if (!fs.existsSync(`${year}`)) {
    fs.mkdirSync(`${year}`)
    fs.mkdirSync(`images/${year}`)
  }
  const created_at = datetime.format('YYYY-MM-DD HH:mm:SS')
  const content = await crawArticle(content_url)
  const writer = fs.createWriteStream(path.resolve(__dirname, 'images', String(year), imgFileName))
  const res = await ins({
    url: cover,
    method: "GET",
    responseType: "stream"
  })
  res.data.pipe(writer)
  const result = `---
title: ${title}
date: ${created_at}
layout: post
author: ${author}
img: /source/images/${year}/${imgFileName}
categories:
  - 微信文章
  - 导入
tags: 随笔
---

[原链接](${content_url})
{% raw %}
${content}
{% endraw %}
`

  fs.writeFileSync(`${year}/${title}.md`, result, 'utf8')

}

async function crawArticle(url) {
  const res = await ins.get(url)
  return readArticle(res.data)
}

function readArticle(html) {
  let $ = cheerio.load(html)
  let content = $('#js_content').html()
  return content
}

async function main() {
  let page = 0
  while (true) {
    const res = await craw(page++)
    if (!res.list || res.list.length === 0) break
    for (const obj of res.list) {
      try {
        await writeArticleToFile(obj)
      } catch (e) {
        console.log(e)
        console.log(obj.comm_msg_info.id)
      }
    }
  }
}
main()
```

### 3. 执行脚本。

## 二、 CSDN文章的爬取
文章列表的抓取方法我没仔细弄了，因为我的文章并没有那么多。拉个3次就拉完了，所以直接手动获取了json的返回值。

类似这样的
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "list": [
      {
        "articleId": 82215835,
        "title": "装个QT5各种坑，终于搞定了",
        "description": "转：https://blog.csdn.net/u013934107/article/details/807124181、下载 Qt5 离线安装包下载地址：http://www.qt.io/download-open-source/  进入后，请注意页面最下方有个【View All Downloads】链接，点击它可找到离线安装包！  这里写图片描述根据自己的操作系统版本，选择对应...",
        "url": "https://blog.csdn.net/weixin_41884153/article/details/82215835",
        "type": 2,
        "top": false,
        "forcePlan": false,
        "viewCount": 21409,
        "commentCount": 3,
        "editUrl": "https://editor.csdn.net/md?articleId=82215835",
        "postTime": "2018-08-30 09:12:12",
        "diggCount": 0,
        "formatTime": "3 年前"
      }
    ]
  }
}
```

接下来其实就很简单了，跟微信的逻辑一样，找到文章的 id 的dom，然后提取出来就完了。
### 代码如下
```js
const axios = require('axios').default
const fs = require('fs')
const cheerio = require('cheerio')
const ins = axios.create({
  headers: {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36",
  }
})

async function craw(index) {
  let url = `https://blog.csdn.net/community/home-api/v1/get-business-list?page=${index}&size=20&businessType=blog&orderby=&noMore=false&username=weixin_41884153`
  let { data } = await ins.get(url)
  console.log(data)
  try {
    fs.writeFileSync(`${index}.json`, JSON.stringify(data))
  } catch (e) {
    console.log(e)
  }
}

async function writeArticleToFile({ title, url, postTime }) {
  const _create = new Date(postTime)
  const year = _create.getFullYear()
  if (!fs.existsSync(`${year}`)) {
    fs.mkdirSync(`${year}`)
    fs.mkdirSync(`images/${year}`)
  }
  const content = await crawArticle(url)
  const result = `---
title: ${title}
date: ${postTime}
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 随笔
---

[原链接](${url})
{% raw %}
${content}
{% endraw %}
`
  fs.writeFileSync(`${year}/${title}.md`, result, 'utf8')
}

async function crawArticle(url) {
  const res = await ins.get(url)
  return readArticle(res.data)
}

function readArticle(html) {
  let $ = cheerio.load(html)
  let content = $('#content_views').html()
  return content
}

async function main() {
  for (let i = 0; i < 4; i++) {
    for (const obj of res.data.list) {
      try {
        await writeArticleToFile(obj)
      } catch (e) {
        console.log(e)
      }
    }
  }
}
main()
```