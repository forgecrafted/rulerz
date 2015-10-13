{CompositeDisposable} = require 'atom'
RulerManager = require './ruler-manager.coffee'

module.exports =

  activate: ->
    @rulerzManager = new RulerManager()

  deactivate: ->
    @rulerzManager?.destroy()
    @rulerzManager = null
