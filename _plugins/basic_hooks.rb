
[:after_init, :after_reset, :post_read, :pre_render, :post_render, :post_write].each do|event|
  Jekyll::Hooks.register :site, event do |site|
    puts ">>(#{__FILE__}) site fire #{event}"
  end
end

[:pages, :posts, :documents].each do |container|
  [:post_init, :pre_render, :post_render, :post_write].each do|event|
    Jekyll::Hooks.register container, event do |target|
      puts ">>(#{__FILE__}) #{container}[] fire #{event}"
    end
  end
end

puts ">>>>> (#{__FILE__}) Loaded!"