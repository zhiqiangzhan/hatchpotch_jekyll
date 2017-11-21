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

