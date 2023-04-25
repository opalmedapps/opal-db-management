<?php

require_once dirname(__FILE__) . DS . 'MySQL.php';

class DBV_Adapter_SecureMySQL extends DBV_Adapter_MySQL
{
    protected function _getPDOAdapterParams()
    {
        return array(
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
            PDO::MYSQL_ATTR_SSL_CA => getenv('SSL_CA'),
            PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT => true,
        );
    }
}
