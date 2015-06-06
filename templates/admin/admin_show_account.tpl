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
    <!--{include file="admin_head.tpl"}-->
    <div class="container home_content">
        <div class='row'>
            <div class="col-md-3 sidebar-offcanvas">
             <!--{include file="admin_left_nav.tpl"}-->   
            </div>
            <div class="col-md-9">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <label>User Query</label>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                             <label class="control-label col-md-4 col-sm-4 ui-sortable" >User</label>
                             <div class ="col-md-6 col-sm-6 ui-sortable">
                                <select class=" form-control" id="query_user_id" name="query_user_id">
                                     <!--{html_options options=$user_names}-->
                                </select>
                             </div>
                            </div>
                             <div class='form-group'>
                                   <div class="col-md-12 col-sm-12 col-md-offset-4">
                                    <button type="submit" class="btn btn-primary " id="query">Submit</button>
                                   </div>
                            </div>
                        </div>
                    <table class="table table-striped" id="query_table">
                        <thead><tr><th>#</th><th>User Name</th><th>Account Number</th><th>Account Balance</th><th>Account State</th></tr></thead>
                        <tbody></tbody>
                    </table>
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
        <script>
            $('#query').click(function(){
                var data = { };
                data.user_id = $('#query_user_id').val();
                 $.ajax({
                    url:'ajaxShowAccount.do',
                    type:'get',
                    async:false,
                    data:data,
                    dataType:'json',
                    success:function(res){
                       console.log(res);
                          showTable(res, "query_table");
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
