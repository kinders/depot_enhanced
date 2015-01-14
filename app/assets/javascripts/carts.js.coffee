# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ready", ->
  $('.add_one').click ->
    x = parseInt($(this).parent().parent().find('#line_item_quantity').val())
    x += 1
    $(this).parent().parent().find('#line_item_quantity').val(x)
    $(this).parent().parent().find(':submit').click()
  $('.subtract_one').click ->
    x = parseInt($(this).parent().parent().find('#line_item_quantity').val())
    x -= 1
    $(this).parent().parent().find('#line_item_quantity').val(x)
    $(this).parent().parent().find(':submit').click()
