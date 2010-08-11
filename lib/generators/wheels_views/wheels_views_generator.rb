require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/generated_attribute'
require 'rails/generators/active_record'

class WheelsViewsGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../../../../', __FILE__)
  desc "Installs files needed for App Template gem."

  def copy_files
    directory 'app/views', 'app/views'
  end
end

