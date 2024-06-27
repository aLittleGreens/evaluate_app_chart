# 应用评价系统

查看、筛选应用市场评价（AppStore、Google Play），并对评论进行分类，以图表的方式查看问题分布、变化趋势。

技术栈：
数据抓取采用Python，([Python项目链接](https://github.com/aLittleGreens/app_report))前端采用Flutter

# Getting Started
## 一、抓取应用数据
通过fetch_comment.py 抓取评论数据

**首先配置应用信息**

1. 设置应用程序 ID
appid = 1544760744

2. 设置包名
appid_android = 'com.philips.ph.babymonitorplus'

3. 设置你想筛选哪个版本的评论 commentjson = '1.1.1'

程序执行完毕后，评论的json文件会在comment文件夹中生成


## 二、评论分类
将Json文件导入到[评论分类](https://alittlegreens.github.io/app_report/#/) 进行分类


## 三、将分类好的评论json导入[Flutter项目](https://github.com/aLittleGreens/evaluate_app_chart)中

## 四、打包后部署到github上

flutter build web【体验链接】(https://alittlegreens.github.io/evaluate_web_chart/)


【体验链接】(https://alittlegreens.github.io/evaluate_web_chart/)

评论展示：![图片说明](https://github.com/aLittleGreens/evaluate_web_chart/blob/main/screenshot/1.png)

评论变化趋势：
![图片说明](https://github.com/aLittleGreens/evaluate_web_chart/blob/main/screenshot/2.png)
![图片说明](https://github.com/aLittleGreens/evaluate_web_chart/blob/main/screenshot/3.png)



