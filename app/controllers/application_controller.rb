class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_action :set_locale

  def locale_name_pairs
    I18n.available_locales.map do |locale|
      {
        value: locale.to_s,
        label: I18n.t('language', locale: locale)
      }
    end
  end

  def set_locale
    locale = if current_user
               current_user.locale
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
