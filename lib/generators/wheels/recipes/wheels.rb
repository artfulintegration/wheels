gem 'rails3-generators', :git=>"git://github.com/tylergannon/rails3-generators.git"
gem 'RedCloth'
gem 'acts-as-taggable-on'
gem 'da_huangs_ruby_extensions'
gem 'casey_jones'
gem 'inherited_resources', '1.1.2'
gem 'has_scope'
gem "will_paginate", :git=>"http://github.com/mislav/will_paginate.git",
        :branch=>"rails3"
gem "honeypot-captcha", :git=>"http://github.com/curtis/honeypot-captcha.git"

stategies << lambda do
  ["add_fields_to_users.rb",
    "create_blogs.rb",
    "create_galleries.rb",
    "create_images.rb",
    "create_profiles.rb",
    "create_roles.rb"
  ].each {|file|  migration_template "db/migrate/#{file}", "db/migrate/#{file.split('.').first}"}

  route "wheels_resources"
  attr_accessor :bucket, :access_key_id, :secret_access_key
  say ("If you have your S3 info handy, put it in now.")
  for attribute in [:bucket, :access_key_id, :secret_access_key]
    self.call "#{attribute}=", ask("What's the #{attribute.titleize}?")
  end
  template 'config/amazon_s3.yml', 'config/amazon_s3.yml'
  run "git submodule add git://github.com/tylergannon/ckeditor.git public/ckeditor"

  directory 'public', 'public'

end

