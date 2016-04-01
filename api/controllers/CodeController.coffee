 # CodeController
 #
 # @description :: Server-side logic for managing codes
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

path = require 'path'
get_dir_name = path.dirname
fs = require 'fs'
mkdirp = require 'mkdirp'

sendState =
  html: false
  goml: false
  js: false
  hasError: false

write = (path, contents, cb) ->
  mkdirp get_dir_name(path), (err) ->
    return cb(err) if err
    fs.writeFile path, contents, cb

checkSendState = ->
  # console.log sendState
  sendState.html &&
  sendState.goml &&
  sendState.js &&
  !sendState.hasError

upload = (json, fileName, cb) ->
  targetDir = path.resolve(__dirname, "../../assets/user-codes/#{fileName}/")
  ['html',　'goml', 'js'].forEach (s) ->
    write "#{targetDir}/index.#{s}", json[s], (err) ->
      return sendState.hasError = true if err
      sendState[s] = true
      if checkSendState()
        cb()

module.exports =
  index: (req, res) ->
    json = req.params.all()
    fileName = Math.random().toString(36).slice(-8)
    console.log json
    upload json, fileName, ->
      setTimeout ->
          res.json
            url: "http://localhost:1337/user-codes/#{fileName}/index.html"
        , 30000
