 # ShortUrlController
 #
 # @description :: Server-side logic for managing Shorturls
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

module.exports =
  redirect: (req, res) ->
    key = req.param('key')
    return res.redirect "/editor/" if !key?
    ShortUrl
      .find {key}
      .exec (err, list) ->
        return res.negotiate(err) if err
        return res.redirect "/editor/" if list.length == 0
        query = list[0].query
        return res.redirect "/editor/##{query}"
