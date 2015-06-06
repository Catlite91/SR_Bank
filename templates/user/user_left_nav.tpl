<div class="panel panel-default">
    <div class="panel-heading">
        <div class="panel-title">Customer Info</div>
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
        <ul class="nav nav-pills nav-stacked">
            <li>
                <p>Overview</p>
                <ul class="nav nav-pills nav-stacked">
                    <li class="<!--{$showPage}-->" ><a href="../home/showPage.do"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home Page</a></li>
                    <li class="<!--{$showuseraccounts}-->" ><a href="../showaccounts/showuseraccounts.do"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> My Accounts</a></li>
                </ul>
            </li>
            <li>
                <p>Individual Information Managemer</p>
                <ul class="nav nav-pills nav-stacked">
                    <li class="<!--{$showmodifybasicinfo}-->" ><a href="../modify/showmodifybasicinfo.do"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Modify Basic Information</a></li>
                    <li class="<!--{$showmodifypwd}-->" ><a href="../modify/showmodifypwd.do"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Modify Password</a></li>
                </ul>
            </li>
            <li>
                <p>Account Management</p>
                <ul class="nav nav-pills nav-stacked">
                    <li class="<!--{$showAddAccount}-->" ><a href="../account/addAccount.do"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add New Account</a></li>
                    <li class="<!--{$showDelAccount}-->" ><a href="../account/delAccount.do"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Delete Account</a></li>
                </ul>
            </li>
            <li>
                <p>Transfer Between Accounts</p>
                <ul class="nav nav-pills nav-stacked">
                    <li class="<!--{$showAccountTransf}-->" ><a href="../transfer/showAccountTransf.do"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> Transfer In Internal Account</a></li>
                    <li class="<!--{$showBankTransf}-->" ><a href="../transfer/showBankTransf.do"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> Transfer Between Accounts</a></li>
                    <li class="<!--{$showTransaction}-->" ><a href="../transfer/showTransaction.do"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Transactions Query</a></li>
                    <li class="<!--{$showDownloadTransaction}-->" ><a href="../transfer/showDownloadTransaction.do"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> DownLoad Bank Statement</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</div>
