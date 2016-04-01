qs = require 'qs'
objectAssign = require 'object-assign'
IframeCtrl = require './iframe-ctrl'
Editor = require './ace'
gomlEditor = new Editor 'goml'
jsEditor = new Editor 'javascript'
beautify = require('js-beautify')
jsBeautify = beautify.js_beautify
gomlBeautify = beautify.html_beautify
$ = require 'jquery'
request = require 'request'
modal = require './modal'

class EditorCtrl
  constructor: (@scope, @location) ->
    @state =
      goml: ""
      js: ""
    @setStateFromUrl()
    @watchEditors()
    @iframe = new IframeCtrl()

  watchEditors: =>
    gomlEditor.watch (code) =>
      @setStateFromEditor goml: code
    jsEditor.watch (code) =>
      @setStateFromEditor js: code
    window.onhashchange = =>
      console.log @state
    $ =>
      $ '#execute'
        .click =>
          @run()
      $ '#reformat'
        .click =>
          @format()
      $ '#generate'
        .click =>
          @generateUrl()

  updateUrl: =>
    location.replace location.href.split('#')[0]+"#?"+qs.stringify(@state)

  setState: (state, cb) =>
    @state = objectAssign @state, state
    cb && cb()

  setStateFromUrl: =>
    query = location.hash.match(/#\?(.+$)/)?[1] || ""
    @setState qs.parse(query), =>
      @setCode @state

  setCode: (state) =>
    jsEditor.setCode state.js
    gomlEditor.setCode state.goml

  setStateFromEditor: (obj) =>
    @setState obj, =>
      @updateUrl()

  format: =>
    goml = gomlBeautify @state.goml, indent_size: 2
    js = jsBeautify @state.js, indent_size: 2
    @setState { goml, js }, =>
      @setCode @state

  generateUrl: =>
    key = Math.random().toString(36).slice(-12);
    query = "?" + qs.stringify(@state)
    console.log {key, query}
    request
      .post "#{location.origin}/shorturl/", form: {key, query}, (err, res, body) =>
        if err || String(res.statusCode)[0] != "2"
          console.log err
        modal.shortUrl "#{location.origin}/preview/#{key}"

  run: =>
    @iframe.generateIframe @state.goml, @state.js

module.exports = EditorCtrl
