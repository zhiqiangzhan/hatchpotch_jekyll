#### 快速开始

```bash
gem install jekyll bundler
jekyll new ~/myblog
cd ~/myblog
bundle exec jekyll serve
```

#### 使用GitHub Pages

修改`Gemfile`内容如下：

```ruby
source 'https://gems.ruby-china.org/'

gem 'github-pages', group: :jekyll_plugins
```

[GitHub Pages插件白名单](https://help.github.com/articles/configuring-jekyll-plugins/)


#### Posts预定义变量

| 变量 | 描述 |
| --- | --- |
| date | 默认格式：YYYY-MM-DD HH:MM:SS +/-TTTT |
| category/categories | 类别 |
| tags | 标签 |

#### 典型Jekyll目录结构

```bash
.
├── _config.yml
├── _data
|   └── members.yml
├── _drafts
|   ├── begin-with-the-crazy-ideas.md
|   └── on-simplicity-in-technology.md
├── _includes
|   ├── footer.html
|   └── header.html
├── _layouts
|   ├── default.html
|   └── post.html
├── _posts
|   ├── 2007-10-29-why-every-programmer-should-play-nethack.md
|   └── 2009-04-26-barcamp-boston-4-roundup.md
├── _sass
|   ├── _base.scss
|   └── _layout.scss
├── _site
├── .jekyll-metadata
└── index.html # can also be an 'index.md' with valid YAML Frontmatter
```