<?php

class bk_data_transfer_Model extends Model{
    function init(){
        $this->_bkAccountDB = Load::table("bk_account","db_cfg_bank");
        $this->_bkUserDB = Load::table("bk_user", "db_cfg_bank");
        $this->_bkUsrAccDB = Load::table("bk_user_acc", "db_cfg_bank");
    }

    function getBkUserInfoByIds($where){
        $where['user_state'] = 1;
        $data = $this->_bkUserDB->fetchAll($where);
        $result = array();
        foreach($data as $val){
            $result[$val['user_id']] = $val;
        }
        return $result;
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

    function getAccountInfoByNos($where){
        $where['acc_state'] = 1;
        $data = $this->_bkAccountDB->fetchAll($where);
        $result = array();
        foreach($data as $val){
            $result[$val['acc_num']] = $val;
        }
        return $result;
    }

    function getTransferInfoByIds($where, $user_id){
        $where['trans_state'] = 1;
        $id = (int)$user_id % 10;
        $table = "bk_transaction_".$id;
        $this->_bkTransfer = Load::table($table, "db_cfg_bank");
        $data = $this->_bkTransfer->fetchAll($where, "trans_time desc", 1);
        $result = array();
        foreach($data as $val){
            $result[$val['user_id']] = $val;
        }
        return $result;
    }

    function getAllTransferInfoByIds($where, $user_id){
        $where['trans_state'] = 1;
        $id = (int)$user_id % 10;
        $table = "bk_transaction_".$id;
        $this->_bkTransfer = Load::table($table, "db_cfg_bank");
        $data = $this->_bkTransfer->fetchAll($where, "trans_time desc");
        $result = array();
        foreach($data as $val){
            $result[$val['user_id']][] = $val;
        }
        return $result;
    }

    function addTransferInfo($acc_data, $trans_acc_data, $user_id, $trans_user_id){
        if($user_id == $trans_user_id){
            $id = (int)$user_id % 10;
            $acc_table = $trans_acc_table = "bk_transaction_".$id;
            $this->_bkAccTransfer = $this->_bkTransAccTransfer = Load::table($acc_table, "db_cfg_bank");
        }else{
            $acc_id = (int)$user_id % 10;
            $trans_acc_id = (int)$trans_user_id % 10;
            $acc_table = "bk_transaction_".$acc_id;
            $trans_acc_table = "bk_transaction_".$trans_acc_id;
            $this->_bkAccTransfer = Load::table($acc_table, "db_cfg_bank");
            $this->_bkTransAccTransfer = Load::table($trans_acc_table, "db_cfg_bank");
        }

        $sqls = array();
        $acc_sql = "INSERT INTO $acc_table (user_id, trans_user_id, acc_id, trans_acc_id, trans_currency, trans_balance, ".
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
        $trans_acc_sql = "INSERT INTO $trans_acc_table (user_id, trans_user_id, acc_id, trans_acc_id, trans_currency, trans_balance, ".
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
        $result = $this->_bkAccTransfer->trans_insert($sqls);
        return  $result;
    }
}
