
[:after_init, :after_reset, :post_read, :pre_render, :post_render, :post_write].each do|event|
  Jekyll::Hooks.register :site, event do |site, payload|
    puts ">> (#{__FILE__}) site fire #{event} with #{payload}"
    if event == :post_write
      puts site
    end
  end
end

[:pages, :posts, :documents].each do |container|
  [:post_init, :pre_render, :post_render, :post_write].each do|event|
    Jekyll::Hooks.register container, event do |target|
      if target.path == '/james/rsync/codes/hotchpotch/deposit/jekyll/_posts/2017-11-11-github-pages-plugin-issues.md'
        p target.class.ancestors
      end
      puts ">> (#{__FILE__}) #{container}[#{target.class}(#{target.path})] fire #{event}"
    end
  end
end


puts ">>> (#{__FILE__}) Loaded!"