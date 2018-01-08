function init_tiny() {
  $('#flash').append("<div id=\"ada-notice\"><div class=\"alert alert-warning\"><strong>ADA Compliance</strong><br/>By posting on syosseths.com, you agree that the content is ADA compliant to the best of your ability.</div></div>")
  $('#ada-notice').hide();

  options = {
    plugins: "table insertdatetime preview link image media searchreplace contextmenu paste directionality fullscreen noneditable visualchars nonbreaking template save",
    relative_urls: false,
    remove_script_host: false,
    convert_urls: true,
    toolbar: [
    "save | undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
    "print preview   | fontselect fontsizeselect | forecolor backcolor emoticons | codesample"],
    table_default_attributes: {
        class: 'table table-bordered'
    },
    image_class_list: [
      {title: 'Automatically Adjust Size to Screen Resolution', value: 'img-responsive'},
    ],
    init_instance_callback: function (editor) {
      editor.on('focus', function (e) {
        $('#ada-notice').show();
      });
      editor.on('blur', function (e) {
        $('#ada-notice').hide();
      });
    }
  };

  tinyMCE.init(Object.assign({},options, {selector: '.tinymce'}));
  tinyMCE.init(Object.assign({},options, {selector: '.editable-content', inline: true}));
};

$(document).on('turbolinks:load', function() {
  $( "table" ).wrap( "<div class='table-responsive'></div>" );
});
