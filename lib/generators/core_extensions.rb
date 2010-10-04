module Rails
  module Generators
    module Actions

      attr_accessor :stategies
      attr_accessor :recipes
      attr_reader :template_options

      def initialize_templater
        self.recipes = []
        @stategies = []
        @template_options = {}
      end

      def execute_stategies
        stategies.each {|stategy| stategy.call }
      end

      def gemfile()
        File.open(File.expand_path('Gemfile', WheelsGenerator::SOURCE_ROOT)) do |gemfile|
          while line = gemfile.readline
            line = line.split("#").first.strip
            if line.index('gem') == 0
              pcs = line.split(' ')
              gem = pcs[1].gsub(/[,"']/, '')
              version = pcs[2].try(:gsub, /[,"']/, '')
              gem_version gem, version
            end
          end
        end
      end

      def gem_version(gem_name, version_name)
        new_gemfile = ""
        added = false
        File.open('Gemfile', 'r') do |file|
          new_gemline = %(gem "#{gem_name}") + (version_name ? %(, "#{version_name}") : '') + '\n'
          while (line = file.readline)
            if line.index("gem") == 0 && (line.include? gem_name)
              new_gemfile += new_gemline
              added = true
            else
              new_gemfile += line
            end
          end
          unless added
            new_gemfile += new_gemline
          end
        end
        File.open('Gemfile', 'w').write(new_gemfile)
      end

      def load_options
        @template_options[:design] = ask("Which design framework? [none(default), compass]: ").downcase
        @template_options[:design] = "none" if @template_options[:design].nil?
      end

      def recipe(name)
        recipes << name
        File.join File.dirname(__FILE__), 'recipes', "#{name}.rb"
      end

      # TODO: Refactor loading of files

      def load_snippet(name, group)
        path = File.expand_path name, snippet_path(group)
        File.read path
      end

      def load_template(name, group, match={})
        path = File.expand_path name, template_path(group)
        contents = File.read path
        match.each do |key, value|
          contents.gsub! "\%#{key.to_s}\%", value
        end
        contents
      end

      def migrations
        Dir.new('db/migrate').entries
      end

      def have_migration?(name)
        !migrations.select{|t| t.include? name}.empty?
      end

      def snippet_path(name)
        File.join(File.dirname(__FILE__), 'snippets', name)
      end

      def template_path(name)
        File.join(File.dirname(__FILE__), 'templates', name)
      end
    end
  end
end

