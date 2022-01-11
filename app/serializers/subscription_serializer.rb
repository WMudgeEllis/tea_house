class SubscriptionSerializer

  def self.new_subscription(subscription, teas)
    {
      data: {
        id: subscription.id,
        type: 'subscription',
        attributes: {
          title: subscription.title,
          price: subscription.price,
          frequency: subscription.frequency
        },
        teas: teas.map { |tea| TeaSerializer.tea_show(tea) }
      }
    }
  end
end
