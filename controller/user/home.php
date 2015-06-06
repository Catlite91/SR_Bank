<?php
class home_Controller extends Controller{
    function init(){
        $this->_User = Load::model("basic", "bk_data");
    }
    
    function showPageAction(){
        $tpl = "user_home.tpl";
        session_start();
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("showPage", "active");
        $this->display($tpl);
    }
}

