<?php
require_once('plugins/login-ssl.php');

$ca = $_ENV['SSL_CA'];

return new AdminerLoginSsl(
    $ssl = array("ca" => $ca)
);
