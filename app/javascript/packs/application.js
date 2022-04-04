// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require gmaps-auto-complete
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


require('jquery')

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import $ from 'jquery'

$(document).ready(function() {
    $('#tabs li').on('click', function() {
      var tab = $(this).data('tab');
  
      $('#tabs li').removeClass('is-active');
      $(this).addClass('is-active');
  
      $('#tab-content section').removeClass('is-active');
      $('section[data-content="' + tab + '"]').addClass('is-active');
    });
  });