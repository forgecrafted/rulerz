{CompositeDisposable} = require 'atom'

class RulerView extends HTMLElement
  subscriptions: null
  model:         null
  editor:        null
  lines:         null

  createdCallback: ->
    @classList.add 'rulerz'
    @style['border-left-width'] = atom.config.get('rulerz.width') + 'px'

  initialize: (model) ->
    @subscriptions = new CompositeDisposable
    @model = model
    @insert()
    @subscribe()
    # Set the initial positioning.
    @update @model.getCursor().getScreenPosition()

  getEditor: ->
    @editor = atom.views.getView @model.getCursor().editor
    root    = @editor.shadowRoot ? @editor
    @lines  = root.querySelector '.scroll-view .lines'
    @editor

  # Insert the view into the TextEditors underlayer.
  insert: ->
    @getEditor() unless @lines
    @lines.appendChild @

  subscribe: ->
    # Watch the cursor for changes.
    @subscriptions.add @model.onDidChange @update.bind(@)
    @subscriptions.add @model.onDidDestroy @destroy.bind(@)
    # Watch the config for changes.
    @subscriptions.add atom.config.observe 'rulerz.width', (newValue) =>
      @style['border-left-width'] = newValue + 'px'

  # Change the left alignment of the ruler.
  update: (point) ->
    view        = @getEditor()
    position    = view.pixelPositionForScreenPosition point
    @style.left = position.left + 'px'

  # Clean up.
  destroy: ->
    @subscriptions.dispose()
    @remove()

module.exports = RulerView = document.registerElement('ruler-view', {prototype: RulerView.prototype})
