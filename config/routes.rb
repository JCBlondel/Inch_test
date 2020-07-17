Rails.application.routes.draw do
  root 'pages#home'
  post :import, to: 'pages#import'
end
