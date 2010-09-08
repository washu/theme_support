class ThemeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def create_theme_directories    
    theme_root = File.join("themes", file_name)

    empty_directory theme_root

    %w{images javascripts views stylesheets}.each do |d|
      empty_directory File.join(theme_root, d)
    end

    empty_directory File.join(theme_root, "views", "layouts")

    copy_file 'about.markdown', File.join(theme_root, "about.markdown")
    copy_file 'preview.png', File.join(theme_root, 'images', 'preview.png' )
    copy_file 'theme.css', File.join(theme_root, 'stylesheets', "#{file_name}.css" )
    copy_file 'layout.html.erb', File.join(theme_root, 'views', 'layouts', 'application.html.erb' )
    copy_file 'views_readme', File.join(theme_root, 'views', 'views_readme.txt' )
  end
end
