# Load the theme to execution and not in loading app
# TODO Check if this code works this action mailer
module ActionController
  module ImplicitRender
    alias_method :theme_support_default_render, :default_render

    def default_render
      theme = current_theme
      if theme
        theme = ActionView::Base.process_view_paths(File.join("themes", theme, "views"))
        prepend_view_path(theme)
      end
      theme_support_default_render
    end
  end
end
