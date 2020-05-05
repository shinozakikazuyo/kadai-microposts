class MicropostsController < ApplicationController
  
  #ログインが必須
  before_action :require_user_logged_in
  #destroy アクションが実行される前にユーザーをチェック
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end


  def destroy
    #correct_userメソッドで取得した@micropostをdestroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    #アクションが実行されたページに戻る
    redirect_back(fallback_location: root_path)
  end
  
  
  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    #nilかfalseの時に実行される
    unless @micropost
      redirect_to root_url
    end
  end
  
end
