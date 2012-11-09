module Refinery
  module Hooks
    module Admin
      class HooksController < ::Refinery::AdminController

        crudify :'refinery/hooks/hook',
                :title_attribute => 'name', :xhr_paging => true


        def new
          render :text => "Hook is not allowed to be created from the web interface."
        end

        def create
          render :text => "Hook is not allowed to be created from the web interface."
        end

        # Find all the pages that contain this hook
        def find_pages
          @hook = Refinery::Hooks::Hook.find(params[:id])
          @pages = @hook.find_in_all_pages
        end

      end
    end
  end
end
