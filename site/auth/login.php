<?php
    header('Content-Type: application/json; charset=utf-8');
    if(isset($_SERVER["SSL_CLIENT_S_DN_CN"])) {
        echo json_encode(array(
            "status" => "success",
            "message" => array(
                "cn" => $_SERVER["SSL_CLIENT_S_DN_CN"],
                "dn" => $_SERVER["SSL_CLIENT_S_DN"],
                "surname" => $_SERVER["SSL_CLIENT_S_DN_S"],
                "givenname" => $_SERVER["SSL_CLIENT_S_DN_G"],
                "email" => $_SERVER["SSL_CLIENT_SAN_Email_0"],
                "valid" => array(
                    "from" => $_SERVER["SSL_CLIENT_V_START"],
                    "to" => $_SERVER["SSL_CLIENT_V_END"]
                ),
                "country" => $_SERVER["SSL_CLIENT_S_DN_C"],
            )
        ));
    }
    else {
        echo json_encode(array("status" => "error", "message" => "No certificate found, try again"));
    }
    
?>