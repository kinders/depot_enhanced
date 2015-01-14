class ShipsController < ApplicationController
  before_action :authorize_administrator, only: :index
  before_action :set_ship, only: [:show, :edit, :update, :destroy]

  # GET /ships
  # GET /ships.json
  def index
    @ships = Ship.all
  end

  # GET /ships/1
  # GET /ships/1.json
  def show
    if @ship.order.user.id != session[:user_id]
      redirect_to @ship.order.user, notice: '无效页面'
    end
  end

  # GET /ships/new
  def new
    @ship = Ship.new
    @ship.order_id = params[:order_id]
    @want_ship_order = Order.find_by(id: params[:order_id])
    @want_ship_products = []
    @ship.order.line_items.each do |l|
      @want_ship_products << [l.product.title, l.price, l.quantity]
    end
  end

  # GET /ships/1/edit
  def edit
  end

  # POST /ships
  # POST /ships.json
  def create
    @ship = Ship.new(ship_params)
    @ship.order.update(is_ship: "t")
    respond_to do |format|
      if @ship.save
        format.html { redirect_to @ship, notice: 'Ship was successfully created.' }
        format.json { render :show, status: :created, location: @ship }
      else
        format.html { render :new }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ships/1
  # PATCH/PUT /ships/1.json
  def update
    respond_to do |format|
      if @ship.update(ship_params)
        format.html { redirect_to @ship, notice: 'Ship was successfully updated.' }
        format.json { render :show, status: :ok, location: @ship }
      else
        format.html { render :edit }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ships/1
  # DELETE /ships/1.json
  def destroy
    @ship.destroy
    respond_to do |format|
      format.html { redirect_to ships_url, notice: 'Ship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm_receive
    @ship = Ship.find(params[:id])
    @ship.update(is_receive: "t")
    @ship.order.update(is_end: "t")
    respond_to do |format|
      format.html { redirect_to @ship.order.user, notice: '恭喜您收到货物！' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ship
      @ship = Ship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ship_params
      params.require(:ship).permit(:order_id, :send_date, :sender, :express_company, :express_number, :is_receive)
    end
end
