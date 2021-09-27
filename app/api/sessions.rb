class Sessions < Grape::API
  desc 'End-points for user session'

  post do
    user = User.find_by(name: params[:name])

    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect '/api/admin'
    else
      redirect '/api/login'
    end
  end

  delete do
    session[:user_id] = nil
    redirect '/api/login'
  end
end