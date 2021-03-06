# frozen_string_literal: true

class SummaryController < ApplicationController
  def index
    @checkout = Checkout.find(params[:checkout_id])
    @coupom = current_user.coupoms.find_by(code: params[:coupom_code]) if params[:coupom_code]

    if @coupom
      @total_to_pay = @checkout.total - @coupom.value
      @checkout.order.coupom_code = @coupom.code
      @checkout.order.subtotal = if @total_to_pay.positive?
                                   @total_to_pay
                                 else
                                   0
                                 end
    else
      @total_to_pay = @checkout.total
      @checkout.order.subtotal = @total_to_pay
    end

    @checkout.save!
  end

  def create
    @checkout = Checkout.find(params[:checkout_id])
    update_stock
    @checkout.order.shipment_cost = @checkout.order.subtotal * 0.05
    @checkout.status = :pending_confirmation
    @checkout.completed = true
    @checkout.order.checkout_id = @checkout.id
    @checkout.save!

    mark_coupom_as_used

    @coupom = current_user.coupoms.find_by(code: @checkout.order.coupom_code) if @checkout.order.coupom_code

    if @coupom && (@checkout.order.subtotal - @coupom.value).negative?
      coupom_value = (@checkout.total - @coupom.value) * -1
      user = current_user
      code = rand(36**6).to_s(36)

      Coupom.create!(user: user, code: code, value: coupom_value, used: false)
    end

    # clear cart
    session.delete(:order_id)
    session[:checkout_id] = @checkout.id
    order = Order.new(user_id: current_user.id)
    order.save

    redirect_to root_path, notice: 'Compra efetuada com sucesso'
  end

  private

  def update_stock
    @checkout.order.order_items.each do |order_item|
      item_stock = order_item.stock

      item_stock.update(quantity: item_stock.quantity - order_item.quantity)
    end
  end

  def mark_coupom_as_used
    coupom = Coupom.find_by(code: @checkout.order.coupom_code)
    coupom.used = true if coupom
    coupom&.save!
  end
end
