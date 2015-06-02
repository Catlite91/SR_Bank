<?php
class home_Controller extends Controller{
    function init(){
        $this->_User = Load::model("basic", "bk_data");
    }
    
    function showPageAction(){
        $tpl = "user_modify_password.tpl";
        $this->display($tpl);
    }
    
}

