gemfile

route "root :to => \"blogs#index\""

unless have_migration? "insert_admin_user_and_roles"
  user_attr = %w(user_email user_password user_first_name user_last_name user_blog_title user_alias)
  for attrib in user_attr
    class_eval "attr_accessor :#{attrib}"
    send "#{attrib}=", ask("Please enter #{attrib}...")
  end
end

unless File.exist? 'config/amazon_s3.yml'
  class_eval do
    attr_accessor :bucket, :access_key_id, :secret_access_key
  end
  say ("If you have your S3 info handy, put it in now.")
  for attribute in %w(bucket access_key_id secret_access_key)
    self.send "#{attribute}=", ask("What's the #{attribute}?")
  end

  template 'config/amazon_s3.yml', 'config/amazon_s3.yml'
end

generate "wheels_checkout_assets_readonly"

stategies << lambda do
  generate "devise:install"
  source_root File.expand_path('../../../../', __FILE__)
  my_migrations = Dir.new(File.expand_path('db/migrate', source_root)).entries

  my_migrations.each do |file|
    migration_oldnum = file.split("_").first
    migration_name = file.split('.').first.
                      split("_").reject{|t| t==migration_oldnum}.join('_')
    if migrations.select{|t| t.include?(migration_name)}.empty?
      migration_template "db/migrate/#{file}", "db/migrate/#{migration_name}"
      sleep 1
    end
  end

  # create wheels_resources first so that devise_for :users will appear first in routes.rb
  route "wheels_resources"
  route "devise_for :users"
end

