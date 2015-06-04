<?php

class bk_data_transfer_Model extends Model{
    function init(){
        $this->_bkAccountDB = Load::table("bk_account","db_cfg_bank");
        $this->_bkUsrAccDB = Load::table("bk_user_acc", "db_cfg_bank");
    }
    
    
    function getAccountIdsByUsrIds($where){
        $data = $this->_bkUsrAccDB->fetchAll($where);
        $result = array();
        foreach($data as $val){
            $result[$val['user_id']][] = $val['acc_id'];
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
        return $result;
    }
    
    function getTransferInfoByIds($where){
        
    }
    
    function addTransferInfo($acc_data, $trans_acc_data, $user_id){
        $id = mod($user_id, 10);
        $table = "bk_transaction_".$id;
        $this->_bkTransfer = Load::table($table, "db_cfg_bank");
        $result = $this->_bkTransfer->insert($data);
        var_dump($result);
    }
}