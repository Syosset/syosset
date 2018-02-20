$(document).on('turbolinks:load', function () {
  $('#translate_trigger').click(function() {
    $.getScript("https://translate.google.com/translate_a/element.js?cb=loadTranslate");
  });
});

function loadTranslate() {
  new google.translate.TranslateElement({
    pageLanguage: 'en',
    layout: google.translate.TranslateElement.InlineLayout.HORIZONTAL,
  }, 'google_translate_element');
  $('#translate_trigger').hide();
}