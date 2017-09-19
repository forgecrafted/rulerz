{CompositeDisposable, Point} = require 'atom'

# Set this to true to enable debugging `console.log()` calls in this file
debug = false

class RulerView extends HTMLElement
  subscriptions: null
  model:         null
  editor:        null
  lines:         null

  createdCallback: ->
    @classList.add 'rulerz'

  initialize: (model) ->
    @subscriptions = new CompositeDisposable
    @model = model
    @insert()
    @subscribe()
    # Set the initial positioning.
    @update @model.getCursor().getScreenPosition()

  getEditor: ->
    @editor = atom.views.getView @model.getCursor().editor
    root    = @editor.syntax ? @editor
    @lines  = root.querySelector '.scroll-view .lines'
    @editor

  # Insert the view into the TextEditors underlayer.
  insert: ->
    @getEditor() unless @lines
    return unless @lines # temporary band-aid for https://github.com/forgecrafted/rulerz/issues/12
    @lines.appendChild @

  subscribe: ->
    # Watch the cursor for changes.
    @subscriptions.add @model.onDidChange @update.bind(@)
    @subscriptions.add @model.onDidDestroy @destroy.bind(@)

  # Change the left alignment of the ruler.
  update: (point) ->
    view        = @getEditor()
    # It looks like `view.pixelPositionForScreenPosition` is potentially a
    # private API and should not be used by plugins. It intermittently throws on
    # startup, or very quickly after startup. To workaround, we wrap it in a
    # try, and do nothing if it throws.
    try
      position    = view.pixelPositionForScreenPosition point
      @style.left = position.left + 'px'
    catch e
      console.error 'rulerz caught', e if debug
      setTimeout =>
        try
          position    = view.pixelPositionForScreenPosition point
          @style.left = position.left + 'px'
        catch e
          console.error 'rulerz caught twice', e if debug

  # Clean up.
  destroy: ->
    @subscriptions.dispose()
    @remove()

module.exports = RulerView = document.registerElement('ruler-view', {prototype: RulerView.prototype})
