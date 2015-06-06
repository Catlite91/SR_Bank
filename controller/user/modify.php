<?php
class modify_Controller extends Controller{
    function init(){
        $this->_User = Load::model("modify", "bk_data");
        $this->_transfer = Load::model("transfer", "bk_data");
    }
    function showmodifypwdAction(){
      session_start();
      $this->assign("user_no", $_SESSION['user_no']);
      $tpl = "user_modify_password.tpl";
      $this->getUserInfo();
      $this->assign("showmodifypwd", "active");
      $this->display($tpl);
    }
    function showmodifybasicinfoAction(){
      session_start();
      
      $this->assign("user_no", $_SESSION['user_no']);
      $tpl = "user_modify_basicinfo.tpl";
      $this->getUserInfo();
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
          echo "<script>alert('Old password is wrong!'); history.go(-1);</script>";
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
          echo "<script>alert('Modify Success!'); history.go(-1);</script>";
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
      $this->getUserInfo();
      $this->display($tpl);
      echo "<script>alert('Modify Success!'); history.go(-1);</script>";
      echo "<script language=\"javascript\">location.href='modify.php';</script>";
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
