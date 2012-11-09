Refinery::Core::Engine.routes.append do

  # Frontend routes
  # namespace :hooks do
  #   resources :hooks, :path => '', :only => [:index, :show]
  # end

  # Admin routes
  namespace :hooks, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :hooks, :except => :show do
        member do
          get :find_pages
        end
        collection do
          post :update_positions
        end
      end
    end
  end

end
