class ApplicationController < ActionController::Base
  
  #Controller から Helper のメソッドを使うことができないためinclude
  include SessionsHelper
  
  private

  def require_user_logged_in
    #includeしたから使用できるようになる
    unless logged_in?
      redirect_to login_url
    end
  end
  
  
  def counts(user)
    @count_microposts = user.microposts.count
    #フォロワー数
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    #お気に入り数
    @count_favarite = user.likes.count
  end
  
end
