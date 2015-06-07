<?php
class account_Controller extends Controller{
    public static $account_type_map =  array(
            "C" => "Credit",
            "D" => "Debit"
    );
    function init(){
        $this->_User = Load::model("basic", "bk_data");
        $this->_transfer = Load::model("transfer", "bk_data");
    }
    
    function showPageAction(){
        $tpl = "user_home.tpl";
        $this->getUserInfo();
        session_start();
        $this->assign("user_no", $_SESSION['user_no']);
        $this->display($tpl);
    }
    
    function addAccountAction(){
        $tpl = "user_add_account.tpl";
         session_start();
         $this->getUserInfo();
        // $user_id = $_SESSION['user_id'];
        $acc_res =  $this->_get("acc_res");
        if(!empty($acc_res)){
            $this->assign("acc_res", $acc_res);
        }
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("showAddAccount", "active");
        $this->display($tpl);
    }


    //new an account for user
    function addAccAction(){
        
        //get new account info
        $acc_num = $this->_get("acc_num");
        $acc_pwd = $this->_get("acc_pwd");
        $acc_type = $this->_get("acc_type");
        //verify unique acc_num
        $accNum['acc_num'] = $acc_num;
        $data = $this->_User->getAccByIds($accNum);

        if(empty($data)){
            $where['acc_num'] = $acc_num;
            $where['acc_pwd'] = $acc_pwd;
            $where['acc_type'] = $acc_type;
            $where['acc_state'] = 2;
            $addAccSuccess = $this->_User->addAccount($where);
            if($addAccSuccess == true){
                //添加账户成功，转到转账页面
                header("Location: ../account/addAccount.do?acc_res=1");
            }else{
                //添加账户失败
                header("Location: ../account/addAccount.do?acc_res=3");
            }
        }else{
            //该卡号已存在
            header("Location: ../account/addAccount.do?acc_res=2");
        }
        
    }

//初始化删除账户的页面
    function delAccountAction(){
        $tpl = "user_delete_account.tpl";
        session_start();
        $this->getUserInfo();
        $user_id = $_SESSION['user_id'];
        $where = array();
        $where['user_id'] = $user_id;
        $accountData = $this->_User->getAccountIdsByUserId($where);

        if(empty($accountData)){
            
        }else{
            $accountIds = array();
            $accountIds['acc_id'] = $accountData[$user_id];

            $accountInfo = $this->_User->getAccountInfoByAccIds($accountIds);
            $user_account = array();
            $i = 0;
            foreach ($accountInfo as $val){
                $user_account[$i]['acc_no'] = $val['acc_num'];
                $user_account[$i]['acc_type'] = self::$account_type_map[$val['acc_type']];
                $user_account[$i]['acc_id'] = $val['acc_id'];
                $i++;
            }
            $this->assign("acc_info", $user_account);
            $this->assign("user_no", $_SESSION['user_no']);
            $this->assign("showDelAccount", "active");
            $this->display($tpl);
        }
    }

    //删除账户
    function delAccAction(){
        $acc_id = $this->_get("acc_id");
        $where['acc_id'] = $acc_id;
        $delAccSuccess = $this->_User->delAccountById($where);
        $result = array();
        if($delAccSuccess == true){
                //删除账户成功，转到转账页面
            $result['flag'] = 1;
        }else{
                //删除账户失败
            $result['flag'] = 0;
            $result['msg'] = "Error";
        }
        echo json_encode($result);
    }
    
    function getUserInfo(){
       $user_id = $_SESSION['user_id'];
       $where = array();
       $where['user_id'] = $user_id;
       $data = $this->_transfer->getBkUserInfoByIds($where);
       $this->assign("user_no", $data[$user_id]['user_no']);
       $this->assign("user_name", $data[$user_id]['user_name']);
       $this->assign("user_tel", $data[$user_id]['user_tel']);
       $this->assign("user_email", $data[$user_id]['user_email']);
    }
  
}

