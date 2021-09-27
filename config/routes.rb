Rails.application.routes.draw do
  get 'say/hello'

  get 'say/goodbye'

  mount API => '/api'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '(:locale)' do

  end
end
