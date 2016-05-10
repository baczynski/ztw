# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(document).on 'ready page:load', ->
    $('.datetimepicker').datetimepicker
      format: 'YYYY/MM/DD HH:mm'
      widgetPositioning:
        vertical: 'bottom'
      minDate: new Date()
  window.paintIt = (element, backgroundColor, textColor) ->
    element.style.backgroundColor = backgroundColor
    if textColor?
      element.style.color = textColor
