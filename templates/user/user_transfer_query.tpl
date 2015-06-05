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
                        <div class="form-horizontal">
                        <div class="form-group">
                         <label class="control-label col-md-4 col-sm-4 ui-sortable" >Accounts</label>
                         <div class ="col-md-6 col-sm-6 ui-sortable">
                            <select class=" form-control" id="acc_id" name="acc_id">
                                 <!--{html_options options=$acc_ids}-->
                            </select>
                         </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4 col-sm-4 ui-sortable" >Currency</label>
                            <div class ="col-md-6 col-sm-6 ui-sortable">
                                <select class=" form-control" id="trans_currency">
                                    <option value="RMB"selected>RMB</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-4 col-sm-4 ui-sortable" >Time To Query</label>
                            <div class="col-md-6 col-sm-6 ui-sortable">
                                <div class='input-daterange input-group' id="datepicker">
                                    <input type="text" class="input-sm form-control" id="start_time" name="start_time" />
                                    <span class="input-group-addon">to</span>
                                    <input type="text" class="input-sm form-control" id="end_time" name="end_time" />
                                </div> 
                            </div>
                        </div>
                         <div class='form-group'>
                               <div class="col-md-12 col-sm-12 col-md-offset-4">
                                <button type="submit" class="btn btn-primary " id="query">Submit</button>
                               </div>
                        </div>
                        </div>
                    <table class="table table-striped" id="query_table">
                        <thead><tr><th>#</th><th>Account No</th><th>Transfer Time</th><th>Transfer Type</th><th>Transfer Amount</th></tr></thead>
                        <tbody></tbody>
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
        <<script src="../../plugins/bootstrap-datepicker-1.4.0-dist/js/bootstrap-datepicker.min.js"></script>
	<!-- ================== END PAGE LEVEL JS ================== -->
        <script>
            $(document).ready(function(){
                $(' .input-daterange').datepicker({
                    autoclose: true,
                    todayHighlight: true
                });
            });
            
            $('#query').click(function(){
                var data = { };
                data.acc_id = $('#acc_id').val();
                data.trans_currency = $('#trans_currency').val();
                data.start_time = $('#start_time').val();
                data.end_time = $('#end_time').val();
                console.log(data);
                 $.ajax({
                    url:'ajaxShowQueryResult.do',
                    type:'get',
                    async:false,
                    data:data,
                    dataType:'json',
                    success:function(res){
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
