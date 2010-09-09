# Load rake tasks
require 'theme_support/railtie'

# Load the Theme model and ThemeController
require 'theme_support/theme'
require 'theme_support/theme_controller'

# Initializes theme support by extending some of the core Rails classes
require 'theme_support/patches/abstractcontroller_ex'
require 'theme_support/patches/routeset_ex'

# Add the tag helpers for rhtml and, optionally, liquid templates
require 'theme_support/helpers/erb_theme_tags'

# Commented out to remove the message 
# "Liquid doesn't seem to be loaded...  uninitialized constant Liquid"
#begin
#   require 'helpers/liquid_theme_tags'   
#rescue
#   # I guess Liquid isn't being used...
#   STDERR.puts "Liquid doesn't seem to be loaded... #{$!}"
#end

