<?php
class showaccounts_Controller extends Controller{
    function init(){
        $this->_User = Load::model("basic", "bk_data");
    }

    function showuseraccountsAction(){
        $tpl = "user_show_accounts.tpl";


        session_start();
        $this->assign("user_no", $_SESSION['user_no']);
        $this->display($tpl);
    }


}
