<?php

require_once dirname(__FILE__) . DS . 'MySQL.php';

class DBV_Adapter_SecureMySQL extends DBV_Adapter_MySQL
{
    protected function _getPDOAdapterParams()
    {
        return array(
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
            'opts' => array(
                PDO::MYSQL_ATTR_SSL_CA => '/certs/db.pem',
            )
        );
    }
    
}
