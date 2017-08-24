$(document).ready(function() {
  $('.course-search').on('input', function() {
    query = $(this).val().toLowerCase();
    $('.course').each(function(i, course) {
      name = $(course).data('name');
      if(name.toLowerCase().indexOf(query) == -1) {
        $(course).addClass('hidden');
      } else {
        $(course).removeClass('hidden');
      }
    });
  });
});