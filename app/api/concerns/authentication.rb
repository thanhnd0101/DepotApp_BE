module Authentication

  private

  def authorize
    redirect '/api/login' unless User.find_by(id: session[:user_id])
  end

end