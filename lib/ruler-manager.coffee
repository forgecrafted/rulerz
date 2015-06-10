{Emitter, CompositeDisposable} = require 'atom'
CursorModel                    = require './cursor-model.coffee'
RulerView                      = require './ruler-view.coffee'

module.exports =
class RulerManager
  subscriptions: null
  emitter: null

  constructor: ->
    @subscriptions = new CompositeDisposable
    @emitter       = new Emitter
    @models        = []
    @initialize()
    @handleEvents()

  initialize: ->
    # Link CursorModel with RulerView.
    atom.views.addViewProvider CursorModel, (model) ->
      new RulerView().initialize(model)

  # Every Cursor in every TextEditor gets a model to proxy events for the respective view.
  handleEvents: ->
    @subscriptions.add atom.workspace.observeTextEditors (editor) =>
      @subscriptions.add editor.observeCursors (cursor) =>
        new CursorModel @, cursor

  onDidDestroy: (fn) ->
    @emitter.on 'did-destroy', fn

  # Clean up.
  destroy: ->
    @subscriptions.dispose()
    @subscriptions = null
    @emitter.emit 'did-destroy'
    @emitter.dispose()
    @emitter = null
