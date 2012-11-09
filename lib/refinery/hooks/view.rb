require 'refinery/hooks/processor'

module Refinery
  module Hooks
    class View
      def render(hook_obj)
        view_file = "#{Refinery::Hooks.config.hook_view_path}/#{hook_obj.tag}.html.erb"
        if File.exists?(view_file)
          template = ERB.new( File.read("#{view_file}") )
          template.result binding
        end
      end
    end
  end
end
