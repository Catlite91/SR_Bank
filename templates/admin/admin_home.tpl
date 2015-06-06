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

    <title>China Bank/Admin</title>

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
    <!--{include file="admin_head.tpl"}-->
    <div class="container home_content">
        <div class='row'>
            <div class="col-md-3 sidebar-offcanvas">
             <!--{include file="admin_left_nav.tpl"}-->   
            </div>
            <div class="col-md-9">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <label>Overview</label>
                    </div>
                    <div class="panel-body">
                    <div class="jumbotron">
                        <div class="container">
                        <h1>China Bank</h1>
                        <p>Bank of China，or Bank of China Limited in full, is one of China’s four state-owned commercial banks. 
                            Its businesses cover commercial banking, investment banking and insurance. 
                            Members of the group include BOC Hong Kong, BOC International, 
                            BOCG Insurance and other financial institutions.
                            The Bank provides a comprehensive range of high-quality financial services to individual and corporate customers as well as financial institutions worldwide. 
                            </p>
                            <p><img src="../../images/china_bank.jpg" class="img-thumbnail"></p>
                        <p><a class="btn btn-primary btn-lg" href="http://www.boc.cn/en/" target="_blank" role="button">Learn more</a></p>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- /container -->
    <!--{include file="admin_foot.tpl"}-->
	<!-- ================== BEGIN BASE JS ================== -->
        <script src="../../plugins/jquery-1.11.3.min.js"></script>
	<script src="../../plugins/bootstrap-3.3.4/js/bootstrap.min.js"></script>
	<!-- ================== END BASE JS ================== -->
        <!-- ================== BEGIN PAGE LEVEL JS ================== -->
	<!-- ================== END PAGE LEVEL JS ================== -->
  </body>
</html>
