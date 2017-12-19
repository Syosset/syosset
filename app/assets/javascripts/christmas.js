//= require parallax-js/dist/parallax

document.addEventListener("turbolinks:load", function(event) {
  var scene = document.getElementById('christmasParallax');
  if (scene) {
    var parallax = new Parallax(scene);
  }
});