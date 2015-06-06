<?php
class home_Controller extends Controller{
    function init(){
        $this->_User = Load::model("basic", "bk_data");
        $this->_transfer = Load::model("transfer", "bk_data");
    }
    
    function showPageAction(){
        $tpl = "user_home.tpl";
        session_start();
        $this->getUserInfo();
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("showPage", "active");
        $this->display($tpl);
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


