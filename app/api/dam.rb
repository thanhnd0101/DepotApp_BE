class Dam < Grape::API
  desc 'End-points for dam view'

  helpers CurrentCart

  before do
    authorize
  end
  get do
    user = AuthorizeApiRequestService.call(request.headers)
    redirect "/api/users/#{user.id}/documents"
  end


end