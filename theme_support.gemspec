require 'rubygems'

spec = Gem::Specification.new do |s|
  ## package information
  s.name        = 'theme_support'
  s.author      = 'Pierre Yager and Sylvain Claudel'
  s.email       = "pierre@levosgien.net"
  s.version     = ("$Release: 3.0.6" =~ /[\.\d]+/) && $&
  s.platform    = Gem::Platform::RUBY
  s.homepage    = 'http://github.com/zedalaye/theme_support'
  s.rubyforge_project = 'theme-support'
  s.summary     = "add multi-themes support to Rails 3.0"
  s.description = <<-END
  ThemeSupport adds support for multi-themes to your Rails 3.0 application
  END

  ## files
  files = []
  files += Dir.glob('lib/**/*')
  files += %w[Gemfile LICENSE README VERSION theme_support.gemspec]
  s.files = files.delete_if { |path| path =~ /\.svn/ }
  s.files = files
end

if $0 == __FILE__
  Gem::manage_gems
  Gem::Builder.new(spec).build
end
