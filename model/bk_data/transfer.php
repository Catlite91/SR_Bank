<?php

class bk_data_transfer_Model extends Model{
    function init(){
        $this->_bkTransferDB = Load::table("bk_account","db_cfg_bank");
    }
    
    function getTransferInfoByIds($where){
        $where['trans_state'] = 1;
        $data = $this->_bkTransferDB->fetchAll($where);
        
        return $data;
    }
}