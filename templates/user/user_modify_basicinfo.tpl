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

    <title>China Bank</title>

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
                        <label>Modify Login Password</label>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal" action="modifybasicinfo.do" method="POST">
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Mobile Number</label>
                                <div class='col-md-6 col-sm-6 ui-sortable'>
                                    <input type="text" class="form-control" autocomplete="off" id="acc_no" name="mobile_phone">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Email Address</label>
                                <div class='col-md-6 col-sm-6 ui-sortable'>
                                    <input type="text" class="form-control" autocomplete="off" id="acc_no" name="Email">
                                </div>
                            </div>
                            <div class='form-group'>
                               <div class="col-md-12 col-sm-12 col-md-offset-4">
                               <button type="submit" class="btn btn-primary ">Submit</button>
                               <button type="cancel" class="btn btn-primary ">Cancel</button>
                           </div>
                </div>
                        </form>
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
