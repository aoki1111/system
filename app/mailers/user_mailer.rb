class UserMailer < ApplicationMailer

    def account_activation(user)
        @user = user
        mail to: user.email, subject: "アカウント仮登録メール"
    end

    def password_reset(user)
      @user = user
      mail to: user.email, subject: "パスワードリセット"
    end
end
