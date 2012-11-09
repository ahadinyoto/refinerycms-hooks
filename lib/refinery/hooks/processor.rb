module Refinery
  module Hooks
    class Processor

      def initialize(tag)
        @hook_path = Refinery::Hooks.config.hook_path
        @hook_view_path = Refinery::Hooks.config.hook_view_path

        @hook = Hook.find_by_tag(tag)
        if @hook.nil?
          Rails.logger.debug("[Error] Refinery::Hooks - hook for tag #{tag} is not found.")
          raise "Hook is not found"
        end
        Dir["#{Refinery::Hooks.config.hook_path}/*.rb"].each do |file|
          require file
        end
        begin
          @klass = eval(@hook.get_class_string)
        rescue => ex
          Rails.logger.debug(ex.inspect)
        end

        # Add the "render_hook" method
        @klass.class_eval do
          attr_accessor :render_hook_called
          attr_accessor :render_hook_text

          def render_hook(text)
            @render_hook_called = true
            @render_hook_text = text
          end
        end

      end

      def run_hook(page, tag_args)
        return "" if @hook.disabled?
        return @hook.alt if @hook.disabled_with_alt?

        hookobj = @klass.new
        hookobj.instance_variable_set(:@hook_obj, hookobj)
        hookobj.instance_variable_set(:@page, page)

        hookobj.hook(tag_args)

        ivs = hookobj.instance_variables
        view = Refinery::Hooks::View.new

        ivs.each do |iv|
          view.instance_variable_set(iv, hookobj.instance_variable_get(iv))
        end

        if hookobj.render_hook_called
          hookobj.render_hook_text
        else
          view.render(@hook)
        end
      end
    end

  end
end
