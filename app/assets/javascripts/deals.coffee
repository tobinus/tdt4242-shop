# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  set_fields = ->
    if $("#deal_type").val() is "VolumeDeal"
      $(".volume-based-deal").removeClass "hidden"
      $(".percentage-based-deal").addClass "hidden"
      $(".volume-based-deal input").prop "required", "true"
    else if $("#deal_type").val() is "PercentageDeal"
      $(".volume-based-deal").addClass "hidden"
      $(".percentage-based-deal").removeClass "hidden"
      $(".volume-based-deal input").removeProp "required"
    else
      $(".volume-based-deal").addClass "hidden"
      $(".percentage-based-deal").addClass "hidden"
      $(".volume-based-deal input").removeProp "required"

  set_fields()

  $("#deal_type").change ->
    set_fields()