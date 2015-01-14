class SessionController < ApplicationController
  before_action :authorize_administrator, only: :index
  skip_before_action :authorize
  def new
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      redirect_to @user
    end
  end

  def create
    user = User.find_by(name: params[:name])   # params参数从浏览器获得
    if user and user.authenticate(params[:password])  # 参见下面图示
      session[:user_id] = user.id
      if Administrator.find_by(name: user.name)
        redirect_to admin_url
      else
        redirect_to user
      end
    else
      redirect_to login_url, alert: "用户名或密码不正确"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart_id] = nil
    redirect_to store_url, notice: "您已经退出登录"
  end
end
