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
    
    function modifyAction(){
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
    
}

