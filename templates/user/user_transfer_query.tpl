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
    <link href="../../css/docs.min.css" rel="stylesheet">
    <style>
       .home_content{
           margin-top: 200px;
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
                        <label>Transactions Query</label>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal">
                        <div class="form-group">
                         <label class="control-label col-md-4 col-sm-4 ui-sortable" >Account To Pay</label>
                         <div class ="col-md-6 col-sm-6 ui-sortable">
                             <select class=" form-control">
                                 <option value="M"selected>6233002302312312</option>
                                 <option value="F">6233123123123</option>
                             </select>
                         </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4 col-sm-4 ui-sortable" >Currency</label>
                            <div class ="col-md-6 col-sm-6 ui-sortable">
                                <select class=" form-control">
                                    <option value="M"selected>RMB</option>
                                    <option value="F">USD</option>
                                    <option value="F">EUR</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4 col-sm-4 ui-sortable" >Time To Query</label>
                            <div class ="col-md-6 col-sm-6 ui-sortable">
                                <select class=" form-control">
                                    <option value="M"selected>RMB</option>
                                    <option value="F">USD</option>
                                    <option value="F">EUR</option>
                                </select>
                            </div>
                        </div>
                         <div class='form-group'>
                               <div class="col-md-12 col-sm-12 col-md-offset-4">
                                <button type="submit" class="btn btn-primary " data-toggle="modal" data-target="#myModal">Submit</button>
                               </div>
                        </div>
                        </form>
                                    <table class="table table-striped">
                <thead>
                  <tr>
                    <th>#</th><th>First Name</th><th>Last Name</th><th>Username</th>
                  </tr>
                </thead>
                <tbody>
                  <tr><th scope="row">1</th><td>Mark</td><td>Otto</td><td>@mdo</td></tr>
                  <tr><th scope="row">2</th><td>Jacob</td> <td>Thornton</td><td>@fat</td></tr>
                  <tr><th scope="row">2</th><td>Jacob</td> <td>Thornton</td><td>@fat</td></tr>
                </tbody>
            </table>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- /container -->
	<!-- ================== BEGIN BASE JS ================== -->
        <script src="../../plugins/jquery-1.11.3.min.js"></script>
	<script src="../../plugins/bootstrap-3.3.4/js/bootstrap.min.js"></script>
	<!-- ================== END BASE JS ================== -->
        <!-- ================== BEGIN PAGE LEVEL JS ================== -->
	<!-- ================== END PAGE LEVEL JS ================== -->
  </body>
</html>
