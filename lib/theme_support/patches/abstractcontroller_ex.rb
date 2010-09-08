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

  #class << self
    def self.theme(theme_name, conditions = {})
      # TODO: Allow conditions... (?)
      write_inheritable_attribute "theme", theme_name
      theme = ActionView::Base.process_view_paths(File.join("themes", theme_name, "views"))
      prepend_view_path(theme)
    end
  #end

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

AbstractController::Layouts.module_eval do
  def _normalize_options(options)
    super

    if _include_layout?(options)
      layout = options.key?(:layout) ? options.delete(:layout) : :default
      value = _layout_for_option(layout)
      options[:layout] = (value =~ /\blayouts/ ? value : "layouts/#{value}") if value
    end

    if current_theme
      theme_path = File.join(Rails.root, "themes", current_theme, "views")
      options[:layout] = File.join(theme_path, options[:layout])
    end
  end
end