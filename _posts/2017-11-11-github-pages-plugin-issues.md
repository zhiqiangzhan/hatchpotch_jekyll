---
layout: post
title:  "GitHub Pages Plugin Issues"
date:   2017-11-11 01:35:47 +0800
categories: jekyll
tags: jekyll blog plugins github-pages
---

```ruby
gem 'github-pages', group: :jekyll_plugins
```

一旦按照上述方式引入`github-pages`，则会无法加载本地的`_plugins`中的插件。

## 原因分析

### 调用链路

#### 触发点

Jekyll::Site#initialize => Jekyll::Site#reset

```ruby
Jekyll::Hooks.trigger :site, :after_reset, self
```

#### 执行点

```ruby
gem 'github-pages', group: :jekyll_plugins
```

github-pages.rb 

```ruby
Jekyll::Hooks.register :site, :after_reset do |site|
  GitHubPages::Configuration.set(site)
end
```

GitHubPages::Configuration#set => GitHubPages::Configuration#set! => GitHubPages::Configuration#effective_config

```ruby
OVERRIDES = {
  "lsi"         => false,
  "safe"        => true,
  "plugins_dir" => SecureRandom.hex,
  "whitelist"   => GitHubPages::Plugins::PLUGIN_WHITELIST,
  "highlighter" => "rouge",
  "kramdown"    => {
    "template"           => "",
    "math_engine"        => "mathjax",
    "syntax_highlighter" => "rouge",
  },
  "gist"        => {
    "noscript"  => false,
  },
}.freeze

def effective_config(user_config)
    # Merge user config into defaults
    config = Jekyll::Utils.deep_merge_hashes(defaults_for_env, user_config)
      .fix_common_issues
      .add_default_collections
    
    # Merge overwrites into user config
    config = Jekyll::Utils.deep_merge_hashes config, OVERRIDES
    
    restrict_markdown_processor(config)
    
    # Ensure we have those gems we want.
    config["plugins"] = Array(config["plugins"]) | DEFAULT_PLUGINS
    
    if disable_whitelist?
      config["whitelist"] = config["whitelist"] | config["plugins"]
    end
    
    if development?
      config["whitelist"] = config["whitelist"] | DEVELOPMENT_PLUGINS
    end
    
    config
end
```

## 附录

### Jekyll Plugin加载分析

jekyll 执行入口

```ruby
require "jekyll"
require "mercenary"

Jekyll::PluginManager.require_from_bundler

Jekyll::Deprecator.process(ARGV)

Mercenary.program(:jekyll) do |p|
# ......
end
```

Jekyll::PluginManager.require_from_bundler

```ruby
def self.require_from_bundler
  if !ENV["JEKYLL_NO_BUNDLER_REQUIRE"] && File.file?("Gemfile")
    require "bundler"

    Bundler.setup
    required_gems = Bundler.require(:jekyll_plugins)
    message = "Required #{required_gems.map(&:name).join(", ")}"
    Jekyll.logger.debug("PluginManager:", message)
    ENV["JEKYLL_NO_BUNDLER_REQUIRE"] = "true"

    true
  else
    false
  end
end
```

Bundler#require

```ruby
def setup(*groups)
  # Return if all groups are already loaded
  return @setup if defined?(@setup) && @setup

  definition.validate_runtime!

  SharedHelpers.print_major_deprecations!

  if groups.empty?
    # Load all groups, but only once
    @setup = load.setup
  else
    load.setup(*groups)
  end
end

def require(*groups)
  setup(*groups).require(*groups)
end

def load
  @load ||= Runtime.new(root, definition)
end
```

Bundler::Runtime#require

```ruby
def require(*groups)
  groups.map!(&:to_sym)
  groups = [:default] if groups.empty?

  @definition.dependencies.each do |dep|
    next unless (dep.groups & groups).any? && dep.should_include?

    required_file = nil

    begin
      Array(dep.autorequire || dep.name).each do |file|
        file = dep.name if file == true
        required_file = file
        begin
          Kernel.require file
        rescue => e
          raise e if e.is_a?(LoadError) 
          raise Bundler::GemRequireError.new e,
            "There was an error while trying to load the gem '#{file}'."
        end
      end
    rescue LoadError => e
      REQUIRE_ERRORS.find {|r| r =~ e.message }
      raise if dep.autorequire || $1 != required_file

      if dep.autorequire.nil? && dep.name.include?("-")
        begin
          namespaced_file = dep.name.tr("-", "/")
          Kernel.require namespaced_file
        rescue LoadError => e
          REQUIRE_ERRORS.find {|r| r =~ e.message }
          raise if $1 != namespaced_file
        end
      end
    end
  end
end
```










