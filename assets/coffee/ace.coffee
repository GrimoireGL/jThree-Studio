ace = require 'brace'
require 'brace/mode/javascript'
require 'brace/mode/xml'
require 'brace/theme/jthree'

class Ace
  constructor: (editorName) ->
    @editorName = editorName
    @editorLang = if editorName == "goml" then "xml" else editorName
    @editor = ace.edit("#{@editorName}-editor")
    @editor.getSession().setMode "ace/mode/#{@editorLang}"
    @editor.setTheme 'ace/theme/jthree'
    @editor.getSession().setTabSize(2)
    @editor.getSession().setUseWrapMode(true)
    @editor.setOptions
      enableBasicAutocompletion: true
      enableSnippets: true
      enableLiveAutocompletion: true

  watch: (callback) =>
    @editor.getSession().on 'change',  =>
      code = @editor.getValue()
      callback(code)

  setCode: (code) =>
    @editor.getSession().setValue code

module.exports = Ace
