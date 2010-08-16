gem 'haml'

remove_file 'app/views/layouts/application.html.erb'

initializer 'haml.rb',<<EOF
Haml::Template.options[:format] = :html5
EOF

