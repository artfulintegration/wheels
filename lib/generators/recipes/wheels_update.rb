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
end

