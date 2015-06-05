<?php
class modify_Controller extends Controller{
    function init(){
        $this->_User = Load::model("modify", "bk_data");
    }
    function showmodifypwdAction(){
      session_start();
      $this->assign("user_no", $_SESSION['user_no']);
      $tpl = "user_modify_password.tpl";
      $this->assign("showmodifypwd", "active");
      $this->display($tpl);
    }
    function showmodifybasicinfoAction(){
      session_start();
      $this->assign("user_no", $_SESSION['user_no']);
      $tpl = "user_modify_basicinfo.tpl";
      $this->assign("showmodifybasicinfo", "active");
      $this->display($tpl);
    }
    function modifypwdAction()
    {
      session_start();
      $user_id = $_SESSION['user_id'];
      $old_pwd=$this->_get("old_pwd");
      $new_pwd=$this->_get("new_pwd");
      $confirm_pwd=$this->_get("confirm_new_pwd");
      if($new_pwd!=$confirm_pwd)
      {
        echo "<script>alert('Please confirm the new password again'); history.go(-1);</script>";
        $tpl = "user_modify_password.tpl";
        $this->display($tpl);
      }
      else {
        $dat = $this->_User->loginUserByIds($user_id, $old_pwd);
        if(empty($dat)){
          echo "<script>alert('Ole password is wrong!'); history.go(-1);</script>";
          $tpl = "user_modify_password.tpl";
          $this->display($tpl);
        }
        else {
          $data = array();
          $where=array();
          $data['user_pwd']=$new_pwd;
          $table="bk_user";
          $where["user_id"]=$user_id;
          $data=$this->_User->UpdateUserByIds($table,$data,$where);
          $tpl = "user_modify_password.tpl";
          $this->display($tpl);
        }

      }

    }
    function modifybasicinfoAction()
    {
      session_start();
      $user_id = $_SESSION['user_id'];
      $mobile_number=$this->_get("mobile_phone");
      $email=$this->_get("Email");
      $data=array();
      $where=array();
      $data['user_tel']=$mobile_number;
      $data['user_email']=$email;
      $table="bk_user";
      $where["user_id"]=$user_id;
      $data=$this->_User->UpdateUserByIds($table,$data,$where);
      $tpl = "user_modify_basicinfo.tpl";
      $this->display($tpl);
      echo "<script>alert('Modify Success!'); history.go(-1);</script>";
    }
}
