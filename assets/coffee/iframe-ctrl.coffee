$ = require 'jquery'

class IframeCtrl
  constructor: ->
    @initializeIframe()

  initializeIframe: ->
    code = """
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="/styles/importer.css">
      </head>
      <body>
        <div class="iframe-theme">
          <div class="container">
            <img src="/images/computer.svg" width="300" height="300" class="iframe-bg">
            <p class="message">result will be shown here</p>
          </div>
        </div>
      </body>
      </html>
    """
    @setIframeInner code

  generateIframe: (gomlCode, jsCode) ->
    code = """
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8"/>
          <link rel="stylesheet" href="/styles/importer.css">
          <script type="text/javascript" src="/js/j3.js"></script>
        </head>
        <body>
          <div class="iframe-theme">
            <div class="container">
              <div id="canvas" class="canvasContainer"/>
            </div>
          </div>
          <script type="text/goml">
            <!-- your goml here --> """ +
            gomlCode + """
          </script>
          <script type="text/javascript">
            //<![CDATA[
              // your js here """ +
              jsCode + """
            //]]>
          </script>
        </body>
      </html>
    """
    @setIframeInner code

  setIframeInner: (html) -> $ ->
    iframe = $('<iframe id="jthree-iframe"></iframe>')[0]
    $('#target').html(iframe)
    doc = iframe.contentWindow.document
    doc.open()
    doc.write html
    doc.close()


module.exports = IframeCtrl
