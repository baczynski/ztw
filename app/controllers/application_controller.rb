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

private
  def set_locale
    I18n.locale = params[:locale] || :pl
  end
end
