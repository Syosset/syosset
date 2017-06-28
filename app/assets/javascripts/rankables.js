$(document).on('turbolinks:load', function() {
  $('.rankable').sortable({
    axis: 'y',
    handle: '.handle',
    update: function( event, ui ) {
      $.post("/admin/rankables/sort", $(this).sortable('serialize'))
    }
  });
});
