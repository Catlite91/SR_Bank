<?php

class transfer_Controller extends Controller{
    function init(){
        $this->_transfer = Load::model("transfer", "bk_data");
    }
    
    function showAccountTransfAction(){
        $tpl = "user_account_transfer.tpl";
        session_start();
        $this->assign("user_id", $_SESSION['user_no']);
        $user_no = $_SESSION[];
        $this->display($tpl);
    }
    
    function showBankTransfAction(){
        $tpl = "user_bank_transfer.tpl";
        $this->display($tpl);
    }
    
    function accountTransfAction(){
        
    }
    
    function bankTransfAction(){
        
    }
}