<?php

// SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

require_once('plugins/login-ssl.php');

$ca = $_ENV['SSL_CA'];

return new AdminerLoginSsl(
    $ssl = array("ca" => $ca)
);
