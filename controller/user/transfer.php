<?php

class transfer_Controller extends Controller{
    
    public static $trans_type_map =  array(
            1 => "Account Transfer Out",
            2 => "Account Transfer In",
            3 => "Bank Transfer Out",
            4 => "Bank Transfer In",
            5 => "Bank Deposit",
            6 => "Bank WithDraw"
    );
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
        $this->getUserInfo();
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
            $acc_balance .= $val['acc_id'] ."_" . $val['acc_balance']."|";
        }
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("acc_ids", $user_account);
        $this->assign("trans_acc_ids", $user_account);
        $this->assign("acc_balance", $acc_balance);
        $this->assign('showAccountTransf', "active");
        $this->display($tpl);
    }
    
    function showBankTransfAction(){
        $tpl = "user_bank_transfer.tpl";
        session_start();
        $this->getUserInfo();
        $user_id = $_SESSION['user_id'];
        $where['user_id'] = $user_id;
        $accountData = $this->_transfer->getAccountIdsByUsrIds($where);
        $accountIds = array();
        $accountIds['acc_id'] = $accountData[$user_id];
        $accountInfo = $this->_transfer->getAccountInfoByIds($accountIds);
        $user_account = array();
        $acc_balance = "";
        foreach ($accountInfo as $val){
            $user_account[$val['acc_id']] = $val['acc_num'];
            $acc_balance .= $val['acc_id'] ."_" . $val['acc_balance']."|";
        }
        $this->assign("showBankTransf", "active");
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("acc_ids", $user_account);
        $this->assign("acc_balance", $acc_balance);
        $this->display($tpl);
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
            $result['flag'] = 0;
            echo json_encode($result);
        }else{
            $acc_data['user_id'] = $user_id;
            $acc_data['trans_user_id'] = $user_id;
            $acc_data['acc_id'] = $acc_id;
            $acc_data['trans_acc_id'] = $trans_acc_id;
            $acc_data['trans_currency'] = $trans_currency;
            $acc_data['trans_balance'] = $acc_balance - $trans_amount;
            $acc_data['trans_amount'] = -$trans_amount;
            $acc_data['trans_time'] =  date("Y-m-d H:i:s",time());
            $acc_data['trans_message'] = $trans_message;
            $acc_data['trans_type'] = 1;
            $acc_data['trans_state'] = 1;

            $trans_acc_data['user_id'] = $user_id;
            $trans_acc_data['trans_user_id'] = $user_id;
            $trans_acc_data['acc_id'] = $trans_acc_id;
            $trans_acc_data['trans_acc_id'] = $acc_id;
            $trans_acc_data['trans_currency'] = $trans_currency;
            $trans_acc_data['trans_balance'] = $trans_acc_balance + $trans_amount;
            $trans_acc_data['trans_amount'] = $trans_amount;
            $trans_acc_data['trans_time'] = date("Y-m-d H:i:s",time());
            $trans_acc_data['trans_message'] = $trans_message;
            $trans_acc_data['trans_type'] = 2;
            $trans_acc_data['trans_state'] = 1;
            $tag = $this->_transfer->addTransferInfo($acc_data, $trans_acc_data, $user_id, $user_id);
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
    }
    
    function ajaxBankTransfAction(){
        $result = array();
        session_start();
        $acc_id = $this->_get("acc_id");
        $trans_acc_num = $this->_get('trans_acc_num');
        $trans_amount = $this->_get("trans_amount");
        $trans_currency = $this->_get('trans_currency');
        $user_id = $_SESSION['user_id'];
        $trans_message = $this->_get('trans_message');
        $trans_password = $this->_get("acc_pwd");
        $acc_data = array();
        $trans_acc_data = array();
        $acc_where = array();
        $acc_where_2 = array();
        $acc_where['acc_id'][] = $acc_id;
        $acc_where_2['acc_num'][] = $trans_acc_num;
        $acc_temp_data =  $this->_transfer->getAccountInfoByIds($acc_where);
        $acc_temp_data_2 =  $this->_transfer->getAccountInfoByNos($acc_where_2);
        $acc_pwd = $acc_temp_data[$acc_id]['acc_pwd'];
        $acc_balance = $acc_temp_data[$acc_id]['acc_balance'];
        $trans_acc_balance = $acc_temp_data_2[$trans_acc_num]['acc_balance'];
        $trans_acc_id = $acc_temp_data_2[$trans_acc_num]['acc_id'];
        $trans_acc_temp= $this->_transfer->getAccountIdsByUsrIds(array('acc_id' => $trans_acc_id));
        $trans_user_id = array_keys($trans_acc_temp)[0];
        if($acc_pwd !== $trans_password){
            $result['msg'] = "Error Password";
            $result['flag'] = 0;
            echo json_encode($result);
        }else{
            $acc_data['user_id'] = $user_id;
            $acc_data['trans_user_id'] = $trans_user_id;
            $acc_data['acc_id'] = $acc_id;
            $acc_data['trans_acc_id'] = $trans_acc_id;
            $acc_data['trans_currency'] = $trans_currency;
            $acc_data['trans_balance'] = $acc_balance - $trans_amount;
            $acc_data['trans_amount'] = -$trans_amount;
            $acc_data['trans_time'] =  date("Y-m-d H:i:s",time());
            $acc_data['trans_message'] = $trans_message;
            $acc_data['trans_type'] = 3;
            $acc_data['trans_state'] = 1;

            $trans_acc_data['user_id'] = $trans_user_id;
            $trans_acc_data['trans_user_id'] = $user_id;
            $trans_acc_data['acc_id'] = $trans_acc_id;
            $trans_acc_data['trans_acc_id'] = $acc_id;
            $trans_acc_data['trans_currency'] = $trans_currency;
            $trans_acc_data['trans_balance'] = $trans_acc_balance + $trans_amount;
            $trans_acc_data['trans_amount'] = $trans_amount;
            $trans_acc_data['trans_time'] = date("Y-m-d H:i:s",time());
            $trans_acc_data['trans_message'] = $trans_message;
            $trans_acc_data['trans_type'] = 4;
            $trans_acc_data['trans_state'] = 1;
            $tag = $this->_transfer->addTransferInfo($acc_data, $trans_acc_data, $user_id, $trans_user_id);
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
    }
    
    function showBankTransfResultAction(){
        $tpl = "user_bank_transfer_result.tpl";
        session_start();
        $this->getUserInfo();
        $where = array();
        $user_id = $_SESSION['user_id'];
        $where['user_id'][] = $user_id;
        $data = $this->_transfer->getTransferInfoByIds($where, $user_id);
        $acc_where = array();
        $where["user_id"][] = $data[$user_id]['trans_user_id'];
        $user_data = $this->_transfer->getBkUserInfoByIds($where);
        $acc_where['acc_id'][] = $data[$user_id]['acc_id'];
        $acc_where['acc_id'][] = $data[$user_id]['trans_acc_id'];
        $acc_temp_data =  $this->_transfer->getAccountInfoByIds($acc_where);

        $trans_type = self::$trans_type_map[$data[$user_id]['trans_type']];
        $this->assign("user_no", $user_data[$user_id]['user_name']);
        $this->assign("acc_no", $acc_temp_data[$data[$user_id]['acc_id']]['acc_num']);
        $this->assign("trans_user_no", $user_data[$data[$user_id]['trans_user_id']]['user_name']);
        $this->assign("trans_acc_no", $acc_temp_data[$data[$user_id]['trans_acc_id']]['acc_num']);
        $this->assign("trans_type", $trans_type);
        $this->assign("trans_currency", $data[$user_id]['trans_currency']);
        $this->assign("trans_amount", $data[$user_id]['trans_amount']);
        $this->assign("trans_time", $data[$user_id]['trans_time']);
        $this->assign("trans_message", $data[$user_id]['trans_message']);
        $this->assign('showBankTransf', "active");
        $this->display($tpl);
    }
    
    function showAccountTransfResultAction(){
        $tpl = "user_account_transfer_result.tpl";
        session_start();
        $this->getUserInfo();
        $where = array();
        $user_id = $_SESSION['user_id'];
        $where['user_id'] = $user_id;
        $user_data = $this->_transfer->getBkUserInfoByIds($where);
        $data = $this->_transfer->getTransferInfoByIds($where, $user_id);
        $acc_where = array();
        $acc_where['acc_id'][] = $data[$user_id]['acc_id'];
        $acc_where['acc_id'][] = $data[$user_id]['trans_acc_id'];
        $acc_temp_data =  $this->_transfer->getAccountInfoByIds($acc_where);

        $trans_type = self::$trans_type_map[$data[$user_id]['trans_type']];
        $this->assign("user_no", $user_data[$user_id]['user_name']);
        $this->assign("acc_no", $acc_temp_data[$data[$user_id]['acc_id']]['acc_num']);
        $this->assign("trans_acc_no", $acc_temp_data[$data[$user_id]['trans_acc_id']]['acc_num']);
        $this->assign("trans_type", $trans_type);
        $this->assign("trans_currency", $data[$user_id]['trans_currency']);
        $this->assign("trans_amount", $data[$user_id]['trans_amount']);
        $this->assign("trans_time", $data[$user_id]['trans_time']);
        $this->assign("trans_message", $data[$user_id]['trans_message']);
        $this->assign('showAccountTransf', "active");
        $this->display($tpl);
        
    }
    
    function ajaxShowAccountInfoAction(){
        $where = array();
        $acc_num = $this->_get("trans_acc_num");
        $where['acc_num'] = $acc_num;
        $accInfo = $this->_transfer->getAccountInfoByNos($where);
        if(empty($accInfo)){
            $result['user_no'] = 0;
            echo json_encode($result);
        }else{
            $acc_id = $accInfo[$acc_num]['acc_id'];
            $userAccInfo = $this->_transfer->getAccountIdsByUsrIds(array("acc_id"=>$acc_id));
            $user_id = array_keys($userAccInfo)[0];
            $userInfo = $this->_transfer->getBkUserInfoByIds(array('user_id'=>$user_id));
            $user_no = $userInfo[$user_id]['user_no'];
            $result = array();
            $result['user_no'] = $user_no;
            echo json_encode($result);
        }
        
    }
    
    function showTransactionAction(){
        $tpl = "user_transfer_query.tpl";
        session_start();
        $this->getUserInfo();
        $user_id = $_SESSION['user_id'];
        $where['user_id'] = $user_id;
        $accountData = $this->_transfer->getAccountIdsByUsrIds($where);
        $accountIds = array();
        $accountIds['acc_id'] = $accountData[$user_id];
        $accountInfo = $this->_transfer->getAccountInfoByIds($accountIds);
        $user_account = array();
        $user_account[0] = "All";
        foreach ($accountInfo as $val){
            $user_account[$val['acc_id']] = $val['acc_num'];
        }
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("acc_ids", $user_account);
        $this->assign('showTransaction', "active");
        $this->display($tpl);
    }
    
    function ajaxShowQueryResultAction(){
        $acc_id = $this->_get("acc_id");
        $trans_currency = $this->_get("trans_currency");
        $query_start_time = date("Y-m-d H:i:s", strtotime($this->_get("start_time"))+86400);
        $query_end_time = date("Y-m-d H:i:s", strtotime($this->_get("end_time"))+ 86400);
        $where = array();
        session_start();
        $user_id = $_SESSION['user_id'];
        if($acc_id == 0){
            // query all account
        }else{
            $where['acc_id'] = $acc_id;
        }
        $where['trans_currency'] = $trans_currency;
        $where[1] = "trans_time >= '$query_start_time'";
        $where[2] = "trans_time <= '$query_end_time'";
        $where['user_id'] = $user_id;
        $data = $this->_transfer->getAllTransferInfoByIds($where, $user_id);
        $acc_where = array();
        $result = array();
        if(empty($data)){
           $result['flag']  = 0;  //no data
        }else{
            foreach($data[$user_id] as $val){
                $acc_where['acc_id'][] = $val['acc_id'];
            }
            $acc_data = $this->_transfer->getAccountInfoByIds($acc_where);

            $res_data = array();
            $i = 0;
            foreach($data[$user_id] as $val){
                $res_data[$i]['acc_no'] = $acc_data[$val['acc_id']]['acc_num'];
                $res_data[$i]['trans_time'] = $val['trans_time'];
                $res_data[$i]['trans_type'] = self::$trans_type_map[$val['trans_type']];
                $res_data[$i]['trans_amount'] = $val['trans_amount'];
                $i++;
            }
            $result['flag'] = 1;
            $result['data'] = $res_data;
        }
        echo json_encode($result);
    }
    
    function showDownloadTransactionAction(){
        $tpl = "user_transfer_download.tpl";
        session_start();
        $this->getUserInfo();
        $user_id = $_SESSION['user_id'];
        $where['user_id'] = $user_id;
        $accountData = $this->_transfer->getAccountIdsByUsrIds($where);
        $accountIds = array();
        $accountIds['acc_id'] = $accountData[$user_id];
        $accountInfo = $this->_transfer->getAccountInfoByIds($accountIds);
        $user_account = array();
        $user_account[0] = "All";
        foreach ($accountInfo as $val){
            $user_account[$val['acc_id']] = $val['acc_num'];
        }
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("acc_ids", $user_account);
        $this->assign('showDownloadTransaction', "active");
        $this->display($tpl);
    }
    
    function ajaxDownloadTransactionAction(){
        $acc_id = $this->_get("acc_id");
        $trans_currency = $this->_get("trans_currency");
        $query_start_time = date("Y-m-d H:i:s", strtotime($this->_get("start_time"))+86400);
        $query_end_time = date("Y-m-d H:i:s", strtotime($this->_get("end_time"))+ 86400);
        $where = array();
        session_start();
        $user_id = $_SESSION['user_id'];
        if($acc_id == 0){
            // query all account
        }else{
            $where['acc_id'] = $acc_id;
        }
        $where['trans_currency'] = $trans_currency;
        $where[1] = "trans_time >= '$query_start_time'";
        $where[2] = "trans_time <= '$query_end_time'";
        
        $data = $this->_transfer->getAllTransferInfoByIds($where, $user_id);
        if(empty($data)){
            echo "NO Data";
        }else{
            $acc_where = array();
            $user_where = array();
            $user_where['user_id'][] = $user_id;
            foreach($data[$user_id] as $val){
                $acc_where['acc_id'][] = $val['acc_id'];
                $user_where['user_id'][] = $val['trans_user_id'];
            }
            $acc_data = $this->_transfer->getAccountInfoByIds($acc_where);
            $user_data = $this->_transfer->getBkUserInfoByIds($user_where);
            $res_data = array();
            $i = 0;
            foreach($data[$user_id] as $val){
                $res_data[$i]['trans_id'] = $val['trans_id'];
                $res_data[$i]['user_name'] = $user_data[$user_id]['user_name'];
                $res_data[$i]['acc_num'] = $acc_data[$val['acc_id']]['acc_num'];
                $res_data[$i]['trans_user_name'] = $user_data[$val['trans_user_id']]['user_name'];
                $res_data[$i]['trans_acc_num'] = $acc_data[$val['acc_id']]['acc_num'];
                $res_data[$i]['trans_type'] = self::$trans_type_map[$val['trans_type']];
                $res_data[$i]['trans_currency'] = $val['trans_currency'];
                $res_data[$i]['trans_amount'] = $val['trans_amount'];
                $res_data[$i]['trans_balance'] = $val['trans_balance'];
                $res_data[$i]['trans_time'] = $val['trans_time'];
                $res_data[$i]['trans_message'] = $val['trans_message'];
                $i++;
            }
            $head = iconv("utf-8", "utf-8", "Transfter Number,User Number,Account Number,Transfer User Number,Transfer Account Number,Transfer Type, Transfer Currency,Transfer Amount,Transfer Balance,Transfer Time, Transfer Message\r\n");
            $tempContent = "";
            foreach ($res_data as $val) {
                $tempContent .= $val['trans_id'] . ',';
                $tempContent .= $val['user_name'] . ',';
                $tempContent .= $val['acc_num'] . ',';
                $tempContent .= $val['trans_user_name'] . ',';
                $tempContent .= $val['trans_acc_num'] . ',';
                $tempContent .= $val['trans_type'] . ',';
                $tempContent .= $val['trans_currency'] . ',';
                $tempContent .= $val['trans_amount'] . ',';
                $tempContent .= $val['trans_balance'] . ',';
                $tempContent .= $val['trans_time'] . ',';
                $tempContent .= $val['trans_message'];
                $tempContent .= "\r\n";
            }
//            $encode = mb_detect_encoding($tempContent, array("ASCII","UTF-8","GB2312","GBK","BIG5")); 
            $file_name = date("Y-m-d H:i:s", strtotime($query_start_time)) ."-".date("Y-m-d H:i:s", strtotime($query_end_time)) ."Transfer Data";
            $content = iconv("utf-8", "utf-8", $tempContent);
            $fileName = iconv("utf-8", "utf-8", $file_name);
            header("Content-type: application/vnd.ms-excel");
            header("Content-Disposition: attachment; filename=" . $fileName . ".csv");
            echo $head . $content;
            exit();
        }
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