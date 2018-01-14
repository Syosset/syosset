var expiry = -1;

$(document).on('turbolinks:load', function setup() {
    expiry = $('#adminControl').data('expiry');

    $('#renew').click(renew);
    $('#resign').click(resign);

    updateTimer();
    setInterval(updateTimer, 1000);
});

function renew() {updateStatus('renew')}
function resign() {updateStatus('resign')}

function updateStatus(action) {
    $('#adminTime').text("Updating...");
    $.post('/admin/' + action, function(data) {
        $('#adminContainer').removeClass('bg-warning');

        now = getTimestamp();
        wasAdmin = expiry > now;
        expiry = data.admin_until;
    });
}

function updateTimer() {
    now = getTimestamp();
    if (expiry > now) {
        timeLeft = expiry - now;
        $('#adminTime').text(formatTime(timeLeft));
        if (timeLeft <= 30) {
            if (timeLeft % 2 == 0) {
                $('#adminContainer').addClass('bg-warning');
            } else {
                $('#adminContainer').removeClass('bg-warning');
            }
        }
    } else {
        $('#adminTime').text("Admin disabled");
    }
}

function getTimestamp(){return Math.ceil(new Date().getTime()/1000)}
function formatTime(s){return(s-(s%=60))/60+(9<s?':':':0')+s}