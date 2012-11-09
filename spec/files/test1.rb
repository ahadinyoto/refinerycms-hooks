require 'refinery/hooks/view'

module Refinery
  module Hooks
    class Test1Hook

      # Optional constructor
      def initialize
      end

      # Following instance variables are generated automatically
      # @hook_obj : the instance of Hook model
      # @page : the instance of Refinery Page
      def hook(args)
        # Write your hook here
        render_hook("Replaced-Test1Hook")
      end

    end
  end
end
