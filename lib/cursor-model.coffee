{Emitter, CompositeDisposable} = require 'atom'

module.exports =
class CursorModel
  subscriptions: null
  emitter: null
  manager: null
  cursor: null

  constructor: (manager, cursor) ->
    @subscriptions = new CompositeDisposable
    @emitter       = new Emitter
    @manager       = manager
    @cursor        = cursor
    @initialize()
    @subscribe()

  initialize: ->
    # Trigger the creation of the associated RulerView.
    atom.views.getView @

  # Public
  getCursor: ->
    @cursor

  # Listen for events from the Cursor.
  subscribe: ->
    @subscriptions.add @manager.onDidDestroy @destroy.bind(@)
    @subscriptions.add @cursor.onDidDestroy @destroy.bind(@)
    @subscriptions.add @cursor.onDidChangePosition @change.bind(@)

  onDidChange: (fn) ->
    @emitter.on 'did-change', fn

  onDidDestroy: (fn) ->
    @emitter.on 'did-destroy', fn

  # Proxy a cursorDidChangePosition event, passing a Point
  change: (event) ->
    @emitter.emit 'did-change', event.newScreenPosition

  # Clean up.
  destroy: ->
    @subscriptions.dispose()
    @emitter.emit 'did-destroy'
    @emitter.dispose()
