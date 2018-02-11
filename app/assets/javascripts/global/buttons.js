$(document).on('turbolinks:load', function() {
  $('.btn-loader').click(function() {
    $(this).find('.fa').removeClass().addClass('fa fa-spin fa-refresh');
  });
});