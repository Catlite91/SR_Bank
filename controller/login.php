<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
class login_Controller extends Controller {

    function init() { 
        $this->_User = Load::model('basic', 'bk_data');
    }
    function indexAction() {
        $tpl = "login.tpl";
        $this->display($tpl);
    }
    
    
    function loginAction(){
        $user_id = $this->_get("user_id");
        $user_pwd = $this->_get("user_pwd");
        $data = $this->_User->loginUserByIds($user_id, $user_pwd);
        if(empty($data)){
            $this->assign("login_error", "error_login");
            $this->indexAction();          
        }else{
            session_start();
            $_SESSION['user_id'] = $data['user_id'];
            $_SESSION['user_name'] = $data['user_name'];
            if($data['role_id'] == 1){    //admin
                header("Location: admin/showPage.do");
            }else if($data['role_id'] == 2){
                header("Location: user/showPage.do");
            }
        }        
    }
    
    function signAction(){
        $tpl = "sign_up.tpl";
        $this->display($tpl);
    }
    
    function signUpAction(){
        $user_name = $this->_get("user_name");
        $user_phone = $this->_get("user_phone");
        $user_email = $this->_get("user_email");
        $user_pic_id = $this->_get("user_pic_id");
        $user_password = $this->_get("user_password");
        $user_website = $this->_get("user_website");
        $user_message = $this->_get("user_message");
        $user_birth = $this->_get("user_birth");
        $user_gender = $this->_get("user_gender");
        $result = array();
        $where = array();
        $where['user_name'] = $user_name;
        $where_user_info = array();
        $data = $this->_User->getUserByIds($where);
        if(empty($data)){
            $where['user_phone'] = $user_phone;
            $where['user_pic_id'] = $user_pic_id;
            $where['user_password'] = $user_password;
            $where['user_email'] = $user_email;
            $this->_User->insertUserTable($where);
            $user_data = $this->_User->getUserByIds($where);
            foreach ($user_data as $key => $val){
                 $user_id = $key;
            }
            $where_user_info['user_id'] = $user_id;
            $where_user_info['user_name'] = $user_name;
            $where_user_info['user_email'] = $user_email;
            $where_user_info['user_website'] = $user_website;
            $where_user_info['user_message'] = $user_message;
            $where_user_info['user_age'] = 2015- explode("-", $user_birth)[0] + 1;
            $where_user_info['user_birth'] = $user_birth;
            $where_user_info['user_pic_id'] = $user_pic_id;
            $where_user_info['user_gender'] = $user_gender;
            $where_user_info['user_phone'] = $user_phone;    
//            $where_user_info['user_id'] = $user_id;
            $this->_User->insertUserInfoTable($where_user_info);
            $tpl = "user_info_login.tpl";
            $this->assign("user_id", $user_name);
            $this->assign("user_password", $user_password);
            $this->display($tpl);
        }else{
            $result['error'] = "user name already exists";
        }
            
    }
    
    function AjaxTestUserNameAction(){
        $user_name = $this->_get("user_name");
        $result = array();
        $where = array();
        $where['user_name'] = $user_name;
        $data = $this->_User->getUserByIds($where);
        if(empty($data)){
           $result['msg'] = 1;   // you can use this name;
        }else{
            $result['msg'] = 0;  //already exists;
        }
        echo json_encode($result);
    }
    
} 
 