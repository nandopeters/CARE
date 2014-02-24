CarePath::Application.routes.draw do

  get "/patient_portal/home" => "patient_portal#home", :as => "patient_home"
  get "/provider_portal/home" => "provider_portal#home", :as => "provider_home"
	get "/vip/home" => "vip#home", :as => "vip_home"

	# authenticated :user do
	#   root :to => 'application#signed_in_root'
	# end
  root :to => "home#index"

  resque_constraint = lambda do |request|
    request.env['warden'].authenticate? and request.env['warden'].user.roles.first.name == "admin"
  end

  constraints resque_constraint do
    mount Resque::Server, :at => "/admin/resque"
  end
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end