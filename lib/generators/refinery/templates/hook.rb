require 'refinery/hooks/view'

module Refinery
  module Hooks
    class <%= @klass %>

      # Optional constructor
      def initialize
      end

      # Following instance variables are generated automatically
      # @hook_obj : the instance of Hook model
      # @page : the instance of Refinery Page
      def hook(args)
        # Write your hook here
      end

    end
  end
end
