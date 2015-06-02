<?php

class bk_data_basic_Model extends Model{
    function init(){
      $this->_bankUserDB = Load::table("bk_user", "db_cfg_bank") ;
      $this->_bankAccountDB = Load::table("bk_account", "db_cfg_bank");
      $this->_bankUserAccDB = Load::table("bk_user_acc", "db_cfg_bank");
    }
    
    //where 数组 key = 数据库字段， value=值
    function getUserByIds($where){
        $where['user_state'] = 1;
        $data = $this->_bankUserDB->fetchAll($where);
        
        return $data;
    }
    
    function loginUserByIds($user_id, $user_pwd){
        $sql = "SELECT * FROM bk_user WHERE (user_no = '" . $user_id ."' or user_tel = '". $user_id . "') and user_pwd = '" . $user_pwd."'";
        $ret = $this->_bankUserDB->queryAll($sql);
        $result = array();
        foreach($ret as $val){
            $result = $val;
        }
        return $result;
    }
    
}

