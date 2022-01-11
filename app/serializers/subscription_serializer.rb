class SubscriptionSerializer

  def self.new_subscription(subscription, teas)
    {
      data: {
        id: subscription.id,
        type: 'subscription',
        attributes: {
          customer_id: subscription.customer_id,
          title: subscription.title,
          price: subscription.price,
          frequency: subscription.frequency,
          status: subscription.status
        },
        teas: teas.map { |tea| TeaSerializer.tea_show(tea) }
      }
    }
  end

  def self.subscription_show(subscription)
    {
      data: subscription_hash(subscription)
    }
  end

  def self.subscription_index(active, cancelled)
    {
      data: {
        active_subscriptions: active.map { |subscription| subscription_hash(subscription) },
        cancelled_subscriptions: cancelled.map { |subscription| subscription_hash(subscription) }
      }
    }
  end

  def self.subscription_hash(subscription)
    {
      id: subscription.id,
      type: 'subscription',
      attributes: {
        customer_id: subscription.customer_id,
        title: subscription.title,
        price: subscription.price,
        frequency: subscription.frequency,
        status: subscription.status
      }
    }
  end
end
