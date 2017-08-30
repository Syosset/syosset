$(document).on('turbolinks:load', function() {
  $('.course-search').on('input', function() {
    query = $(this).val().toLowerCase();
    $('.course').each(function(i, course) {
      course_id = $(course).data('course-id').toString();
      name = $(course).data('name');
      if(name.toLowerCase().indexOf(query) == -1 && course_id.indexOf(query) == -1) {
        $(course).addClass('hidden');
      } else {
        $(course).removeClass('hidden');
      }
    });
  });
});
