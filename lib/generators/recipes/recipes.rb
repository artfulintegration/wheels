gem 'cancan'
gsub_file 'Gemfile', /(gem "rspec-rails".*:group =>) \[:development, :test\]/, '\1 [:development, :test, :cucumber]'
gsub_file 'Gemfile', /(gem "factory_girl_rails".*:group =>) :test/, '\1 [:test, :cucumber]'

append_file 'Gemfile', <<-EOF
group :cucumber do
   gem 'capybara'
   gem 'cucumber-rails'
   gem 'spork'
   gem 'launchy'
end
EOF

# Delete all unnecessary files
remove_file "README"
remove_file "public/index.html"
remove_file "public/robots.txt"
remove_file "public/images/rails.png"

create_file 'README'
create_file 'log/.gitkeep'
create_file 'tmp/.gitkeep'

gsub_file 'config/application.rb', 'require "rails/test_unit/railtie"', '# require "rails/test_unit/railtie"'

get "http://html5shiv.googlecode.com/svn/trunk/html5.js", "public/javascripts/html5.js"

git :init

append_file '.gitignore', load_template('gitignore','git')

if template_options[:design] == "compass"
   gem 'compass'

   # TODO: support more than one framework from compass
   compass_sass_dir = "app/stylesheets"
   compass_css_dir = "public/stylesheets/compiled"

   compass_command = "compass init rails . --using blueprint/semantic --css-dir=#{compass_css_dir} --sass-dir=#{compass_sass_dir} "

   stategies << lambda do
      puts "Beginning Compass setup"
      run compass_command
      puts "Compass has been setup"
   end

end
gem 'devise', '1.1.rc2'
gem 'factory_girl_rails', :group => :test


   create_file 'app/models/ability.rb', load_template('ability.rb', 'cancan')
   generate 'cucumber:install --rspec --capybara --skip-database'
   generate "devise:install"
   generate "devise User"
   route "devise_for :users"
   inject_into_file 'spec/spec_helper.rb', "\nrequire 'factory_girl'", :after => "require 'rspec/rails'"
   endgem 'haml'

   remove_file 'app/views/layouts/application.html.erb'

   initializer 'haml.rb',<<EOF
   Haml::Template.options[:format] = :html5
EOF

   # Initialize jQuery
   get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js",  "public/javascripts/jquery.js"
   get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

   # Set default JavaScript files
   environment "config.action_view.javascript_expansions = { :defaults => ['jquery', 'rails'] }"gem 'mongoid', '>= 2.0.0.beta.14'
   gem 'bson_ext', '1.0.4'

   stategies << lambda do
      generate 'mongoid:config'
      run 'cp config/mongoid.yml config/mongoid.yml.example'
   end
   gem 'pg'

   stategies << lambda do
      opts = {}
      opts[:database_name] = ask("What's the name of the database?")
      opts[:database_username] = ask("Database username?")
      opts[:database_password] = ask("Password?  ***  Will show in plain text on your screen")
      create_file 'config/database.yml',
      load_template('postgresql.yml', 'database', opts)
   end

   gem 'remarkable_activemodel', '>=4.0.0.alpha4', :group => :test
   if recipes.include? 'mongoid'
      gem 'remarkable_mongoid', :group => :test

      stategies << lambda do
         inject_into_file 'spec/spec_helper.rb', "\nrequire 'remarkable/active_model'\nrequire 'remarkable/mongoid'", :after => "require 'rspec/rails'"
      end
   end

   gem 'rspec-rails', '>= 2.0.0.beta.19', :group => [:development, :test]

   stategies << lambda do
      generate 'rspec:install'

      spec_helper_path = 'spec/spec_helper.rb'

      gsub_file spec_helper_path, 'config.fixture_path = "#{::Rails.root}/spec/fixtures"', ''
      gsub_file spec_helper_path, /(config.use_transactional_fixtures = true)/, '# \1'

      if recipes.include? 'mongoid'
    mongoid_rspec_truncation = <<-MONGOID

      config.before :each do
        Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
      end

         MONGOID

         inject_into_file spec_helper_path, mongoid_rspec_truncation, :after => "# config.use_transactional_fixtures = true\n"
      end
   end

   gem 'rails3-generators'
   gem 'RedCloth'
   gem 'acts-as-taggable-on'
   gem 'da_huangs_ruby_extensions'
   gem 'casey_jones'
   gem 'inherited_resources', '1.1.2'
   gem 'has_scope'
   gem 'paperclip'
   gem 'aws-s3'

   route "root :to => \"blogs#index\""
   route "wheels_resources"

   migration_template 'db/migrate/add_fields_to_users.rb', 'db/migrate/add_fields_to_users'
   generate "acts_as_taggable_on:migration"
   migration_template 'db/migrate/create_blogs.rb', 'db/migrate/create_blogs'; sleep 1
   migration_template 'db/migrate/create_galleries.rb', 'db/migrate/create_galleries'; sleep 1
   migration_template 'db/migrate/create_images.rb', 'db/migrate/create_images'; sleep 1
   migration_template 'db/migrate/create_profiles.rb', 'db/migrate/create_profiles'; sleep 1
   migration_template 'db/migrate/create_roles.rb', 'db/migrate/create_roles'

   user_attr = %w(user_email user_password user_first_name user_last_name user_blog_title user_alias)
   for attrib in user_attr
      class_eval "attr_accessor :#{attrib}"
      send "#{attrib}=", ask("Please enter #{attrib}...")
   end

   migration_template 'db/migrate/insert_admin_user_and_roles.rb',
   'db/migrate/insert_admin_user_and_roles'
   class_eval do
      attr_accessor :bucket, :access_key_id, :secret_access_key
   end
   say ("If you have your S3 info handy, put it in now.")
   for attribute in %w(bucket access_key_id secret_access_key)
      self.send "#{attribute}=", ask("What's the #{attribute}?")
   end


   template 'config/amazon_s3.yml', 'config/amazon_s3.yml'
   run "git submodule add git://github.com/tylergannon/ckeditor.git public/ckeditor"

   directory 'public', 'public'
   run "git submodule add -b rails3 http://github.com/mislav/will_paginate.git vendor/plugins/will_paginate"

