class Sessions < Grape::API
  desc 'End-points for user session'

  params do
    requires :name, type: String
    requires :password, type: String
  end
  post do
    result = AuthenticationUserService.call(params[:name], params[:password] )

    if result.present?
      {
        auth_token: result[:auth_token],
        id: result[:user_id],
      }
    else
      redirect '/api/login'
    end
  end

  delete do
    redirect '/api/login'
  end
end