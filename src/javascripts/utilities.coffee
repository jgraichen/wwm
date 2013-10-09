#
class JSTTemplateSource
  constructor: (name) ->
    @name = "templates/#{name}"

  text: (value) ->
    if value?
      JST[@name] = value
    else
      JST[@name]

  data: (key, value) ->
    JSTTemplateSource.data ?= {}
    JSTTemplateSource.data[@name] ?= {}
    if arguments.length == 1
      JSTTemplateSource.data[@name][key]
    else
      JSTTemplateSource.data[@name][key] = value

class ko.NativeJSTTemplateEngine extends ko.nativeTemplateEngine
  makeTemplateSource: (template) ->
    throw "Unknown JST template: '#{template}'" unless JST["templates/#{template}"]?
    new JSTTemplateSource template

ko.setTemplateEngine new ko.NativeJSTTemplateEngine()

# template helper
@WWM ?= {}
@WWM.tpl = ->
  ko.renderTemplate(arguments)
