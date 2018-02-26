# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $("#deal_deal_type").change ->
    if $(this).val() is "volume"
      $(".volume-based-deal").removeClass "hidden"
      $(".percentage-based-deal").addClass "hidden"
      $(".volume-based-deal input").prop "required", "true"
    else if $(this).val() is "percentage"
      $(".volume-based-deal").addClass "hidden"
      $(".percentage-based-deal").removeClass "hidden"
      $(".volume-based-deal input").removeProp "required"
    else
      $(".volume-based-deal").addClass "hidden"
      $(".percentage-based-deal").addClass "hidden"
      $(".volume-based-deal input").removeProp "required"