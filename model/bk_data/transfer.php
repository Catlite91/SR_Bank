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
        $id = (int)$user_id % 10;
        $table = "bk_transaction_".$id;
        $this->_bkTransfer = Load::table($table, "db_cfg_bank");
        $sqls = array();
        $acc_sql = "INSERT INTO $table (user_id, trans_user_id, acc_id, trans_acc_id, trans_currency, trans_balance, ".
                 "trans_amount, trans_time, trans_message, trans_type, trans_state ) VALUES (";
        $acc_sql .= "'".$acc_data['user_id']."',";
        $acc_sql .= "'".$acc_data['trans_user_id']."',";
        $acc_sql .= "'".$acc_data['acc_id']."',";
        $acc_sql .= "'".$acc_data['trans_acc_id']."',";
        $acc_sql .= "'".$acc_data['trans_currency']."',";
        $acc_sql .= "'".$acc_data['trans_balance']."',";
        $acc_sql .= "'".$acc_data['trans_amount']."',";
        $acc_sql .= "'".$acc_data['trans_time']."',";
        $acc_sql .= "'".$acc_data['trans_message']."',";
        $acc_sql .= "'".$acc_data['trans_type']."',";
        $acc_sql .= "'".$acc_data['trans_state']."')";
        $trans_acc_sql = "INSERT INTO $table (user_id, trans_user_id, acc_id, trans_acc_id, trans_currency, trans_balance, ".
                 "trans_amount, trans_time, trans_message, trans_type, trans_state ) VALUES (";
        $trans_acc_sql .= "'".$trans_acc_data['user_id']."',";
        $trans_acc_sql .= "'".$trans_acc_data['trans_user_id']."',";
        $trans_acc_sql .= "'".$trans_acc_data['acc_id']."',";
        $trans_acc_sql .= "'".$trans_acc_data['trans_acc_id']."',";
        $trans_acc_sql .= "'".$trans_acc_data['trans_currency']."',";
        $trans_acc_sql .= "'".$trans_acc_data['trans_balance']."',";
        $trans_acc_sql .= "'".$trans_acc_data['trans_amount']."',";
        $trans_acc_sql .= "'".$trans_acc_data['trans_time']."',";
        $trans_acc_sql .= "'".$trans_acc_data['trans_message']."',";
        $trans_acc_sql .= "'".$trans_acc_data['trans_type']."',";
        $trans_acc_sql .= "'".$trans_acc_data['trans_state']."')";
        
        $sqls[] = $acc_sql;
        $sqls[] = $trans_acc_sql;
        $sqls[] = "UPDATE bk_account SET acc_balance = '".$acc_data['trans_balance'] ."' WHERE acc_id = '" . $acc_data['acc_id'] ."'";
        $sqls[] = "UPDATE bk_account SET acc_balance = '".$trans_acc_data['trans_balance'] ."' WHERE acc_id = '" . $trans_acc_data['acc_id'] ."'";
        $result = $this->_bkTransfer->trans_insert($sqls);
        return  $result;
    }
}