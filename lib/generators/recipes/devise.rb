gem 'devise', '1.1.rc2'

stategies << lambda do
  generate "devise:install"
  generate "devise User"
  route "devise_for :users"
end

