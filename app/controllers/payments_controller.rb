class PaymentsController < ApplicationController
  def show
  end

  def create
    Stripe.api_key = 'sk_test_51KlTTvC0nawSk6U4e4GFZZ0t2guUFeQqjikgeZiNAqov2tE3PwagFNAgzRtfKxgFvj88WOj70P2a6fX0yp0ceFwb00Yayw2hQA'

    session = Stripe::Checkout::Session.create({
      line_items: [{
        # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
        price: 'price_1KmFqHC0nawSk6U4po8GeUgL',
        quantity: 1,
      }],
      mode: 'payment',
      success_url: 'https://www.google.com',
      cancel_url: 'https://www.google.com'
    })

    

    redirect_to session.url
  end

end
