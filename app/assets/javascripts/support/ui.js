var loaded = false;

function loadChat() {
  if(loaded) return;
  loaded = true;

  var userId = document.body.getAttribute('data-current-user-id');

  $("#support_ui").hide();
  $("#open_support").click(function() {
    $("#open_support").text("Loading your support session...");
    Support.openThread(function(thread) {
      $("#open_support").hide();
      $("#support_ui").show();

      $("#send_button").click(send);
      $("#send_field").keyup(function(e) {
        if (e.keyCode == 13) send();
      });

      function send() {
        thread.sendMessage($("#send_field").val());
        $("#send_field").val('');
      }

      thread.onMessage(function(msg){
        var messageClass = 'message';
        if (msg.sender.id == userId) messageClass += ' self';

        var formattedTime = moment(msg.timestamp).fromNow();
        $('.messages').append('<div class=\'' + messageClass + '\'><span class=\'sender\'>' + msg.sender.name + '</span>&nbsp;<span class=\'timestamp pull-right\'>' + formattedTime + '</span><br/>' + msg.message + '</div>');
        $('.messages').scrollTop($('.messages')[0].scrollHeight);
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
