class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      format_ids.each do |tea_id|
        TeaSubscription.create!(tea_id: tea_id, subscription_id: subscription.id)
      end
      render json: SubscriptionSerializer.new_subscription(subscription, subscription.teas)
    else
      render json: subscription.errors.to_sentence, status: 400
    end
  end

  def update
    subscription = Subscription.find(subscription_params[:id])
    if subscription.update(subscription_params)
      render json: SubscriptionSerializer.subscription_show(subscription)
    else
      render json: subscription.errors.to_sentence, status: 400
    end
  end

  def index
    customer = Customer.find(params[:customer_id])
    active_subscriptions = customer.active_subscriptions
    cancelled_subscriptions = customer.cancelled_subscriptions
    render json: SubscriptionSerializer.subscription_index(active_subscriptions, cancelled_subscriptions)
  end

  private
  def format_ids
    if params[:tea_ids].class == String
      params[:tea_ids].delete('[]').split(',')
    else
      params[:tea_ids]
    end
  end

  def subscription_params
    params.permit(:customer_id, :title, :price, :frequency, :status, :id)
  end


end
