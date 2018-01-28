var loaded = false;

function loadChat() {
  if(loaded) return;
  loaded = true;

  $("#support_ui").hide();
  $("#open_support").click(function() {
    Support.openThread(function(thread) {
      $("#open_support").hide();
      $("#support_ui").show();

      $("#send_button").click(send);
      $("#send_field").keyup(function(e) {
        if (e.keyCode == 13) send();
      });

      function send() {
        thread.sendMessage($("#send_field").val(), function() {});
        $("#send_field").val('');
      }

      thread.onMessage(function(msg){
        $('.messages').append('<div class=\'message\'>' + msg.sender.name + ': ' + msg.message + '</div>');
      });
    });
  });
  $("#dismiss_support").click(function() {
    $("#support_ui").hide();
    $("#open_support").show();
  });
}

$(document).ready(loadChat);
$(document).on('turbolinks:load', loadChat);
