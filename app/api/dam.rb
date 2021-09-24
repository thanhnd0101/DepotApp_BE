class Dam < Grape::API
  desc 'End-points for dam view'

  get do
    redirect "/api/documents"
  end
end