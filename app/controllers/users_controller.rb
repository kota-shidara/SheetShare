class UsersController < ApplicationController
  # ログインしていないユーザーのアクセスを拒否
  before_action :forbid_unlogged_in_user, {only: [:show, :edit, :update]}
  # ログインユーザーとアクセスしたURLに該当するユーザーが等しくなければアクセス拒否
  before_action :ensure_correct_user, {only: [:show, :edit, :update]}
  # ログインしているユーザーのアクセスを拒否
  before_action :forbid_logged_in_user, {only: [:new, :create]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to(root_path)
    else
      render("users/new")
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to(root_path)
    else
      render("users/edit")
    end
  end

  # ログインユーザーとアクセスしたURLに該当するユーザーが等しくなければアクセス拒否
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:notice] = "権限がありません"
      redirect_to(root_path)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end