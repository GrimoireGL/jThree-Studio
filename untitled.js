j3(function () {
  var r = 5;
  for (var theta = 0; theta < 2 * Math.PI; theta+=0.3) {
    var x = r * Math.cos(theta); z = r * Math.sin(theta);
    var mesh = '<mesh geo="cube" mat="phongMaterial" scale="0.4,0.2,0.4" position="'+[x,0,z].join(',')+'"/>';
    j3('.cubes').append(mesh);
  }
  j3('cubes').animate({
    rotate: "180d"
  });
})
