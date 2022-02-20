$(function() {
    $('#Login').on('click', doLogin);
});
$(function() {
    $('#Reset').on('click', doReset);
});

function doLogin() {
    $("#output").html('<div class="spinner-border" role="status"><span class="visually-hidden">Loading...</span></div>');
    $.ajax({
        url: '/auth/login',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log(data);
            $("#output").html((JSON.stringify(data)));
        },
        error: function(data) {
            $("#output").html((JSON.stringify({"status": "error", "message": "Login error, please try disconnect card from reader, reset and try again."})));
            console.log(data);
        },
        timeout: 3000
    });
}

function doReset() {
    $("#output").html('<div class="spinner-border" role="status"><span class="visually-hidden">Loading...</span></div>');
    $.ajax({
        url: '/auth/reset',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log(data);
        },
        error: function(data) {
            $("#output").html((JSON.stringify({"status": "success"})));
            console.log(data);
        },
        timeout: 1000
    });
}