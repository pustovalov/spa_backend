class UserTokenController < Knock::AuthTokenController
  before_action :authenticate
  skip_before_action :authenticate, only: [:sign_up]

  def login
    user = User.find_by(email: auth_params[:email])
    render json: { ok: true, user: { email: user.email, name: user.name, is_admin: user.admin, jwt: auth_token.token } }, status: :created
  end

  def sign_up
    user = User.new(auth_params)
    if user.save
      render json: { ok: true, user: { email: user.email, name: user.name, is_admin: user.admin, jwt: auth_token.token } }, status: :created
    else
      render json: { ok: false, message: user.errors.full_messages }, status: :ok
    end
  end

private
  def authenticate
    unless entity.present? && entity.authenticate(auth_params[:password])
      render json: { ok: false, message: "User not found" }, status: :ok
    end
  end

  def auth_params
    params.require(:auth).permit(:email, :password, :name)
  end

end
