Rails.application.routes.draw do
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#So here we can see that the route is different, but the controller is the same, with different actions.

#first project
get 'welcome/home', to: 'welcome#home'
get 'welcome/about', to: 'welcome#about'


#second project
#for this to work i also need to change the link_to the /pages/home, in the about.html.erb,
#or it will return an error, when i press the about link.
root 'pages#home'


get 'about', to: 'pages#about'

end
