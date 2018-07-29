class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if @user && @user.authenticate(params[:session][:password])
            if @user.activated?
              log_in @user
              params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
              redirect_back_or dashboard_path
            else
              message  = "登録時に配信されたメールからアカウントの有効化を行ってください。"
              message += "メールが届いていない場合は、お手数ですがお問い合わせよりご連絡ください。"
              flash[:warning] = message
              redirect_to root_url
            end
        else
            flash.now[:danger] = 'メールアドレスが存在しないか、パスワードが間違っています。'
            render 'new'
        end
    end

    def destroy
        log_out if logged_in?
        redirect_to root_url
    end
end
