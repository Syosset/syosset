$(document).on('turbolinks:load', function() {
  $('.btn-loader').click(function() {
    $(this).find('.fa, .fab').removeClass().addClass('fa fa-spin fa-spinner');
  });
});
