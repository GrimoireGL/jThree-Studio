 # ShortUrl.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

module.exports =

  attributes:
    key:
      type: 'string'
      unique: true
      required: true
    query:
      type: 'string'
      required: true

    toJSON: ->
      {key, query} = @toObject()
      return {key, query}
