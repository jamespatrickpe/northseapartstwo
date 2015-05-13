//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/
// VALIDATION
$(document).ready(function(){
  $( "#signin_form" ).validate({
    rules: {
      username: {
        required: true,
        rangelength: [3, 64]
      },
      password: {
        required: true,
        rangelength: [8, 64]
      }
    }
  });

  $( "form" ).validate({
    rules: {
      name: {
        required: true,
        maxlength: 128
      },
      addresses: {
        maxlength: 256
      },
      latitude: {
        maxlength: 256,
        number: true
      },
      longitude: {
        maxlength: 256,
        number: true
      },
      digits: {
        digits: true,
        maxlength: 50
      },
      description: {
        maxlength: 256
      },
      url: {
        maxlength: 256
      },
      telephony_description:
      {
        maxlength: 50
      },
      digital_description:
      {
        maxlength: 50
      }
    }
  });
});
