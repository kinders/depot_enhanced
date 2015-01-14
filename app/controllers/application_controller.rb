class ApplicationController < ActionController::Base
  before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected
  def authorize
    if User.count.zero?
      redirect_to  new_user_path, notice: "请先创建一个账号"
    else
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: '请先登录网站'
      end
    end
  end
  def authorize_administrator
    user = User.find_by(id: session[:user_id])
    if Administrator.count.zero?
      @first_administrators = Administrator.new(name: User.order(:id).first.name)
      @first_administrators.save!
      redirect_to user, notice: '欢迎回来'
    else
      unless Administrator.find_by(name: user.name)
        redirect_to user, notice: '欢迎回来'
      end
    end
  end
end
