<?php
class home_Controller extends Controller{
    function init(){
        $this->_User = Load::model("basic", "bk_data");

    }
    
    function showPageAction(){
        $tpl = "user_home.tpl";
        session_start();
        $this->assign("user_no", $_SESSION['user_no']);
        $this->display($tpl);
    }
    
    function addAccountAction(){
        $tpl = "user_add_account.tpl";
        $this->display($tpl);
    }

    //new an account for user
    function addAccAction(){
        
        // session_start();
        // $user_id = $_SESSION['user_id'];

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

            $addAccSuccess = $this->_User->addAccount($where);
            if($addAccSuccess == true){
                //添加账户成功，转到转账页面
                header("Location: ../home/showPage.do");
            }else{
                //添加账户失败
            }
        }else{
            //该卡号已存在
            
        }
        
    }

//初始化删除账户的页面
    function delAccountAction(){
        $tpl = "user_delete_account.tpl";
        session_start();
        $user_id = $_SESSION['user_id'];
        $where = array();
        $where['user_id'] = $user_id;
        $accountData = $this->_User->getAccountIdsByUserId($where);


        $accountIds = array();
        $accountIds['acc_id'] = $accountData[$user_id];

        $accountInfo = $this->_User->getAccountInfoByAccIds($accountIds);
        var_dump($accountInfo);
        $user_account = array();
        foreach ($accountInfo as $val){
            $user_account[$val['acc_id']] = $val['acc_id'];
            
            $user_account[$val['acc_num']] = $val['acc_num'];
        }
        var_dump($user_account);

        $this->display($tpl);
    }

    //删除账户
    function delAccAction(){
        $acc_id = $this->_get("acc_id");
        $where['acc_id'] = $acc_id;
        $delAccSuccess = $this->_User->delAccountById($where);
        if($delAccSuccess == true){
                //删除账户成功，转到转账页面
                header("Location: ../home/showPage.do");
        }else{
                //删除账户失败
        }
    }
    
    
}

