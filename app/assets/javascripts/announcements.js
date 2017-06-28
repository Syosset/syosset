$(document).on('turbolinks:load', function() {
  $('#announcements').sortable({
    axis: 'y',
    handle: '.handle',
    update: function( event, ui ) {
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
    }
  });
});
