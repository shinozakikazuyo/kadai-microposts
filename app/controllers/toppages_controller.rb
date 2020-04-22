class ToppagesController < ApplicationController
  def index
    if logged_in?
      
      #form_with用
      @micropost = current_user.microposts.build  
      #一覧表示
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
      
    end
  end
end