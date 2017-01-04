class SettingsController < ApplicationController

  def index
    user = User.find_by(email: params[:email])

    if user
      render json:
              { ok: true,
                user: {
                  email: user.email,
                  name: user.name,
                  is_admin: user.admin,
                  locale: user.locale
                },
                available_locales: locale_name_pairs
              },
              status: :ok
    else
      render json: { ok: false, message: "User not found" }, status: :ok
    end
  end

  def edit
    byebug
  end

private
  def auth_params
    params.permit(:email, :password, :name, :locale)
  end

end
