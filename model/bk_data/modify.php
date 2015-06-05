<?php

class bk_data_modify_Model extends Model{
    function init(){
        $this->_bkUserDB = Load::table("bk_user","db_cfg_bank");
        //$this->_bkUsrAccDB = Load::table("bk_user_acc", "db_cfg_bank");
    }
    function loginUserByIds($user_id, $user_pwd){
      $sql = "SELECT * FROM bk_user WHERE (user_id = '" . $user_id ."' or user_tel = '". $user_id . "') and user_pwd = '" . $user_pwd."'";
      $ret = $this->_bkUserDB->query($sql);
      $result = array();
      foreach($ret as $val){
          $result = $val;
      }
      return $result;
    }
    public function UpdateUserByIds($table, array $data, array $where){
  		$set = array();
  		foreach ($data as $col => $val) {
  			$set[] = "$col = '" . $val ."'";
  		}
      $where_col=array();
      foreach ($where as $col => $val) {
        $where_col[] = "$col = '" . $val ."'";
  		}
    //  $sql = "UPDATE " . $table . " SET " .implode(',', $set).(($where) ? " WHERE $where" : "");
  		$sql = "UPDATE " . $table . " SET " .implode(',', $set)." WHERE ".implode(',', $where_col) ;
      echo $sql;
      $result = $this->_bkUserDB->query($sql);
  		//echo $result;
      return $result;
  	}
}
