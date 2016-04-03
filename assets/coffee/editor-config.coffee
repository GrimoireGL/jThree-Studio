module.exports =
  defaultCode:
    goml: """
      <goml>
        <resources>
          <material type="builtin.phong" name="phongMaterial" diffuse="white" specular="pink"/>
        </resources>
        <canvases>
          <canvas clearColor="#11022A" frame=".canvasContainer">
            <viewport cam="CAM1" id="main" width="640" height="480" name="MAIN"/>
          </canvas>
        </canvases>
        <scenes>
          <scene name="mainScene">
            <object>
              <camera id="maincam" aspect="1" far="20" fovy="1/2p" name="CAM1" near="0.1" position="(0,8,10)" rotation="x(-30d)"></camera>
            </object>
            <mesh geo="quad" mat="phongMaterial" rotation="x(-90d)" scale="10"/>
            <scenelight color="#333"/>
            <object class="cubes" rotation="y(0)"></object>
            <plight color="yellow" distance="10" intensity="3" position="5,5,0"/>
            <dlight color="blue" rotation="y(45d)"/>
          </scene>
        </scenes>
      </goml>
    """
    js: """
      j3(function () {
        var r = 5;
        [3, 6].forEach(function (y) {
          for (var theta = 0; theta < 2 * Math.PI; theta+=0.3) {
            var x = r * Math.cos(theta); z = r * Math.sin(theta);
            var mesh = '<mesh geo="cube" mat="phongMaterial" scale="0.4,0.2,0.4" position="'+[x,y,z].join(',')+'"/>';
            j3('.cubes').append(mesh);
          }
        });
        j3('.cubes').animate({
          rotation: "y(180d)"
        }, 3000).animate({
          rotation: "y(0)"
        }, 2000).animate({
          rotation: "y(180d)"
        }, 3000).animate({
          rotation: "y(0)"
        }, 2000);
      })
    """
