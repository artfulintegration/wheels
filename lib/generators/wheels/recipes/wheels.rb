gem 'rails3-generators'
gem 'RedCloth'
gem 'acts-as-taggable-on'
gem 'da_huangs_ruby_extensions'
gem 'casey_jones'
gem 'inherited_resources', '1.1.2'
gem 'has_scope'

stategies << lambda do
  migration_template 'db/migrate/add_fields_to_users.rb', 'db/migrate/add_fields_to_users'
  sleep 1
  migration_template 'db/migrate/create_blogs.rb', 'db/migrate/create_blogs'
  sleep 1
  migration_template 'db/migrate/create_galleries.rb', 'db/migrate/create_galleries'
  sleep 1
  migration_template 'db/migrate/create_images.rb', 'db/migrate/create_images'
  sleep 1
  migration_template 'db/migrate/create_profiles.rb', 'db/migrate/create_profiles'
  sleep 1
  migration_template 'db/migrate/create_roles.rb', 'db/migrate/create_roles'

  user_attr = %w(user_email user_password user_first_name user_last_name user_blog_title user_alias)
  for attrib in user_attr
    class_eval "attr_accessor :#{attrib}"
    send "#{attrib}=", ask("Please enter #{attrib}...")
  end

  migration_template 'db/migrate/insert_admin_user_and_roles.rb',
                      'db/migrate/insert_admin_user_and_roles'

  route "wheels_resources"
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
end

