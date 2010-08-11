
stategies << lambda do
#  migration_template 'db/migrate/add_fields_to_users.rb', 'db/migrate/add_fields_to_users'
#  sleep 1

  directory 'public', 'public'
  unless no? "Update views as well?"
    directory 'app/views', 'app/views'
  end
end

