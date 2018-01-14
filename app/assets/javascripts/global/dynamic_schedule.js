function valBetween(v, min, max) {
    return (Math.min(max, Math.max(min, v)));
};

$(document).on('turbolinks:load', function() {
  $(".day").each((function() {
    $(this).on('inserted.bs.popover', function () {
      var curTime = new Date();
      var curSeconds = ((curTime.getUTCHours()-5) * 60 * 60) + (curTime.getMinutes() * 60) + curTime.getSeconds();
      curSeconds = valBetween(curSeconds, 27540, 51660);
      if(curSeconds == 27540 || curSeconds == 51660) {
        $("#movable").hide();
      }
      var percentOfDay = (curSeconds-27540) / (51660-27540);
      var topLoc = Math.floor($(".schedule").height() * percentOfDay);
      $("#movable").css("top", topLoc + "px");
    });
  }));
});
