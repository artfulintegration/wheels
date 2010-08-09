class WheelsGenerator < Rails::Generators::Base
  require File.join(File.dirname(__FILE__), 'core_extensions.rb')
  source_root File.expand_path('../../../../', __FILE__)
  desc "Installs files needed for App Template gem."

#      argument :scope, :required => false, :default => nil,
#                       :desc => "The scope to copy views to"

#      class_option :template_engine, :type => :string, :aliases => "-t",
#                                     :desc => "Template engine for the views. Available options are 'erb' and 'haml'."

  def init
    initialize_templater
  end

#  def load_recipes
#    required_recipes = %w(default jquery haml rspec factory_girl remarkable devise cancan )
#    required_recipes.each {|required_recipe| apply recipe(required_recipe)}

#    apply recipe(ask("Which database? (m)ongoid or (p)ostgresql")=='m' ? 'mongoid' : 'postgresql')

#    load_options
#    apply(recipe('cucumber')) if yes?("Do you want to some cukes?")
#    apply recipe('design')
#  end
  def load_recipes
    run 'pwd'
    required_recipes = %w(wheels)
    required_recipes.each {|required_recipe| apply recipe(required_recipe)}

    load_options
  end

  def bundle_install
    run "pwd > foolio"
    run 'bundle install'
  end

  def execute
    execute_stategies
  end

  def configure_generators
    generators_configuration = <<-END
    config.generators do |g|
      g.template_engine :haml
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
    END

    environment generators_configuration
  end

  def init_git
    git :add => "."
    git :commit => "-m 'Initial commit'"
    if (a=ask("Enter github username/reponame or blank for none.")).length > 0
      run "git remote add origin git@github.com:#{a}.git"
    end


  end
end

