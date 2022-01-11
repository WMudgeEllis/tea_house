class SubscriptionSerializer

  def self.new_subscription(subscription, teas)
    {
      data: {
        id: subscription.id,
        type: 'subscription',
        attributes: {
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
      data: {
        id: subscription.id,
        type: 'subscription',
        attributes: {
          title: subscription.title,
          price: subscription.price,
          frequency: subscription.frequency,
          status: subscription.status
        }
      }
    }
  end
end
