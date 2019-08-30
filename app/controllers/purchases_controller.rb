class PurchasesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    if current_user.id != @product.user.id
      @customer = Payjp::Customer.retrieve(current_user.customer_id)
      card = @customer.cards.data[0]
      # カードが複数ある場合にどのカードを選ぶのかは問題だが、とりあえず一番目
      @brand = card.brand
      @last4 = card.last4
      @month = card.exp_month
      @year = card.exp_year
    else
      redirect_to root_path
    end
  end

  def create
    @product = Product.find(params[:product_id])
    if current_user != @product.user && @product.purchase_status_id == 1
      charge = Payjp::Charge.create(
        amount: @product.price,
        customer: current_user.customer_id,
        currency: 'jpy',
      )
      Purchase.create(purchase_id:charge.id,product_id: params[:product_id],user_id:current_user.id)
      @product.update(purchase_status_id: 2)
      redirect_to root_path
    else
      redirect_to  new_product_purchase_path(@product.id)
    end
  end

  private

  def purchase_params
    params.permit(:product_id).merge(current_user.id,current_user.customer_id)
  end
end
