<?php
class showaccounts_Controller extends Controller{
    function init(){
        $this->_Acc = Load::model("showaccounts", "bk_data");
        $this->_bankUser = Load::model("basic", "bk_data");
        $this->_transfer = Load::model("transfer", "bk_data");
    }
    
    public static $acc_state_map =  array(
            1 => "Normal",
            2 => "Authorize",
            0 => "Delete"
    );

    function showuseraccountsAction(){
        $tpl = "user_show_accounts.tpl";
        session_start();
        $this->getUserInfo();
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("showuseraccounts", "active");
        $this->display($tpl);
    }

    function ajaxShowUserAccountAction()
    {
      session_start();
      $user_id = $_SESSION['user_id'];
      $where=array();
      $where['user_id'] = $user_id;
      $user_acc_data = $this->_Acc->getAccountIdsByUsrIds($where);
      $acc_where = array();
      $result=array();
      if(empty($user_acc_data))
      {
        echo "No account";
        $result['flag']  = 0;  //no data
      }
      else{
        foreach($user_acc_data[$user_id] as $val){
            $acc_where['acc_id'][] = $val['acc_id'];
        }
        //var_dump($acc_where);
        $acc_data = $this->_Acc->getAccountInfoByIds($acc_where);
        //var_dump($acc_data);
        $res_data = array();
        $name_data=$this->_Acc->getUserNameByIds($where);
        $i = 0;
        //var_dump($name_data);
        foreach($user_acc_data[$user_id] as $val){
          //echo $val['acc_id'];
        //  var_dump($acc_data);
            $res_data[$i]['user_name']=$name_data;
        //    var_dump ($acc_data[$val['acc_id']]);
            $res_data[$i]['acc_no'] = $acc_data[$val['acc_id']]['acc_num'];
            $res_data[$i]['acc_balance'] = $acc_data[$val['acc_id']]['acc_balance'];
            $res_data[$i]['acc_state'] = self::$acc_state_map[$acc_data[$val['acc_id']]['acc_state']];
            $i++;
        }
        $result['flag'] = 1;
        $result['data'] = $res_data;
      }
      echo json_encode($result);


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
