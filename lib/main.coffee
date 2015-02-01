{CompositeDisposable} = require 'atom'
RulerManager = require './ruler-manager.coffee'

module.exports =
  subscriptions: null

  config:
    enabled:
      title: 'Display a Ruler on each Cursor'
      type: 'boolean'
      default: true
    width:
      title: 'Width of each Ruler (in pixels)'
      type: 'integer'
      default: 1

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'rulerz.enabled', (newValue) =>
      if newValue then @doEnable() else @doDisable()

  deactivate: ->
    @subscriptions.dispose()
    @subscriptions = null

  toggle: ->
    atom.config.set 'rulerz.enabled', !@enabled()

  enabled: ->
    atom.config.get('rulerz.enabled') is true

  enable: ->
    atom.config.set 'rulerz.enabled', true
    @doEnable()

  disable: ->
    atom.config.set 'rulerz.enabled', false
    @doDisable()

  doEnable: ->
    @rulerzManager = new RulerManager()

  doDisable: ->
    @rulerzManager?.destroy()
    @rulerzManager = null
