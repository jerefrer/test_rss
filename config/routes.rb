RSSReader::Application.routes.draw do

  resources :items do
    # Définit une url du type "/items/1/mark_as", "member" voulant dire une url du type "/items/:id/action", 
    # càd contenant l'id d'un "membre" et effectuant une action sur un "membre" particulier.
    # L'autre option est "collection", donnant lieu à des urls du type "/items/action" (action sur plusieurs items, pas un en particulier)
    post :mark_as, on: :member
  end

  resources :fluxes
  
  resources :shared

  root :to => 'shared#index'
  
end
