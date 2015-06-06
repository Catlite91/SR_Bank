<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Fixed Top Navbar Example for Bootstrap</title>

    <!-- ================== BEGIN BASE CSS STYLE ================== -->
    <link href="../../plugins/bootstrap-3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <!-- ================== END BASE CSS STYLE ================== -->
    
    <!-- ================== BEGIN PAGE LEVEL STYLE ================== -->
    <style>
       .home_content{
           margin-top: 100px;
       } 
    </style>
    <!-- ================== END PAGE LEVEL STYLE ================== -->
  </head>

  <body>
    <!--{include file="user_head.tpl"}-->
    <div class="container home_content">
        <div class='row'>
            <div class="col-md-3 sidebar-offcanvas">
             <!--{include file="user_left_nav.tpl"}-->   
            </div>
            <div class="col-md-9">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <label>Transfer In Same Account</label>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >User name</label>
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" ><em><!--{$user_no}--></em></label>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Account Number</label>
                                <label class="control-label col-md-4 col-sm-4" ><em><!--{$acc_no}--></em></label>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Transfer Account Number</label>
                                <label class="control-label col-md-4 col-sm-4 " ><em><!--{$trans_acc_no}--></em></label>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Transfer Type</label>
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" ><em><!--{$trans_type}--></em></label>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Transfer Currency</label>
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" ><em><!--{$trans_currency}--></em></label>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Transfer Amount</label>
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" ><em><!--{$trans_amount}--></em></label>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Transfer Time</label>
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" ><em><!--{$trans_time}--></em></label>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Transfer Message</label>
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" ><em><!--{$trans_message}--></em></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- /container -->
    <!--{include file="user_foot.tpl"}-->
	<!-- ================== BEGIN BASE JS ================== -->
        <script src="../../plugins/jquery-1.11.3.min.js"></script>
	<script src="../../plugins/bootstrap-3.3.4/js/bootstrap.min.js"></script>
	<!-- ================== END BASE JS ================== -->
        <!-- ================== BEGIN PAGE LEVEL JS ================== -->
	<!-- ================== END PAGE LEVEL JS ================== -->
  </body>
</html>
