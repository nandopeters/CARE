Stripe.api_key = ENV["STRIPE_TEST_API_KEY"]
STRIPE_PUBLIC_KEY = ENV["STRIPE_TEST_PUBLIC_KEY"]

StripeEvent.setup do
  subscribe 'customer.subscription.deleted' do |event|
    user = User.find_by_customer_id(event.data.object.customer)
    user.expire
  end

  subscribe 'charge.failed' do |event|
  	user = User.find_by_customer_id(event.data.object.customer)
  	# The charge failed, so put the charge back to 'pending' or something and
  	# try to charge them again...
  end
end