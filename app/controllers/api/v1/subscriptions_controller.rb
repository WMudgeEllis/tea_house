class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      format_ids.each do |tea_id|
        TeaSubscription.create!(tea_id: tea_id, subscription_id: subscription.id)
      end

      render json: SubscriptionSerializer.new_subscription(subscription, subscription.teas)
    else
      render json: subscription.errors, status: 400
    end

  end

  private
  def format_ids
    if params[:tea_ids].class == String
      params[:tea_ids].split(',')
    else
      params[:tea_ids]
    end
  end

  def subscription_params
    params.permit(:customer_id, :title, :price, :frequency)
  end


end
