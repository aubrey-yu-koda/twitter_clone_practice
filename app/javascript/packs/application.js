// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


require('jquery')

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import $ from 'jquery'
// import "controllers"

// window.initMap = function(...args){
//     const event = document.createEvent("Events")
//     event.initEvent("google-maps-callback", true, true)
//     event.args = args
//     window.dispatchEvent(event)
// }

$(document).ready(function() {
  $('#tabs li').on('click', function() {
    var tab = $(this).data('tab');

    $('#tabs li').removeClass('is-active');
    $(this).addClass('is-active');

    $('#tab-content section').removeClass('is-active');
    $('section[data-content="' + tab + '"]').addClass('is-active');
  });

  // This is your test publishable API key.
  const stripe = Stripe("pk_test_51KlTTvC0nawSk6U4hdGPBQk8AFjVzHAHookAXlzxiUf2eGZKrqxqqeZLZsFFBeoPuscVOjIrwbRfXIuboyAMlrnv00rdhZoLVL");
  // var 
  // The items the customer wants to buy
  // const items = [{ id: "xl-tshirt" }];

  // let elements = stripe.elements({
  //   clientSecret: 'sk_test_51KlTTvC0nawSk6U4e4GFZZ0t2guUFeQqjikgeZiNAqov2tE3PwagFNAgzRtfKxgFvj88WOj70P2a6fX0yp0ceFwb00Yayw2hQA',
  // });
  var elements = stripe.elements();
  var cardElement = elements.create('card');
  cardElement.mount('#card-element');

  const form = document.querySelector('#payment-form');

  initialize();
  checkStatus();

  document
    .querySelector("#payment-form")
    .addEventListener("submit", handleSubmit);

  // Fetches a payment intent and captures the client secret
  async function initialize() {
    const response = await fetch("/create-payment-intent", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ 
        paymentMethodType: 'card',
        currency: 'ph'
       }),
    }).then(r=>r.json());
    const { clientSecret } = await response.json();

    const appearance = {
      theme: 'stripe',
    };
    elements = stripe.elements({ appearance, clientSecret });

    const paymentElement = elements.create("payment");
    paymentElement.mount("#payment-element");
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setLoading(true);

    const { error } = await stripe.confirmPayment({
      elements,
      confirmParams: {
        // Make sure to change this to your payment completion page
        return_url: "http://localhost:3000/checkout.html",
      },
    });

    // This point will only be reached if there is an immediate error when
    // confirming the payment. Otherwise, your customer will be redirected to
    // your `return_url`. For some payment methods like iDEAL, your customer will
    // be redirected to an intermediate site first to authorize the payment, then
    // redirected to the `return_url`.
    if (error.type === "card_error" || error.type === "validation_error") {
      showMessage(error.message);
    } else {
      showMessage("An unexpected error occured.");
    }

    setLoading(false);
  }

  // checkout.js
  // Fetches the payment intent status after payment submission
  async function checkStatus() {
    const clientSecret = new URLSearchParams(window.location.search).get(
      "payment_intent_client_secret"
    );

    if (!clientSecret) {
      return;
    }

    // const { paymentIntent } = await stripe.retrievePaymentIntent(clientSecret);
    const { paymentIntent } = await stripe.confirmCardPayment(
      clientSecret, {
        payment_method: {
          card: cardElement,
          billing_details: {
            name: nameInput.value,
            email: emailInput.value,
          }
        }
      });
    switch (paymentIntent.status) {
      case "succeeded":
        showMessage("Payment succeeded!");
        break;
      case "processing":
        showMessage("Your payment is processing.");
        break;
      case "requires_payment_method":
        showMessage("Your payment was not successful, please try again.");
        break;
      default:
        showMessage("Something went wrong.");
        break;
    }
  }

  // ------- UI helpers -------

  function showMessage(messageText) {
    const messageContainer = document.querySelector("#payment-message");

    messageContainer.classList.remove("hidden");
    messageContainer.textContent = messageText;

    setTimeout(function () {
      messageContainer.classList.add("hidden");
      messageText.textContent = "";
    }, 4000);
  }

  // Show a spinner on payment submission
  function setLoading(isLoading) {
    if (isLoading) {
      // Disable the button and show a spinner
      document.querySelector("#submit").disabled = true;
      document.querySelector("#spinner").classList.remove("hidden");
      document.querySelector("#button-text").classList.add("hidden");
    } else {
      document.querySelector("#submit").disabled = false;
      document.querySelector("#spinner").classList.add("hidden");
      document.querySelector("#button-text").classList.remove("hidden");
    }
}
});

