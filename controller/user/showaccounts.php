<?php
class showaccounts_Controller extends Controller{
    function init(){
        $this->_Acc = Load::model("showaccounts", "bk_data");
        $this->_bankUser = Load::model("basic", "bk_data");
    }

    function showuseraccountsAction(){
        $tpl = "user_show_accounts.tpl";
        session_start();
        $this->assign("user_no", $_SESSION['user_no']);
        $this->assign("showuseraccounts", "active");
        $this->display($tpl);
    }
    function testAction()
    {
      echo "<script>alert('testAction'); history.go(-1);</script>";
    }
    function ajaxShowUserAccountAction()
    {
      session_start();
      $user_id = $_SESSION['user_id'];
      $where=array();
      $user_acc_data = $this->_Acc->getAccountIdsByUsrIds($where,$user_id);
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
        $name_data=$this->_Acc->getUserNameByIds($where,$user_id);
        $i = 0;
        //var_dump($name_data);
        foreach($user_acc_data[$user_id] as $val){
          //echo $val['acc_id'];
        //  var_dump($acc_data);
            $res_data[$i]['user_name']=$name_data;
        //    var_dump ($acc_data[$val['acc_id']]);
            $res_data[$i]['acc_no'] = $acc_data[$val['acc_id']]['acc_num'];
            $res_data[$i]['acc_balance'] = $acc_data[$val['acc_id']]['acc_balance'];
            $i++;
        }
        $result['flag'] = 1;
        $result['data'] = $res_data;
      }
      echo json_encode($result);


    }


}
