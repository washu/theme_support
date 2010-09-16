#
# These are theme helper tags
#
module ActionView::Helpers::AssetTagHelper
   # returns the public path to a theme stylesheet
   def theme_stylesheet_path( source=nil, theme=nil )
      theme = theme || controller.current_theme
      compute_public_path(source || "theme", "themes/#{theme}/stylesheets", 'css').html_safe
   end

   # returns the path to a theme image
   def theme_image_path( source, theme=nil )
      theme = theme || controller.current_theme
      compute_public_path(source, "themes/#{theme}/images", 'png').html_safe
   end

   # returns the path to a theme javascript
   # Add ts to the name function, because rails think it's a route (_path)
   def theme_javascript_pathts( source, theme=nil )
      theme = theme || controller.current_theme
      compute_public_path(source, "themes/#{theme}/javascripts", 'js').html_safe
   end

   # To keep compatibility with old themesupport plugin
   def theme_javascript_path( source, theme=nil )
      theme_javascript_pathts( source, theme)
   end
   
   # This tag it will automatially include theme specific css files
   def theme_stylesheet_link_tag(*sources)
      sources.uniq!
      options = sources.last.is_a?(Hash) ? sources.pop.stringify_keys : { }
      sources.collect { |source|
         source = theme_stylesheet_path(source)
         tag("link", { "rel" => "Stylesheet", "type" => "text/css", "media" => "screen", "href" => source }.merge(options))
      }.join("\n").html_safe
   end
   
   # This tag will return a theme-specific IMG
   def theme_image_tag(source, options = {})
     options.symbolize_keys

     options[:src] = theme_image_path(source)
     options[:alt] ||= File.basename(options[:src], '.*').split('.').first.capitalize

     if options[:size]
       options[:width], options[:height] = options[:size].split("x")
       options.delete :size
     end

     tag("img", options).html_safe
   end
   
   # This tag can be used to return theme-specific javscripts
   def theme_javascript_include_tag(*sources)
     options = sources.last.is_a?(Hash) ? sources.pop.stringify_keys : { }
     if sources.include?(:defaults)        
       sources = sources[0..(sources.index(:defaults))] + 
         @@javascript_default_sources.dup + 
         sources[(sources.index(:defaults) + 1)..sources.length]
       sources.delete(:defaults) 
       sources << "application" if defined?(Rails.root) && File.exists?("#{Rails.root}/public/javascripts/application.js")
     end
     sources.collect { |source|
       source = theme_javascript_pathts(source)
       content_tag("script", "", { "type" => "text/javascript", "src" => source }.merge(options))
     }.join("\n").html_safe
   end
end
