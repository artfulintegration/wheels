require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/generated_attribute'
require 'rails/generators/active_record'


class AppLayoutGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../../../../', __FILE__)
  require File.join(File.dirname(__FILE__), '../core_extensions.rb')
  desc "Installs files needed for App Template gem."

  def copy_files
    template a= 'app/views/layouts/application.html.haml',
                a
  end
end

