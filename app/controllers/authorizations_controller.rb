class AuthorizationsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: authorization_params[:email])

    logger.debug(user.inspect)

    if user&.authenticate(authorization_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました!"
    else
      logger.debug('失敗しました')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)

    # 全部消したい場合
    # reset_sesion

    redirect_to root_path, notice: "ログアウトしました"
  end

  private

  def authorization_params
    params.require(:authorization).permit(:email, :password)
  end
end
