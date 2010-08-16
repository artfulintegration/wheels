gem 'acts-as-taggable-on'
gem 'aws-s3'
gem 'casey_jones'
gem 'da_huangs_ruby_extensions'
gem 'devise', '1.1.rc2'
gem 'has_scope'
gem 'inherited_resources', '1.1.2'
gem 'paperclip'
gem 'rails3-generators'
gem 'RedCloth'

route "root :to => \"blogs#index\""


user_attr = %w(user_email user_password user_first_name user_last_name user_blog_title user_alias)
for attrib in user_attr
  class_eval "attr_accessor :#{attrib}"
  send "#{attrib}=", ask("Please enter #{attrib}...")
end

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

stategies << lambda do
  generate "devise:install"
  generate "devise User"
  migration_template 'db/migrate/add_fields_to_users.rb', 'db/migrate/add_fields_to_users'
  generate "acts_as_taggable_on:migration"
  migration_template 'db/migrate/create_blogs.rb', 'db/migrate/create_blogs'; sleep 1
  migration_template 'db/migrate/create_galleries.rb', 'db/migrate/create_galleries'; sleep 1
  migration_template 'db/migrate/create_images.rb', 'db/migrate/create_images'; sleep 1
  migration_template 'db/migrate/create_profiles.rb', 'db/migrate/create_profiles'; sleep 1
  migration_template 'db/migrate/create_roles.rb', 'db/migrate/create_roles'
  migration_template 'db/migrate/insert_admin_user_and_roles.rb',
                    'db/migrate/insert_admin_user_and_roles'

  # create wheels_resources first so that devise_for :users will appear first in routes.rb
  route "wheels_resources"
  route "devise_for :users"
end

