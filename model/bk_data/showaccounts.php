<?php

class bk_data_showaccounts_Model extends Model{
    function init(){
      $this->_bkAccountDB = Load::table("bk_account","db_cfg_bank");
      $this->_bkUserDB = Load::table("bk_user", "db_cfg_bank");
      $this->_bkUsrAccDB = Load::table("bk_user_acc", "db_cfg_bank");
    }
    function getBkUserNoByIds($where){

        $data = $this->_bkUserDB->fetchAll($where);
        $result = array();
        foreach($data as $val){
            $result[$val['user_no']] = $val;
        }
        return $result;
    }
    function getAccountIdsByUsrIds($where,$user_id){
        $where['user_id']=$user_id;
        $data = $this->_bkUsrAccDB->fetchAll($where);
        $result = array();
        foreach($data as $val){
            $result[$val['user_id']][] = $val;
        }
        return $result;
    }
    function getAccountInfoByIds($where){
        $where['acc_state'] = 1;
        $data = $this->_bkAccountDB->fetchAll($where);
        $result = array();
        foreach ($data as $val){
            $result[$val['acc_id']] = $val;
        }
        //var_dump($result['user_id']);
        return $result;
    }
    function getUserNameByIds($where,$user_id){
      $where['user_id']=$user_id;

      $data=$this->_bkUserDB->fetchall($where);
      $result=array();
      foreach ($data as $val){
          $result= $val['user_name'];
      }
      return $result;
    }
    function getAccountUsrIds($where,$user_id){
        $where['user_id']=$user_id;
        $data = $this->_bkUsrAccDB->fetchAll($where);
        $result = array();
        foreach($data as $val){
            $result[$val['acc_id']] = $val['acc_id'];
          //  echo $result[$val['acc_id']];
        }
        $acc_result=array();
        $accdata=$this->_bkAccountDB->fetchAll($result);
        foreach($accdata as $val){
            $acc_result[$val['acc_id']][] = $val;
        }
        return $acc_result;

    }

}
