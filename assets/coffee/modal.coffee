swal = require 'sweetalert'
Clipboard = require 'clipboard'
$ = require 'jquery'

class Modal
  @shortUrl: (url) ->
    console.log "called"
    code = """
      <p>#{url}</p>
    """
    conf =
      title: "Share the code by this URL."
      text: code
      showCancelButton: true
      confirmButtonColor: "#50A6D0"
      confirmButtonText: "copy to clipboard"
      closeOnConfirm: false
      html: true
    swal conf

    @_setButtonAttr url

  @_setButtonAttr: (url) ->
    $ ->
      setTimeout ->
          console.log "called!!!!"
          $ '.confirm'
            .attr 'data-clipboard-text', url
          new Clipboard('.confirm');
        , 300


module.exports = Modal
