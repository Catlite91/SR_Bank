<?php /* Smarty version 2.6.26, created on 2015-06-04 05:42:50
         compiled from user_left_nav.tpl */ ?>

<div class="panel panel-default">
    <div class="panel-heading">
        <div class="panel-title">About</div>
    </div>
  <div class="panel-body">
      <p>This blog post shows a few different types of content that's 
          supported and styled with Bootstrap. Basic typography, images, and 
          code are all supported.</p>
  </div>
</div>


<div class='navbar' role="complementary">
    <label>Navigation</label>
    <nav id ="">
        <ul class="nav nav-pills nav-stacked">
            <li>
                <p>Individual Information Managemer</p>
                <ul class="nav nav-pills nav-stacked">
                    <li class="<?php echo $this->_tpl_vars['showT']; ?>
" ><a href="modify.do">Modify Basic Information</a></li>
                    <li class="<?php echo $this->_tpl_vars['showst']; ?>
" ><a href="modify.do">Modify Password</a></li>
                </ul>
            </li>
            <li>
                <p>Account Management</p>
                <ul class="nav nav-pills nav-stacked">
                    <li class="<?php echo $this->_tpl_vars['show']; ?>
" ><a href="modify.do">Add New Account</a></li>
                    <li class="<?php echo $this->_tpl_vars['show']; ?>
" ><a href="modify.do">Delete Account</a></li>
                    <li class="<?php echo $this->_tpl_vars['show']; ?>
" ><a href="modify.do">Loss Report</a></li>
                </ul>
            </li>
            <li>
                <p>Transfer Between Accounts</p>
                <ul class="nav nav-pills nav-stacked">
                    <li class="<?php echo $this->_tpl_vars['showTest']; ?>
" ><a href="../transfer/showTest.do">Test</a></li>
                    <li class="<?php echo $this->_tpl_vars['showAccountTransf']; ?>
" ><a href="../transfer/showAccountTransf.do">Transfer In Same Account</a></li>
                    <li class="<?php echo $this->_tpl_vars['showBankTransf']; ?>
" ><a href="../transfer/showBankTransf.do">Transfer In Same Bank</a></li>
                    <li class="<?php echo $this->_tpl_vars['showTransaction']; ?>
" ><a href="../transfer/showTransaction.do">Transactions Query</a></li>
                    <li class="<?php echo $this->_tpl_vars['showTransf']; ?>
" ><a href="../transfer/showTransf.do">DownLoad Transfer Infomation</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</div> 