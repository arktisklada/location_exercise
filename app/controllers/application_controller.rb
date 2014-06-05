class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_xhr


  protected

  def check_xhr
    @is_xhr = request.xhr? ? true : false
  end
end
