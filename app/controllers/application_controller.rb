class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_filter :set_locale

  def url_options
    {locale: I18n.locale}.merge super
  end

  def self.default_url_options
    {locale: I18n.locale}
  end

  def authorize_admin
    if player_signed_in?
      unless current_player.admin?
        redirect_to root_path, flash: {error: I18n.t('access_denied')}
      end
    else
      authenticate_player!
    end
  end

private
  def set_locale
    I18n.locale = params[:locale] || :pl
  end
end
