class StoreController < ApplicationController
  skip_before_action :authorize
  def index
    @products = Product.order(:title)
    if session[:user_id]
      @user_name = User.find_by(id: session[:user_id]).name
    end
  end
end
