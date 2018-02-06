---
layout: post
title:  "Welcome to Jekyll!"
date:   2016-01-01 01:35:47 +0800
categories: jekyll update
tags: jekyll blog
---
You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

### Hooks

#### Jekyll::Site

```ruby
Jekyll::Hooks.trigger :site, :after_init, self
Jekyll::Hooks.trigger :site, :after_reset, self
Jekyll::Hooks.trigger :site, :post_read, self
Jekyll::Hooks.trigger :site, :pre_render, self, payload
Jekyll::Hooks.trigger :site, :post_render, self, payload
Jekyll::Hooks.trigger :site, :post_write, self

document.trigger_hooks(:post_render)
page.trigger_hooks(:post_render)
```

#### Jekyll::Document

```ruby
def trigger_hooks(hook_name, *args)
  Jekyll::Hooks.trigger collection.label.to_sym, hook_name, self, *args if collection
  Jekyll::Hooks.trigger :documents, hook_name, self, *args
end

trigger_hooks(:post_init)
trigger_hooks(:post_write)
```

#### Jekyll::Page

```ruby
Jekyll::Hooks.trigger :pages, :post_init, self

def trigger_hooks(hook_name, *args)
  Jekyll::Hooks.trigger :pages, hook_name, self, *args
end
```


#### Jekyll::Convertible

```ruby
Jekyll::Hooks.trigger hook_owner, :post_render, self
Jekyll::Hooks.trigger hook_owner, :post_write, self
```




Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
