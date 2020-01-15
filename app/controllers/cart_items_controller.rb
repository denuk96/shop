class CartItemsController < ApplicationController
  before_action :user_logged_in?
  before_action :set_cart
  before_action :set_cart_item, only: %i[destroy increase_cart_item decrease_cart_item]

  def create
    @product = Product.find_by(id: params[:product_id])
    if @cart.cart_items.find_by(product_id: params[:product_id], price: @product.price).present?
      if item_exist_and_same_price?
        @cart_item.quantity += 1
      else
        @cart_item = CartItem.new(cart_id: @cart.id, product_id: params[:product_id], price: @product.price)
      end
    else
      @cart_item = CartItem.new(cart_id: @cart.id, product_id: params[:product_id], price: @product.price)
    end
    if @cart_item.save
      redirect_to request.referrer, notice: 'added to cart'
    else
      redirect_to request.referrer, alert: @cart_item.errors.full_messages.first
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to request.referrer, notice: 'removed'
  end

  def increase_cart_item
    @cart_item.quantity += 1
    @cart_item.save
    redirect_to request.referrer
  end

  def decrease_cart_item
    @cart_item.quantity -= 1
    if @cart_item.quantity > 0
      @cart_item.save
      redirect_to request.referrer
    else
      destroy
    end
  end

  private

  def set_cart_item
    @cart_item = CartItem.find_by(id: params[:id], cart_id: @cart.id)
  end

  # if customer adds product to cart with x price, it'd keep price x for current product
  # even we change it. If product price and cart_item price equal, quantity increases,
  # otherwise it creates another one cart item in create method
  def item_exist_and_same_price?
    cart_items = CartItem.where(product_id: params[:product_id], cart_id: @cart.id)
    cart_items.each do |cart_item|
      @cart_item = cart_item if @product.price == cart_item.price
    end
  end
end
