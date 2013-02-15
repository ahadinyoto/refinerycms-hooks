module Refinery
  module Hooks
    class ScaffoldGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      argument :name, :type => :string
      argument :tag, :type => :string

      def register
        if behavior == :invoke
          @hook = Refinery::Hooks::Hook.register_hook({:name => name, :tag => tag, :status => "enabled"}) 

          # Class name to be generated
          @klass = @hook.get_class_string.gsub /(\w+::)+(\w+)$/ do |m|
            m = $2
          end
          puts "Generated class name is: #{@klass}"
        elsif behavior == :revoke
          @hook.destroy
        end
      end

      def create_base_hook
        template "hook.rb", Refinery::Hooks.config.hook_path.join("#{tag}.rb")
      end

      def create_base_hook_view
        template "views/hook.html.erb", Refinery::Hooks.config.hook_view_path.join("#{tag}.html.erb")
      end
    end
  end
end
