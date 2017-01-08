class SettingsController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user
      user_for_response
    else
      render json: { ok: false, message: "User not found" }, status: :ok
    end
  end

  def edit
    if current_user.update(auth_params)
      user_for_response
    else
      render json: { ok: false, message: current_user.errors.full_messages }, status: :ok
    end
  end

  def user_for_response
    render json:
            { ok: true,
              user: {
                email: current_user.email,
                name: current_user.name,
                is_admin: current_user.admin,
                locale: current_user.locale,
              },
              available_locales: locale_name_pairs
            },
            status: :ok
  end

private
  def auth_params
    params.permit(:email, :password, :name, :locale)
  end
end
