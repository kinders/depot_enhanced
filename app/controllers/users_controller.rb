class UsersController < ApplicationController
  before_action :authorize_administrator, only: :index
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if @user.id != session[:user_id]
      @real = User.find_by(id: session[:user_id])
      respond_to do |format|
        format.html {redirect_to @real, notice: '无效用户'}
      end
    end
    @total_orders = Order.count
    @my_orders = Order.where("user_id = #{@user.id}")
    @my_total_orders = @my_orders.count
    @my_unend_products = []
    @my_ended_products = []
    @my_orders.each do |order|
      if order.is_end
        order.line_items.each do |line_item|
          @my_ended_products << [order.id, line_item.product.title, line_item.price, line_item.quantity, line_item.created_at.to_s(:db), order.ship.first.id]
        end
      else
        order.line_items.each do |line_item|
          if order.is_ship
            @my_unend_products << [order.id, line_item.product.title, line_item.price, line_item.quantity, line_item.created_at.to_s(:db), order.is_ship, order.ship.first.id]
          else
            @my_unend_products << [order.id, line_item.product.title, line_item.price, line_item.quantity, line_item.created_at.to_s(:db), order.is_ship]
	  end
        end
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to store_url, notice: "用户 #{@user.name} 已经成功注册" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    current_password = params[:user].delete(:current_password)
    respond_to do |format|
      if @user.update(user_params) && @user.authenticate(current_password)
        format.html { redirect_to users_url, notice: '您的客户信息已经更新完毕' }
        format.json { render :show, status: :ok, location: @user }
      else
        @user.errors.add(:current_password, "不正确")
        format.html { render :edit, notice: '密码不正确' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      @user.destroy
      flash[:notice] = "用户#{@user.name}已经被删除"
    rescue StandardError => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    # 阻止暴露无效用户
    def invalid_user
      logger.error "Attempt to access invalid user #{params[:id]}"
      redirect_to login_path, notice: '登录错误'
    end
end
