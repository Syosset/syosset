$(document).on('turbolinks:load', function() {
  $('.rankable').each((function() {
    $(this).sortable({
        axis: 'y',
        handle: '.handle',
        update: function( event, ui ) {
          $.post("/rankables/sort", $(this).sortable('serialize'))
        }
      })
  }))
});
