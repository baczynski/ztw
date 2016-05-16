# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(document).on 'ready page:load', ->
    $('.datetimepicker').datetimepicker
      format: 'YYYY/MM/DD HH:mm'
      widgetPositioning:
        vertical: 'bottom'
    $('.datepicker').datetimepicker
      format: 'YYYY/MM/DD'
      widgetPositioning:
        vertical: 'bottom'

  $('a[data-remote]').on 'ajax:success', (e, data, status, xhr) ->
    res = data['result']
    res1 = data['res1']
    if res1?
      if res1
        alert "Nie wypełniono wszystkich wyników"
      else
        window.location.href = window.location.href
    else if res?
      if res
        winner = $('#captions').data('winner')
        result = $('#captions').data(res.toLowerCase())
        $('#result').text(winner + result)
        $('#result').show()
    else
      $('#result').hide()



