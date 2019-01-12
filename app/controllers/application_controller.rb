class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  # ログインしているユーザーを特定
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # ログインしていないユーザーのアクセスを拒否
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/")
    end
  end

  # ログインしているユーザーのアクセスを拒否
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/")
    end
  end

end