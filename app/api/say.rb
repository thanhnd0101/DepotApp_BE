class Say < Grape::API
  format :json
  desc 'End-points for say api'
  namespace :hello do
    desc 'Say hello'
    get do
      "Hello from rails: #{Time.now}"
    end
  end
end
