class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show,:edit,:update, :followings, :followers]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find_by(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @microposts = Micropost.find_by(id:@user.id)
    if @user.update(name:params[:name],email:params[:email])
      flash[:success] = "ユーザ情報を編集しました。"
      redirect_to @user
    else
      flash[:danger] = "ユーザ情報の編集に失敗しました。"
      render "toppages/index"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
      if @user.destroy
        flash[:success] = "ユーザを退会しました"
        redirect_to root_url
      else
        flash.now[:danger] = "ユーザの退会に失敗しました"
        render "tppages/index"
      end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @favoritings = @user.favoritings.page(params[:page])
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end