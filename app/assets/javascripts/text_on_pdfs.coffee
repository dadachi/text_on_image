# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.draggable').draggable
    appendTo: '.container'
    containment: '.pdf-image-container'
    start: (event, ui) ->
      return
    stop: (event, ui) ->
      console.log 'top: ' + ui.position['top']
      console.log 'left: ' + ui.position['left']
      console.log 'offset top: ' + ui.offset['top']
      console.log 'offset left: ' + ui.offset['left']
      containerOffsetLeft = $('.container').offset().left
      console.log 'container offset left: ' + containerOffsetLeft
      containerPaddingRight = parseInt($('.container').css('paddingRight'), 10)
      console.log 'container paddingRight: ' + containerPaddingRight
      bodyOffsetTop = $('body').offset().top
      console.log 'body offset top: ' + bodyOffsetTop
      labelHeight = 25
      $.ajax
        method: 'PUT'
        url: $(this).data('url')
        data: { body: $(this).find('textarea').val(), top_position: ui.position['top'], left_position: ui.position['left'], top_offset: ui.offset['top'] - bodyOffsetTop + labelHeight, left_offset: ui.offset['left'] - containerOffsetLeft - containerPaddingRight }
      return

  $('textarea').resizable()

  $('textarea').on 'change keyup paste', ->
    currentVal = $(this).val()
    $draggable = $(this).closest('.draggable')
    $.ajax
      method: 'PUT'
      url: $draggable.data('url')
      data: { body: currentVal }

  if $('.pdf-image').attr('data-width') != 'null'
    $('.pdf-image').width($('.pdf-image').data('width'))
  else
    $('.pdf-image').width($('.pdf-image').data('original-width'))
