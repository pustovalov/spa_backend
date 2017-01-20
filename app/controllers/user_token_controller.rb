class UserTokenController < Knock::AuthTokenController
  skip_before_action :authenticate

  def login
    user = User.find_by(email: auth_params[:email])
    if user
      user_for_response
    else
      render json: { ok: false, message: "User not found" }, status: :ok
    end
  end

  def sign_up
    user = User.new(auth_params)
    if user.save
      user_for_response
    else
      render json: { ok: false, message: user.errors.full_messages }, status: :ok
    end
  end

  def user_for_response
    render json:
            { ok: true,
              user: {
                email: user.email,
                name: user.name,
                is_admin: user.admin,
                locale: user.locale,
              },
              jwt: auth_token.token,
            },
           status: :ok
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
