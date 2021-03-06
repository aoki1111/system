class AccountActivationsController < ApplicationController
  
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "アカウントの有効化が完了しました。"
      redirect_to dashboard_path
    else
      flash[:danger] = "メールのURLが無効になっています。"
      redirect_to root_url
    end
  end
end
