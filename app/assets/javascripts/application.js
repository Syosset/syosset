// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require peek
//= require turbolinks
//= require bootstrap/dist/js/bootstrap
//= require moment/min/moment.min
//= require eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min
//= require fontawesome-iconpicker/dist/js/fontawesome-iconpicker.min
//= require jquery.flexslider
//= require college_green/bootstrap-hover-dropdown
//= require simplemde/dist/simplemde.min
//= require_tree .


(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-105323459-1', 'auto', {'siteSpeedSampleRate': 5});
document.addEventListener("turbolinks:load", function(event) {
  ga("set", "location", event.data.url);
  ga("send", "pageview");
});
