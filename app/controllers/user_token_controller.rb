class UserTokenController < Knock::AuthTokenController
  before_action :authenticate

  def create
    user = User.find_by(email: auth_params[:email])
    render json: { ok: true, user: { email: user.email, name: user.name, is_admin: user.admin, jwt: auth_token.token } }, status: :created
  end

private
  def authenticate
    unless entity.present? && entity.authenticate(auth_params[:password])
      render json: { ok: false, message: "User not found" }, status: :ok
    end
  end

end
