module Path
  def get_http_path(sub_path)
    "http://#{request.host_with_port}#{sub_path}"
  end
end