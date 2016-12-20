class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_filter :set_locale

  def set_locale
    locale = if current_user
            current_user.settings.locale
          elsif params[:locale]
            session[:locale] = params[:locale]
          elsif session[:locale]
            session[:locale]
          else
            http_accept_language.compatible_language_from(I18n.available_locales)
          end
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end
end
