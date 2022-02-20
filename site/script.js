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
        xhr: function() {
            
        },
        success: function(data) {
            console.log(data);
            $("#output").html((JSON.stringify(data)));
        },
        error: function(xhr) {
            $("#output").html((JSON.stringify({"status": "error", "message": "error"})));
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
        error: function() {
            $("#output").html((JSON.stringify({"status": "success"})));
        },
        timeout: 1000
    });
}