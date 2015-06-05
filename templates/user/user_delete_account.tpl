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
                        <label>Delete Account</label>
                    </div>
                    <div class="panel-body">
                      <form class="form-horizontal" action="delAcc.do" method="POST">
                        <table class="table table-striped">
                        <!-- On rows -->
                      <thead>  
                        <tr class="active">
                          <th align="center" width="10%">
                    #
                  </th>
                  <th align="center" width="70%">
                    Account Number
                  </th>
                  <th align="center" width="20%">
                    Operation
                  </th>
                </tr>
                </thead>
                <tbody>
                </tbody>
                <!-- 
                <tr>
                         <td><input type="text" class="form-control" id="no" name="no"></td>
                          <td><input type="text" class="form-control" id="acc_num" name="acc_num" ></td>
                          <td><button type="submit" class="btn btn-primary ">Delete</button></td>
                        </tr>

                        <tr class="success">
                         
                        </tr>
                        <tr class="warning">...</tr>
                        <tr class="danger">...</tr>
                        <tr class="info">...</tr>
-->

                       </table>
                     </form>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- /container -->
    <script type="text/javascript">
    function showAccTable(user_account,id){
        var tableBody = "";
        $.each(user_account,function(num,val){
            tableBody += '<tr><td class=\"num\">' + num + '</td>';
            $.each(val,function(k,v){
              tableBody += '<td>' + v + '</td>';
            });
            tableBody += '<td><button type=\"submit\" class=\"btn btn-primary \">Delete</button></td></tr>';
        });
        $('tbody',"#"+id).html(tableBody);
      }
    </script>
	<!-- ================== BEGIN BASE JS ================== -->
        <script src="../../plugins/jquery-1.11.3.min.js"></script>
	<script src="../../plugins/bootstrap-3.3.4/js/bootstrap.min.js"></script>
	<!-- ================== END BASE JS ================== -->
        <!-- ================== BEGIN PAGE LEVEL JS ================== -->
	<!-- ================== END PAGE LEVEL JS ================== -->
  </body>
</html>
