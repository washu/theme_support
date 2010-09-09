module ThemeSupport
  module RoutingExtensions
    def themeing
      @set.with_options :controller => 'themesupport' do |theme|
        match '/themes/:theme/images/*filename', :to => 'themesupport#images', :as => 'theme_images'
        match '/themes/:theme/stylesheets/*filename', :to => 'themesupport#stylesheets', :as => 'theme_stylesheets'
        match '/themes/:theme/javascripts/*filename', :to => 'themesupport#javascript', :as => 'theme_javascript'
        match '/themes/*whatever', :to => 'themesupport#error'
      end
    end
  end
end

ActionDispatch::Routing::Mapper.send :include, ThemeSupport::RoutingExtensions