function init_tiny() {
  tinyMCE.init({
    selector: '.editable-content',
    inline: true,
    plugins: "table insertdatetime preview link image media searchreplace contextmenu paste directionality fullscreen noneditable visualchars nonbreaking template save",
    toolbar: [
    "save | undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
    "print preview   | fontselect fontsizeselect | forecolor backcolor emoticons | codesample"]
  });
};
