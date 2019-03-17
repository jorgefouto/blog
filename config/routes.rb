Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#So here we can see that the route is different, but the controller is the same, with different actions.

get 'welcome/home', to: 'welcome#home'
get 'welcome/about', to: 'welcome#about'

end
