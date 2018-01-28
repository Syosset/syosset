var loaded = false;

function loadChat() {
  if(loaded) return;
  loaded = true;
  
  $("#support_ui").hide();
  $("#open_support").click(function() {
    Support.openThread(function(thread) {
      $("#open_support").hide();
      $("#support_ui").show();

      $("#send_button").click(function() {
        thread.sendMessage($("#send_field").val(), function() {});
      });

      thread.onMessage(function(msg){
        $('.messages').append('<div class=\'message\'>' + msg.message + '</div>');
      });
    });
  });

}



$(document).ready(loadChat);
$(document).on('turbolinks:load', loadChat);
