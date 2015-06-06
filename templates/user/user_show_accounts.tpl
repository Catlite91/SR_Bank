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
    <link href="../../plugins/bootstrap-datepicker-1.4.0-dist/css/bootstrap-datepicker3.min.css" rel="stylesheet">
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
                        <label>My Accounts</label>
                    </div>
                    <div class="panel-body">
                    <table class="table table-striped" id="query_table">
                        <thead><tr><th>#</th><th>User No</th><th>Account No</th><th>Account Balance</th></tr></thead>
                        <tbody></tbody>
                    </table>
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
        <script>
            $(document).ready(function(){
                //console.log();
                 $.ajax({
                    url:'ajaxShowUserAccount.do',
                    type:'get',
                    async:false,
                    //data:data,
                    dataType:'json',
                    success:function(res){
                      console.log(res.flag);
                       console.log(res);
                       if(res.flag ==1){
                          showTable(res.data, "query_table");
                       }else{
                           $('tbody', "#query_table").html("No data");
                       }
                   }


                });
            });

            function showTable(data, id){
              var tableBody = "";
              $.each(data, function(key, val){
                tableBody += '<tr><td>' + key + '</td>';
                $.each(val, function(k,v){
                    tableBody += '<td>' + v + '</td>';
                });
                tableBody += '</tr>';
              });
              $('tbody', "#"+id).html(tableBody);
            }
        </script>
  </body>
</html>
