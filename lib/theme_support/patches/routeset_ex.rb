module ThemeSupport
  module RoutingExtensions
    def themeing
      @set.with_options :controller => 'theme' do |theme|       
        match '/themes/:theme/images/*filename', :to => 'theme#images', :as => 'theme_images'
        match '/themes/:theme/stylesheets/*filename', :to => 'theme#stylesheets', :as => 'theme_stylesheets'
        match '/themes/:theme/javascripts/*filename', :to => 'theme#javascript', :as => 'theme_javascript'
        match '/themes/*whatever', :to => 'theme#error'
      end
    end
  end
end

ActionDispatch::Routing::Mapper.send :include, ThemeSupport::RoutingExtensions