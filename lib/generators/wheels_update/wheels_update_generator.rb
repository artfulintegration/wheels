require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/generated_attribute'
require 'rails/generators/active_record'

class WheelsUpdateGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  require File.join(File.dirname(__FILE__), '../core_extensions.rb')
  source_root File.expand_path('../../../../', __FILE__)
  desc "Updates files to the current version of the gem."

  def init
    initialize_templater
  end

  def load_recipes
    apply recipe('wheels_update')
  end

  def bundle_install
    run 'bundle install'
  end

  def execute
    execute_stategies
  end

  def self.next_migration_number(dirname)

    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end
end

