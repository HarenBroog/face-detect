window.addEventListener 'DOMContentLoaded', (->
  # Grab elements, create settings, etc.
  canvas = document.getElementById('canvas')
  context = canvas.getContext('2d')
  video = document.getElementById('video')
  videoObj = 'video': true

  errBack = (error) ->
    console.log 'Video capture error: ', error.code
    return

  # Put video listeners into place
  if navigator.getUserMedia
    # Standard
    navigator.getUserMedia videoObj, ((stream) ->
      video.src = stream
      video.play()
      return
    ), errBack
  else if navigator.webkitGetUserMedia
    # WebKit-prefixed
    navigator.webkitGetUserMedia videoObj, ((stream) ->
      video.src = window.webkitURL.createObjectURL(stream)
      video.play()
      return
    ), errBack
  else if navigator.mozGetUserMedia
    # Firefox-prefixed
    navigator.mozGetUserMedia videoObj, ((stream) ->
      video.src = window.URL.createObjectURL(stream)
      video.play()
      return
    ), errBack

  videoInput = document.getElementById('video')
  ctracker = new (clm.tracker)

  positionLoop = ->
    requestAnimationFrame positionLoop
    positions = ctracker.getCurrentPosition()
    # do something with the positions ...
    # print the positions
    positionString = ''
    if positions
      p = 0
      while p < 10
        positionString += 'featurepoint ' + p + ' : [' + positions[p][0].toFixed(2) + ',' + positions[p][1].toFixed(2) + ']<br/>'
        p++
      document.getElementById('positions').innerHTML = positionString
    return

  drawLoop = ->
    requestAnimationFrame drawLoop
    cc.clearRect 0, 0, canvasInput.width, canvasInput.height
    ctracker.draw canvasInput
    return

  ctracker.init pModel
  ctracker.start videoInput
  positionLoop()
  canvasInput = document.getElementById('canvas')
  cc = canvasInput.getContext('2d')
  drawLoop()

  $('#save').on 'click',  ->
    positions = ctracker.getCurrentPosition()
    $.ajax
      url: '/faces'
      type: 'POST'
      data :
        face:
          name: $('#name').val()
          cords: positions
      success: (data, status, response) ->
        alert("Dodano pomiar!")
      error: ->
        alert("Za duzo pomiarów!")
      dataType: "json"

  $('#verify').on 'click',  ->
    positions = ctracker.getCurrentPosition()
    $.ajax
      url: '/faces/verify'
      type: 'POST'
      data :
        face:
          cords: positions
      success: (data, status, response) ->
        input = $('#name')
        input.val(response.responseJSON.name)
        input.addClass('bg-success')
      error: ->
        alert("Brak autoryzacji")
         # Hard error
      dataType: "json"

), false
