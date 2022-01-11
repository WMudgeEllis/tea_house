class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      params[:tea_ids].each do |tea_id|
        TeaSubscription.create!(tea_id: tea_id, subscription_id: subscription.id)
      end
      render json: SubscriptionSerializer.new_subscription(subscription, subscription.teas)
    end
  end

  private
  def subscription_params
    params.permit(:customer_id, :title, :price, :frequency)
  end


end
