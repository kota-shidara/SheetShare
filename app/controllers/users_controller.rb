class UsersController < ApplicationController
  # ログインしていないユーザーのアクセスを拒否
  before_action :authenticate_user, {only: [:show, :edit, :update]}
  # ログインユーザーとアクセスしたURLに該当するユーザーが等しくなければアクセス拒否
  before_action :ensure_correct_user, {only: [:show, :edit, :update]}
  # ログインしているユーザーのアクセスを拒否
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to(root_path)
    else
      render("users/new")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to(root_path)
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to(login_path)
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
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to(root_path)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end