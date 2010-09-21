class AbstractController::Base
  attr_accessor :current_theme
  attr_accessor :force_liquid_template

  # Use this in your controller just like the <tt>layout</tt> macro.
  # Example:
  #
  #  theme 'theme_name'
  #
  # -or-
  #
  #  theme :get_theme
  #
  #  def get_theme
  #    'theme_name'
  #  end

  def self.theme(theme_name, conditions = {})
    # TODO: Allow conditions... (?)
    write_inheritable_attribute "theme", theme_name
  end

  # Retrieves the current set theme
  def current_theme(passed_theme=nil)
    theme = passed_theme || self.class.read_inheritable_attribute("theme")

    @active_theme = case theme
      when Symbol then send(theme)
      when Proc   then theme.call(self)
      when String then theme
    end
  end
end

module AbstractController
  module Rendering

  #Too high in the stack

#    alias_method :theme_support_render, :render

#    def render(*args, &block)
#      theme = current_theme
#      if theme
#        theme = ActionView::Base.process_view_paths(File.join("themes", theme, "views"))
#        prepend_view_path(theme)
#      end
#
#      theme_support_render(*args, &block)
#    end

    alias_method :theme_support_render_to_string, :render_to_string

    def render_to_string(*args, &block)
      theme = current_theme
      if theme
        theme = ActionView::Base.process_view_paths(File.join("themes", theme, "views"))
        prepend_view_path(theme)
      end

      theme_support_render_to_string(*args, &block)
    end

  end
end
