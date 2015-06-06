<div class="panel panel-default">
    <div class="panel-heading">
        <div class="panel-title">Admin Info</div>
    </div>
  <div class="panel-body">
      <p class='text-primary'><!--{$user_name}-->(<!--{$user_no}-->)</p>
      <p class='text-primary'><!--{$user_tel}--></p>
      <p class='text-primary'><!--{$user_email}--></p>
  </div>
</div>


<div class='navbar' role="complementary">
    <label>Navigation</label>
    <nav id ="">
       <div class="list-group">
        <a href="../home/showPage.do" class="list-group-item <!--{$showPage}-->"> Home</a>
        <a href="../home/showAccount.do" class="list-group-item <!--{$showAccount}-->">Customer Query</a>
        <a href="../home/authorizeAccount.do" class="list-group-item <!--{$authorizeAccount}-->"><span class="badge"><!--{$author_acc_nums}--></span>Account Authorization</a>
        <a href="../home/cashAccount.do" class="list-group-item <!--{$cashAccount}-->">Account Deposit/Withdraw</a>
      </div>
    </nav>
</div>
