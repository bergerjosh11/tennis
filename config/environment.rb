# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tenisowo::Application.initialize!

# Array of plugins with Application model dependencies.
#reloadable_plugins = ["dynamic_form"]

# Force these plugins to reload, avoiding stale object references.
#reloadable_plugins.each do |plugin_name|
# reloadable_path = RAILS_ROOT + "/vendor/plugins/#{plugin_name}/lib"
# Dependencies.load_once_paths.delete(reloadable_path)
#end