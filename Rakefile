require 'rubygems'
require 'rake'
PKG_FILES = FileList[
  'wheels.gemspec',
  'Gemfile',
  'init.rb',
  'Rakefile', 'README', 'LICENSE', 'README.rdoc', 'VERSION',
  'app/**/*',
  'config/**/*',
  'db/**/*',
  'lib/**/*',
  'public/**/*',
  'test/**/*'
]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "wheels"
    gem.summary = "Generator builds a web site with blog, user profile, etc."
    gem.description = "Call rails generate wheels."
    gem.email = "tgannon@gmail.com"
    gem.homepage = "http://github.com/tylergannon/wheels"
    gem.authors = ["Tyler Gannon"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.files = PKG_FILES.to_a
    gem.require_path = "lib"
    gem.has_rdoc = false
    gem.extra_rdoc_files = ["README.rdoc"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "wheels #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

