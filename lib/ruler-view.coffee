{CompositeDisposable} = require 'atom'

class RulerView extends HTMLElement
  subscriptions: null
  model: null

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

  # Insert the view into the TextEditors underlayer.
  insert: ->
    editor_view = atom.views.getView(@model.getCursor().editor)
    underlayer = editor_view.getElementsByClassName('underlayer')[0]
    underlayer.appendChild @

  subscribe: ->
    # Watch the cursor for changes.
    @subscriptions.add @model.onDidChange @update.bind(@)
    @subscriptions.add @model.onDidDestroy @destroy.bind(@)
    # Watch the config for changes.
    @subscriptions.add atom.config.observe 'rulerz.width', (newValue) =>
      @style['border-left-width'] = newValue + 'px'

  # Change the left alignment of the ruler.
  update: (point) ->
    position = @model.getCursor().editor.pixelPositionForScreenPosition point
    @style.left = position.left + 'px'

  # Clean up.
  destroy: ->
    @subscriptions.dispose()
    @remove()

module.exports = RulerView = document.registerElement('ruler-view', {prototype: RulerView.prototype})
