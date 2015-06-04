<?php

class transfer_Controller extends Controller{
    function init(){
        $this->_transfer = Load::model("transfer", "bk_data");
        $this->_bankUser = Load::model("basic", "bk_data");
    }
    
    function showTestAction(){
         $tpl = "user_account_transfer.tpl";
         $this->assign("showTest", "active");
         $this->display($tpl);
    }
    function showAccountTransfAction(){
        $tpl = "user_account_transfer.tpl";
        session_start();
        $user_id = $_SESSION['user_id'];
        $where = array();
        $where['user_id'] = $user_id;
        $accountData = $this->_transfer->getAccountIdsByUsrIds($where);
        $accountIds = array();
        $accountIds['acc_id'] = $accountData[$user_id];
        $accountInfo = $this->_transfer->getAccountInfoByIds($accountIds);
        $user_account = array();
        $acc_balance = "";
        foreach ($accountInfo as $val){
            $user_account[$val['acc_id']] = $val['acc_num'];
            $acc_balance .= $val['acc_num'] ."_" . $val['acc_balance']."|";
        }
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("acc_ids", $user_account);
        $this->assign("trans_acc_ids", $user_account);
        $this->assign("acc_balance", $acc_balance);
        $this->display($tpl);
    }
    
    function showBankTransfAction(){
        $tpl = "user_bank_transfer.tpl";
        $this->display($tpl);
    }
    
    function ajaxGetAccountBalance(){
        $acc_id = $this->_get("acc_id");
        $where = array();
        $where['acc_id'] = $acc_id;
        $data = $this->_transfer->getAccountInfoByIds($where);
        $acc_balance = $data['acc_balance'];
        $result = array();
        $result['acc_balance'] = $acc_balance;
        json_encode($result);
    }
    
    function ajaxAccountTransfAction(){
        $result = array();
        session_start();
        $acc_id = $this->_get("acc_id");
        $trans_acc_id = $this->_get('trans_acc_id');
        $trans_amount = $this->_get("trans_amount");
        $trans_currency = $this->_get('trans_currency');
        $user_id = $_SESSION['user_id'];
        $trans_message = $this->_get('trans_message');
        $trans_password = $this->_get("acc_pwd");
        
        $acc_data = array();
        $trans_acc_data = array();
        $acc_where = array();
        $acc_where['acc_id'][] = $acc_id;
        $acc_where['acc_id'][] = $trans_acc_id;
        $acc_temp_data =  $this->_transfer->getAccountInfoByIds($acc_where);
        $acc_pwd = $acc_temp_data[$acc_id]['acc_pwd'];
        $acc_balance = $acc_temp_data[$acc_id]['acc_balance'];
        $trans_acc_balance = $acc_temp_data[$trans_acc_id]['acc_balance'];
        if($acc_pwd !== $trans_password){
            $result['msg'] = "Error Password";
            json_encode($result);
        }else{
            $acc_data['user_id'] = $user_id;
            $acc_data['trans_user_id'] = $user_id;
            $acc_data['acc_id'] = $acc_id;
            $acc_data['trans_acc_id'] = $trans_acc_id;
            $acc_data['trans_currency'] = $trans_currency;
            $acc_data['trans_balance'] = $acc_balance - $trans_currency;
            $acc_data['trans_amount'] = $trans_amount;
            $acc_data['trans_time'] =  date("Y-m-d H:i:s",time());
            $acc_data['trans_message'] = $trans_message;
            $acc_data['trans_type'] = 1;
            $acc_data['trans_state'] = 1;


            $trans_acc_data['user_id'] = $user_id;
            $trans_acc_data['trans_user_id'] = $user_id;
            $trans_acc_data['acc_id'] = $trans_acc_id;
            $trans_acc_data['trans_acc_id'] = $acc_id;
            $trans_acc_data['trans_currency'] = $trans_currency;
            $trans_acc_data['trans_balance'] = $trans_acc_balance + $trans_currency;
            $trans_acc_data['trans_amount'] = $trans_amount;
            $trans_acc_data['trans_time'] = date("Y-m-d H:i:s",time());
            $trans_acc_data['trans_message'] = $trans_message;
            $trans_acc_data['trans_type'] = 2;
            $trans_acc_data['trans_state'] = 1;
            print_r($acc_data);
            print_r($trans_acc_data);
            $this->_transfer->addTransferInfo($acc_data, $trans_acc_data, $user_id);
        }
        
    }
    
    function bankTransfAction(){
        
    }
}