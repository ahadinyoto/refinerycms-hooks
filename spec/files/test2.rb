require 'refinery/hooks/view'

module Refinery
  module Hooks
    class Test2Hook

      # Optional constructor
      def initialize
      end

      # Following instance variables are generated automatically
      # @hook_obj : the instance of Hook model
      # @page : the instance of Refinery Page
      def hook(args)
        @data = "Replaced-Test2Hook"
      end

    end
  end
end
