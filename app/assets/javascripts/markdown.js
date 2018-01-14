//= require simplemde/dist/simplemde.min

$(document).on('turbolinks:load', function() {
  new SimpleMDE({ element: $('.markdown')[0] });
});
