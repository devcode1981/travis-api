module Travis::API::V3
  class Models::V2Subscription
    include Models::Owner

    attr_reader :id, :plan, :permissions, :status, :source, :billing_info, :credit_card_info, :owner, :payment_intent, :addons, :created_at

    def initialize(attributes = {})
      @id = attributes.fetch('id')
      plan_data = attributes.fetch('plan_config')
      @plan = plan_data && Models::V2PlanConfig.new(plan_data)
      @permissions = Models::BillingPermissions.new(attributes.fetch('permissions'))
      @status = 'subscribed'
      @source = attributes.fetch('source')
      @billing_info = attributes['billing_info'] && Models::BillingInfo.new(@id, attributes['billing_info'])
      @credit_card_info = attributes['credit_card_info'] && Models::CreditCardInfo.new(@id, attributes['credit_card_info'])
      @payment_intent = attributes['payment_intent'] && Models::PaymentIntent.new(attributes['payment_intent'])
      @owner = fetch_owner(attributes.fetch('owner'))
      @addons = attributes.fetch('addons')
      @created_at = attributes.fetch('created_at')
    end
  end
end
