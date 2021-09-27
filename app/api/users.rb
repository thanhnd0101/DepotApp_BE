class Users < Grape::API
  desc 'End-points for user'

  params do
    requires :name, type: String
    requires :password, type: String
  end
  post do
    @user = User.create!({
                           name: params[:name],
                           password: params[:password]
                         })
  end

  params do
    requires :password, type: String
  end
  put '/:id' do
    @user = User.find(params[:id])
    @user.update({
                   password: params[:password]
                 })
  end

  get do
    User.order(:name).to_json
  end

  get '/:id' do
    @user = User.find(params[:id]).to_json
  end
end