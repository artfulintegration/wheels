require File.join(File.dirname(__FILE__), 'core_extensions.rb')

initialize_templater

required_recipes = %w(default jquery haml rspec factory_girl remarkable devise cancan)
required_recipes.each {|required_recipe| apply recipe(required_recipe)}

apply recipe(ask("Which database? (m)ongoid or (p)ostgresql")=='m' ? 'mongoid' : 'postgresql')

load_options
apply(recipe('cucumber')) if yes?("Do you want to some cukes?")
apply recipe('design')

# run 'bundle install'

execute_stategies

generators_configuration = <<-END
config.generators do |g|
  g.template_engine :haml
  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
end
END

environment generators_configuration

git :add => "."
git :commit => "-m 'Initial commit'"

