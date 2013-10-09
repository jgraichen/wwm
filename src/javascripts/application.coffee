#= require templates/application
#
class @WWM.Application
  constructor: ->
    # Create router
    @router = new Backbone.Router()
    @router.route '', null, =>
      @switchPage WWM.tpl('application', WWM.ApplicationViewModel)

  initialize: =>
    Backbone.history.start hashChange: true

  rootContainer: =>
    @el ?= $ '#root-container'

  switchPage: (el) =>
    console.log el
    if @previousNode?
      ko.removeNode @previousNode
    $('#root-container').append el
    el.addClass 'active'
    @previousNode = el
