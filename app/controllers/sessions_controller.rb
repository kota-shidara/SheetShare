class SessionsController < ApplicationController
# ログインしているユーザーのアクセスを拒否
before_action :forbid_logged_in_user, {only: [:new, :create]}

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = "ログインしました"
      redirect_to(root_path)
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render("sessions/new")
    end
  end

  def delete
    log_out
    flash[:notice] = "ログアウトしました"
    redirect_to(login_path)
  end

end
