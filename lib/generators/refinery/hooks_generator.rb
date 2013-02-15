module Refinery
  class HooksGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    def copy_initializer
      copy_file 'hooks.rb', "config/initializers/refinery/hooks.rb"
      empty_directory File.join('app', 'hooks', 'views')
    end

    def rake_db
      rake("refinery_hooks:install:migrations")
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS Hooks extension
Refinery::Hooks::Engine.load_seed
        EOH
      end
    end
  end
end
