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
  end
  
end
