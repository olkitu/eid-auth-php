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
            if(data.status == "success") {
                $("#output").html("CN: " + data.message.cn + "<br> Surname: " + data.message.surname + "<br> Given name: " + data.message.givenname + "<br> Email: " + data.message.email + "<br> Valid: " + data.message.valid.from + " - " + data.message.valid.to + "<br> Country: " + data.message.country);
            } else {
                $("#output").html(data.message);
            }
        },
        error: function(data) {
            $("#output").html("Login failed. This could happend when certificate validation failed or it is expired. Try disconnect card from reader, reset and try again.");
            console.log(data);
        }
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
            $("#output").html("Reset success");
            console.log(data);
        },
        timeout: 1000
    });
}