gem 'pg'

stategies << lambda do
  opts = {}
  opts[:database_name] = ask("What's the name of the database?")
  opts[:database_username] = ask("Database username?")
  opts[:database_password] = ask("Password?  ***  Will show in plain text on your screen")
  create_file 'config/database.yml',
    load_template('postgresql.yml', 'database', opts)
end

