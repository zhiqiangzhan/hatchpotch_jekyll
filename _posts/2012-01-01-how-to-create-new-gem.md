---
layout: post
title:  "How to create a new gem"
date:   2012-01-01 01:35:47 +0800
categories: ruby
tags: ruby gem
---


#### 先检查`gem`名称有没有被占用。

```bash
gem list -r reset-jekyll-config
```

#### 使用bundler来生成一个基础gem结构

```bash
bundle gem reset-jekyll-config

bundle install
```

#### 发布

```bash
rake install

rake release
```

