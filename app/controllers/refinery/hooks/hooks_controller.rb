module Refinery
  module Hooks
    class HooksController < ::ApplicationController

      before_filter :find_all_hooks
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @hook in the line below:
        present(@page)
      end

      def show
        @hook = Hook.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @hook in the line below:
        present(@page)
      end

    protected

      def find_all_hooks
        @hooks = Hook.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/hooks").first
      end

    end
  end
end
