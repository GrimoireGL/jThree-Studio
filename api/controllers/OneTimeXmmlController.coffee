 # OneTimeXmmlController
 #
 # @description :: Server-side logic for managing Onetimexmmls
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

module.exports =
  generate: (req, res) ->
    # data = req.params.all()
    xmml = req.param 'xmml'
    res.set 'Content-Type': 'text/plain'
    res.send xmml
