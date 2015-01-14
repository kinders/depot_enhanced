class LineItemsController < ApplicationController
  before_action :authorize_administrator, only: :index
  skip_before_action :authorize, only: :create
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    if @line_item.cart.id != session[:cart_id]
      redirect_to store_url, notice: '无效项目'
    end
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id]) 
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        # format.html { redirect_to @line_item.cart, notice: 'Line item was successfully created.' }
        format.html { redirect_to store_url, notice: "#{@line_item.product.title} 已经放入我的购物车！" }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        if @line_item.quantity == 0
	  @line_item.destroy
        end
        format.html { redirect_to @line_item.cart, notice: "购物车中#{@line_item.product.title}的数量已经更新" }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @line_item.cart, notice: "商品“#{@line_item.product.title}”已经从购物车中删除"}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity)
    end
end
