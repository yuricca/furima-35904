class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :town, :house_number, :building, :phone_number).merge(user_id: current_user.id)
  end
end
