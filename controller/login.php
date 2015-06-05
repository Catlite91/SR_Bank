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
            $_SESSION['user_no'] = $data['user_no'];
            $_SESSION['user_name'] = $data['user_name'];
            if($data['role_id'] == 1){    //admin
                header("Location: ../admin/home/showPage.do");
            }else if($data['role_id'] == 2){
                header("Location: ../user/home/showPage.do");
            }
        }        
    }
    
    function signAction(){
        $tpl = "sign_up.tpl";
        $this->display($tpl);
    }
    
    function signUpAction(){
       $user_no = $this->_get("user_no");
        $user_name = $this->_get("user_name");
        $user_identity = $this->_get("user_identity");
        $user_gender = $this->_get("user_gender");
        $user_tel = $this->_get("user_tel");
        $user_email = $this->_get("user_email");
        $user_pwd = $this->_get("user_pwd");
        
        $userNo['user_no'] = $user_no;
        $data = $this->_User->getUserByIds($userNo);
        //$where = array();
        if(empty($data)){
            $where['user_no'] = $user_no;
            $where['user_name'] = $user_name;
            $where['user_identity'] = $user_identity;
            $where['user_gender'] = $user_gender;
            $where['user_tel'] = $user_tel;
            $where['user_email'] = $user_email;
            $where['user_pwd'] = $user_pwd;
            
            $signUpSuccess = $this->_User->signUpUser($where);
            if($signUpSuccess == true){
                //注册成功，转到登录页面
                header("Location: ../login/index.do");
            }else{
                //注册失败
                header("Location: ../user/home/modify.do");
            }
          
        }else{
            //该用户名已存在
            $this->assign("signUp_error", "username already exists");
            $this->signUpAction();    
        } 
        
            
    }
    
    function AjaxTestUserNameAction(){
        $user_name = $this->_get("user_no");
        $result = array();
        $where = array();
        $where['user_no'] = $user_name;
        $data = $this->_User->getUserByIds($where);
        if(empty($data)){
           $result['msg'] = 1;   // you can use this name;
        }else{
            $result['msg'] = 0;  //already exists;
        }
        echo json_encode($result);
    }
    
} 