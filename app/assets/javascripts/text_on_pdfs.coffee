# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.draggable').draggable
    appendTo: '.pdf-image'
    start: (event, ui) ->
      return
    stop: (event, ui) ->
      alert ui.position['top']
      $.ajax
        method: 'PUT'
        url: $(this).data('url')
        data: { body: $(this).find('textarea').val(), top_position: ui.position['top'], left_position: ui.position['left'], top_offset: ui.offset['top'], left_offset: ui.offset['left'] }
      return

  $('.draggable').find('textarea').resizable()
