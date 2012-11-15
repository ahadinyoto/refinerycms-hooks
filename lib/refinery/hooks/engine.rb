module Refinery
  module Hooks
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Hooks

      engine_name :refinery_hooks

      initializer "register refinerycms_hooks plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "hooks"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.hooks_admin_hooks_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/hooks/hook',
            :title => 'name'
          }
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Hooks)
        Rails.logger.debug("=/=====> #SEND")
      end
    end
  end
end
