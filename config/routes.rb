Greenblog::Application.routes.draw do

    devise_for :users, :controllers => {
        :sessions      => "users/sessions",
        :registrations => "users/registrations"
    }
  
    resources :users, :tags
  
    resources :posts do
        collection do
            get "feed.:format", :action => :feed
            get "search", :action => :search
        end
        
        resources :comments
    end
    
    resources :tags do
        member do
            get "feed.:format", :action => :feed
        end 
    end
    
    post "preview/convert"
  
    root :to => "posts#index"
    
    match '*not_found', to: 'errors#not_found'
end
