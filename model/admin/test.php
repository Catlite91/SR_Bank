<?php

class admin_test_Model extends Model{
    function init(){
       $this->_bankDemoDB  = Load::table("test", "db_cfg_bank");
    }
    
    function read_demo(){
        $sql = "select * from test";
        $data = $this->_bankDemoDB->queryAll($sql);
        return $data;
    }
}