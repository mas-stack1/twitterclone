class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "メッセージを投稿しました。"
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = "メッセージの投稿に失敗しました。"
      render "toppages/index"
    end
  end
  
  def edit
    @micropost = Micropost.find(params[:id])
  end
  
  def update
    @micropost = Micropost.find(params[:id])
   
    if @micropost.update(content:params[:micropost])
      flash[:success] = "メッセージの編集に成功しました"
      redirect_to root_url
    else
      flash.now[:danger] = "メッセージの編集に失敗しました。"
      render "toppages/index"
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    if @micropost.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
end
