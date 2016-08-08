class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_admin

  private
  def check_admin
    unless admin_install?
      redirect_to root_path
    end
  end

  def admin_install?
    ENV['HL7_TOOL_EDITING'] == 'TRUE'
  end
end
