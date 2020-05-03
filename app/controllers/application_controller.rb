class ApplicationController < ActionController::Base
    helper_method :current_user  #ヘルパーメソッドを定義することで全てのビューから使える

    private

    # コントローラーを共通で使える
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
end