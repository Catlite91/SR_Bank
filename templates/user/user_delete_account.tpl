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
                        <label>Delete Account</label>
                    </div>
                    <div class="panel-body">
                      <div class="form-horizontal" action="delAcc.do" method="POST">
                         <table class="table table-striped" id="acc_table">
                            <thead><tr><th>#</th><th>Account No.</th><th>Account Type</th><th>Operation</th></tr></thead>
                            <tbody>
                                <!--{foreach from=$acc_info key = i item=j}-->
                                <tr><td><!--{$i}--></td><td><!--{$j.acc_no}--></td><td><!--{$j.acc_type}--></td><td><a class="btn btn-primary delete_acc" href="#"  data-acc-id="<!--{$j.acc_id}-->"role="button"  data-toggle="modal" data-target="#myModal">Delete</a></td></tr>
                                <!--{/foreach}-->
                            </tbody>
                        </table>
                </div>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- /container -->
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">Delete Account</h4>
          </div>
          <div class="modal-body">
            <label class="text-danger" id="del_acc_id_last">Are You Sure?</label>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" id= "commit" class="btn btn-primary">Commit</button>
          </div>
        </div>
      </div>
    </div>
        <!--{include file="user_foot.tpl"}-->
	<!-- ================== BEGIN BASE JS ================== -->
        <script src="../../plugins/jquery-1.11.3.min.js"></script>
	<script src="../../plugins/bootstrap-3.3.4/js/bootstrap.min.js"></script>
	<!-- ================== END BASE JS ================== -->
        <!-- ================== BEGIN PAGE LEVEL JS ================== -->
        <script>
        $('.delete_acc').click(function(){
            $("#del_acc_id_last").attr("acc_id", $(this).attr('data-acc-id'));
        
        });
        $('#commit').click(function(){
          var data = { };
          data.acc_id = $('#del_acc_id_last').attr('acc_id');
          $.ajax({
            url:'delAcc.do',
            type:'get',
            async:false,
            data:data,
            dataType:'json',
            success: function(data){
                if(data.flag === 1){
                    window.location = "delAccount.do";
                }else{
                $('#del_acc_id_last').html(data.msg);
               }
            }
          });
        });
    </script>
	<!-- ================== END PAGE LEVEL JS ================== -->
  </body>
</html>
