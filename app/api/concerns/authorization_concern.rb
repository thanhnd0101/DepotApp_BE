module AuthorizationConcern

  private

  def authorize
    if !request.headers['Authorization'].present? || !AuthorizeApiRequestService.call(request.headers)
      redirect '/api/login'
    end
  end

end