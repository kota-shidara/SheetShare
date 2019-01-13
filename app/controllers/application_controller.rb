class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user
  
  include SessionsHelper

  def set_current_user
    @current_user = current_user
  end

  # # ログインしていないユーザーのアクセスを拒否
  def forbid_unlogged_in_user
    if !logged_in?
      flash[:notice] = "ログインが必要です"
      redirect_to(root_path)
    end
  end

  # # ログインしているユーザーのアクセスを拒否
  def forbid_logged_in_user
    if logged_in?
      flash[:notice] = "すでにログインしています"
      redirect_to(root_path)
    end
  end

end