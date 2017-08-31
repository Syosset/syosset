function init_tiny() {
  tinyMCE.init({
    selector: '.editable-content',
    inline: true,
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
    ]
  });
};

$(document).on('turbolinks:load', function() {
  $( "table" ).wrap( "<div class='table-responsive'></div>" );
});
