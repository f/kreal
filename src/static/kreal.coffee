class @Kreal

  events: {}
  models: {}

  constructor: (@server = "ws://#{location.host}")->

  connect: (@onconnect)->
    @socket = new WebSocket("#{@server}/kreal")
    @socket.onopen = => @socket.send "fetch:fetcher:[]"
    @socket.onmessage = (event)=> @onmessage event
    @socket.onclose = => @connect
    null

  onmessage: (event)->
    json = JSON.parse event.data

    if json.fetch?
      for _caller in json.fetch
        [model, method] = _caller
        do (model = model, method = method) =>
          @models[model] ?= {}
          @models[model][method] = (args..., callback = ->)=>
            if typeof arguments[0] is "function"
              callback = arguments[0]
              args = []
            message = {model, method, args}
            id = (Math.random()*1e18).toString 16
            @events[id] = callback
            @socket.send "call:#{id}:#{JSON.stringify message}"
          @onconnect? @models

    if json.call?
      @events[json.id]?.call(null, json.call.result)
      delete @events[json.id]

