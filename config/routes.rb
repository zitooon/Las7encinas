ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

    map.resource :login, :controller => 'login'

    # Sample resource route within a namespace:
    map.namespace :admin do |admin|
      admin.resources :invitations
      admin.resources :contents
      admin.resources :picture_categories
      admin.resources :pictures, :collection => {:search => :get, :albums => :get}
      admin.root :controller => 'invitations', :action => 'index'
    end

    map.root :controller => 'contents', :action => 'on_the_table'

    %w(spain the_estate olive_trees variety preparation las_7_encinas on_the_table contact).each do |r|
      map.send(r.to_sym, r, {:controller => 'contents', :action => r})
    end
      
    map.resource :gallery, :controller => 'gallery', :only => [:show], :member => {:album => :get}

    # Sample of regular route:
    #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
    # Keep in mind you can assign values other than :controller and :action

    # Sample of named route:
    #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
    # This route can be invoked with purchase_url(:id => product.id)

    # Install the default routes as the lowest priority.
    # Note: These default routes make all actions in every controller accessible via GET requests. You should
    # consider removing or commenting them out if you're using named routes and resources.
    map.connect ':controller/:action/:id'
    map.connect ':controller/:action/:id.:format'
end
