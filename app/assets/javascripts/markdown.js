//= require simplemde/dist/simplemde.min
//= require inline-attachment/src/inline-attachment.js
//= require inline-attachment/src/codemirror-4.inline-attachment.js

$(document).on('turbolinks:load', function() {
  var modelName = document.body.getAttribute('data-model-name');
  var modelId = document.body.getAttribute('data-params-id');
  var userId = document.body.getAttribute('data-current-user-id');

  document.querySelectorAll('.markdown').forEach(function(editor) {
    var simplemde = new SimpleMDE({ element: editor, autoDownloadFontAwesome: false });

    var params = {};
    params["attachable_type"] = modelName;
    params["attachable_id"] = modelId;
    params["user_id"] = userId;

    inlineAttachment.editors.codemirror4.attach(simplemde.codemirror, {
      uploadUrl: '/attachments',
      extraHeaders: { 'X-CSRF-Token': Rails.csrfToken() },
      urlText: "![]({filename})", //  We want to leave the alt text blank for Azure to try and guess it. TODO: Get rid of the `!` when uploaded type is not an image
      allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif', 'application/pdf'],
      extraParams: params
    });
  });

});
