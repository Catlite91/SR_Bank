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
<<<<<<< HEAD
=======

    function signUpUser($where){
        $table = "bk_user";

        $where['role_id'] = 2;
         
        $signUp_sql = "INSERT INTO $table (user_no, user_name, user_identity, user_gender, user_tel, user_email, ".
                 "user_pwd, role_id) VALUES (";
        $signUp_sql .= "'".$where['user_no']."',";
        $signUp_sql .= "'".$where['user_name']."',";
        $signUp_sql .= "'".$where['user_identity']."',";
        $signUp_sql .= "'".$where['user_gender']."',";
        $signUp_sql .= "'".$where['user_tel']."',";
        $signUp_sql .= "'".$where['user_email']."',";
        $signUp_sql .= "'".$where['user_pwd']."',";
        $signUp_sql .= "'".$where['role_id']."')";
        var_dump($signUp_sql);
         
         $result = false;
         $result = $this->_bankUserDB->single_insert($signUp_sql);
         return $result;
    }

    function getAccByIds($where){
        //无论卡是否为注销状态，卡号都不能重复
        //$where['acc_state'] = 1;
        $data = $this->_bankAccountDB->fetchAll($where);
        return $data;
    }

    function addAccount($where){
        $table = "bk_account";

        //$where['acc_type'] = "D";
        $where['acc_balance'] = 0.0;
         
        $acc_sql = "INSERT INTO $table (acc_num, acc_pwd, ".
                 "acc_type, acc_balance) VALUES (";
        $acc_sql .= "'".$where['acc_num']."',";
        $acc_sql .= "'".$where['acc_pwd']."',";
        $acc_sql .= "'".$where['acc_type']."',";
        $acc_sql .= "'".$where['acc_balance']."')";

        $acc_result = $this->_bankAccountDB->single_insert($acc_sql);
        if($acc_result == true){//添加账户成功以后，获取acc_id
            $col = "acc_id";
            $where = "acc_num="."'".$where['acc_num']."'";
            $order = null;
            $limit = 0;

            
            $acc_id = $this->_bankAccountDB->fetchCols($col,$where,$order,$limit);
            //get current user_id
            session_start();
            $user_id = $_SESSION['user_id'];

            $user_acc_sql = "INSERT INTO bk_user_acc (user_id, acc_id) VALUES (";
            $user_acc_sql .= "'".$user_id."',";
            $user_acc_sql .= "'".$acc_id[0]['acc_id']."')";

            $result = $this->_bankUserAccDB->single_insert($user_acc_sql);
        }else{//添加账户失败了

        }

        
         return $result;
    }

    //根据用户ID获取此用户所有的acc_id
    function getAccountIdsByUserId($where){
        $data = $this->_bankUserAccDB->fetchAll($where);
        $result = array();
        foreach ($data as $val) {
            $result[$val['user_id']][] = $val['acc_id'];
        }
        return $result;
    }

    //根据acc_id获取账户的信息
    function getAccountInfoByAccIds($where){
        $where['acc_state'] = 1;
        $data = $this->_bankAccountDB->fetchAll($where);
        $result = array();
        foreach ($data as $val){
            $result[$val['acc_id']] = $val;
        }
        return $result;
    }

    //根据acc_id删除账户
    function delAccountById($where){
        $where['acc_state'] = 0;
        $sql = "UPDATE bk_account SET acc_state = '".$where['acc_state']."' WHERE acc_id = '" .$where['acc_id']."'";
        $result = $this->_bankAccountDB->single_insert($sql);
        return $result;
    }
>>>>>>> 953c2b27ffda4bbe252f8468d66a019005e04913
    
}

