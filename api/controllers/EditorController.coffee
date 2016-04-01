 # EditorController
 #
 # @description :: Server-side logic for managing editors
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

module.exports =
  index: (req, res) ->
    res.view title: "jThree Editor ＊ online editor for web3D"
