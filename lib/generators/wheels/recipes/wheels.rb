gem 'rails3-generators'
gem 'RedCloth'
gem 'acts-as-taggable-on'
gem 'da_huangs_ruby_extensions'
gem 'casey_jones'
gem 'inherited_resources', '1.1.2'
gem 'has_scope'

stategies << lambda do
  migration_template 'db/migrate/add_fields_to_users.rb', 'db/migrateadd_fields_to_users'
  migration_template 'db/migrate/create_blogs.rb', 'db/migratecreate_blogs'
  migration_template 'db/migrate/create_galleries.rb', 'db/migratecreate_galleries'
  migration_template 'db/migrate/create_images.rb', 'db/migratecreate_images'
  migration_template 'db/migrate/create_profiles.rb', 'db/migratecreate_profiles'
  migration_template 'db/migrate/create_roles.rb', 'db/migratecreate_roles'

  route "wheels_resources"
  class_eval do
    attr_accessor :bucket, :access_key_id, :secret_access_key
  end
  say ("If you have your S3 info handy, put it in now.")
  for attribute in [:bucket, :access_key_id, :secret_access_key]
    self.send "#{attribute}=", ask("What's the #{attribute}?")
  end

  template 'config/amazon_s3.yml', 'config/amazon_s3.yml'
  run "git submodule add git://github.com/tylergannon/ckeditor.git public/ckeditor"

  directory 'public', 'public'
  gem "will_paginate", :git=>"http://github.com/mislav/will_paginate.git",
        :branch=>"rails3"

end

