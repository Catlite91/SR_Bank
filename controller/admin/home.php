<?php
class home_Controller extends Controller{
    public static $account_type_map =  array(
            "C" => "Credit",
            "D" => "Debit"
    );
    
    public static $account_state_map = array(
        1 => "Normal",
        2 => "Audit"
    );
    function init(){
        $this->_User = Load::model("basic", "bk_data");
        $this->_transfer = Load::model("transfer", "bk_data");
    }
    
    function showPageAction(){
        $tpl = "admin_home.tpl";
        session_start();
        $this->getAdminInfo();
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("showPage", "active");
        $this->display($tpl);
    }
    
    function showAccountAction(){
        $tpl = "admin_show_account.tpl";
        session_start();
        $this->getAdminInfo();
        $user_names = array();
        $where = array();
        $where['role_id'] = 2;
        $data = $this->_transfer->getBkUserInfoByIds($where);
        $user_names[0] = "All";
        foreach($data as $key => $val){
            $user_names[$key] = $val['user_name'];
        }
        $this->assign("user_names", $user_names);
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("showAccount", "active");
        $this->display($tpl);
        
    }
    
    function ajaxShowAccountAction(){
        $user_id = $this->_get("user_id");
        $where = array();
        $where['role_id'] = 2;
        if($user_id != 0){
            $where['user_id'] = $user_id;
        }
        $user_data = $this->_transfer->getBkUserInfoByIds($where);
        $user_data_keys = array_keys($user_data);
        $user_acc_where = array();
        $user_acc_where['user_id'] = $user_data_keys;
        $acc_ids = $this->_transfer->getAccountIdsByUsrIds($user_acc_where);
        $acc_ids_where = array();
        foreach ($acc_ids as $val){
            foreach ($val as $acc_id){
              $acc_ids_where['acc_id'][] = $acc_id; 
            }
        }
        $acc_data = $this->_User->getAccountInfoByState($acc_ids_where);
        
        $result = array();
        $i = 0;
        foreach ($acc_ids as $user_id =>$acc_id_temp){
            foreach ($acc_id_temp as $acc_id){
                $result[$i]['user_name'] = $user_data[$user_id]['user_name'];
                $result[$i]['acc_num'] = $acc_data[$acc_id]['acc_num'];
                $result[$i]['acc_balance'] = $acc_data[$acc_id]['acc_balance'];
                $result[$i]['acc_state'] = self::$account_state_map[$acc_data[$acc_id]['acc_state']];
            $i++;
            }   
        }
        echo json_encode($result);
    }
    
    function authorizeAccountAction(){
        $tpl = "admin_authorize_account.tpl";
        session_start();
        $this->getAdminInfo();
        $where = array();
        $where['acc_state'] = 2;
        $accountInfo = $this->_User->getAccountInfoByState($where);
        $user_account = array();
        $i = 0;
        foreach ($accountInfo as $val){
            $user_account[$i]['acc_no'] = $val['acc_num'];
            $user_account[$i]['acc_type'] = self::$account_type_map[$val['acc_type']];
            $user_account[$i]['acc_id'] = $val['acc_id'];
            $user_account[$i]['acc_state'] = self::$account_state_map[$val['acc_state']];
            $i++;
        }
        $this->assign("acc_info", $user_account);
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("authorizeAccount", "active");
        $this->display($tpl);  
    }
    
    function ajaxAuthorizeAction(){
        $acc_id = $this->_get('acc_id');
        $where['acc_id'] = $acc_id;
        $authorizeSuccess = $this->_User->authorizeById($where);
        $result = array();
        if($authorizeSuccess == true){
            $result['flag'] = 1;
        }else{
            $result['flag'] = 0;
            $result['msg'] = "Error";
        }
        echo json_encode($result);
    }
    
    function cashAccountAction(){
        $tpl = "admin_cash_account.tpl";
        session_start();
        $this->getAdminInfo();
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("cashAccount", "active");
        $this->display($tpl);         
    }
    
    function submitCashAccountAction(){
      $acc_num = $this->_get("acc_num");
      $user_id = $this->_get("user_id");
      $trans_amount = $this->_get("trans_amount");
      $trans_type = $this->_get("trans_type");
      $acc_where = array();
      $acc_where['acc_num'] = $acc_num;
      $acc_info_data = $this->_transfer->getAccountInfoByNos($acc_where);
      $acc_data = array();
      //modify bk_account and bk_transaction
        $acc_data['user_id'] = $user_id;
        $acc_data['trans_user_id'] = $user_id;
        $acc_data['acc_id'] = $acc_info_data[$acc_num]['acc_id'];
        $acc_data['trans_acc_id'] = $acc_info_data[$acc_num]['acc_id'];
        $acc_data['trans_currency'] = "RMB";
        if($trans_type == 5){
            $acc_data['trans_balance'] = $acc_info_data[$acc_num]['acc_balance'] + $trans_amount;
            $acc_data['trans_amount'] =  $trans_amount;
        }else{
            $acc_data['trans_balance'] = $acc_info_data[$acc_num]['acc_balance'] - $trans_amount;
            $acc_data['trans_amount'] =  - $trans_amount;
        }
        $acc_data['trans_time'] =  date("Y-m-d H:i:s",time());
        $acc_data['trans_message'] = "Bank Deposit";
        $acc_data['trans_type'] = $trans_type;
        $acc_data['trans_state'] = 1;
        $tag = $this->_transfer->addTransferInfoByDeposit($acc_data, $user_id);
        if(!$tag){
            $result['msg'] = "Error 404";
            $result['flag'] = 2;
            echo json_encode($result);
        }else{
            $result['msg'] = "Succeed";
            $result['flag'] = 1;
            echo json_encode($result);
        }
}
    
    function ajaxShowAccountInfoAction(){
        $where = array();
        $acc_num = $this->_get("acc_num");
        $where['acc_num'] = $acc_num;
        $accInfo = $this->_transfer->getAccountInfoByNos($where);
        if(empty($accInfo)){
            $result['user_no'] = 0;
            echo json_encode($result);
        }else{
            $acc_id = $accInfo[$acc_num]['acc_id'];
            $acc_balance = $accInfo[$acc_num]['acc_balance'];
            $userAccInfo = $this->_transfer->getAccountIdsByUsrIds(array("acc_id"=>$acc_id));
            $user_id = array_keys($userAccInfo)[0];
            $userInfo = $this->_transfer->getBkUserInfoByIds(array('user_id'=>$user_id));
            $user_no = $userInfo[$user_id]['user_no'];
            $result = array();
            $result['user_no'] = $user_no;
            $result['user_id'] = $user_id;
            $result['acc_balance'] = $acc_balance;
            
            echo json_encode($result);
        }
        
    }

    function getAdminInfo(){
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