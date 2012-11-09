require 'refinerycms-core'

module Refinery
  autoload :HooksGenerator, 'generators/refinery/hooks_generator'

  module Hooks
    require 'refinery/hooks/engine'

    include ActiveSupport::Configurable

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end
