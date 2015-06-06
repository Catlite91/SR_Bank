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
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Account Number</label>
                                <div class='col-md-6 col-sm-6 ui-sortable'>
                                    <input type="text" class="form-control" id="acc_num" name="acc_num">
                                </div>
                                <label class="col-md-2 col-sm-2 ui-sortable" id="label_acc_num"></label>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Currency</label>
                                <div class ="col-md-6 col-sm-6 ui-sortable">
                                    <select class=" form-control" id="trans_type" name="trans_type">
                                        <option value="5"selected>Deposit</option>
                                         <option value="6">WithDraw</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Sum</label>
                                <div class='col-md-6 col-sm-6 ui-sortable'>
                                    <div class='input-group'>
                                        <input type="text" class="form-control" id="trans_amount" name="trans_amount">
                                         <span class="input-group-addon">.00</span>
                                         <label class="col-md-2 col-sm-2 ui-sortable" id="label_acc_balance"></label>
                                    </div>
                                </div>
                            </div>
   
                            <div class='form-group'>
                               <div class="col-md-12 col-sm-12 col-md-offset-4">
                                <button type="submit" class="btn btn-primary " data-toggle="modal" data-target="#myModal">Submit</button>
                                <button type="cancel" class="btn btn-primary ">Cancel</button>
                               </div>
                            </div>
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
            <h4 class="modal-title" id="myModalLabel">Account Password</h4>
          </div>
          <div class="modal-body">
          <form class="form-inline">
              <label class='text-warning' id="pwd_error">Are You Sure?</label>
          </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" id= "commit" class="btn btn-primary">Commit</button>
          </div>
        </div>
      </div>
    </div>
    <!--{include file="admin_foot.tpl"}-->
	<!-- ================== BEGIN BASE JS ================== -->
        <script src="../../plugins/jquery-1.11.3.min.js"></script>
	<script src="../../plugins/bootstrap-3.3.4/js/bootstrap.min.js"></script>
	<!-- ================== END BASE JS ================== -->
        <!-- ================== BEGIN PAGE LEVEL JS ================== -->
        <script>
            $('#acc_num').change(function(){
                var data = { };
                data.acc_num = $(this).val();
                 $.ajax({
                    url:'ajaxShowAccountInfo.do',
                    type:'get',
                    async:false,
                    data:data,
                    dataType:'json',
                    success:function(data){
                        if(data.user_no == 0){
                          $("#label_acc_num").html("Account Not Exist");
                          $("#acc_num").parent().addClass("has-error");
                          $("#acc_num").parent().removeClass("has-success");
                        }else{
                          $("#label_acc_num").html(data.user_no);
                          $('#label_acc_num').attr('user_id', data.user_id);
                          $("#acc_num").parent().removeClass("has-error");
                          $("#acc_num").parent().addClass("has-success");
                          $("#label_acc_balance").html("Currency:"+data.acc_balance);
                        }
                    }
                });
            });
            
            $('#commit').click(function(){
               var data = { };
               data.acc_num = $("#acc_num").val();
               data.user_id = $('#label_acc_num').attr("user_id");
               data.trans_amount = $('#trans_amount').val();
               data.trans_type = $("#trans_type").val();
               console.log(data);
               $.ajax({
                    url:'submitCashAccount.do',
                    type:'get',
                    async:false,
                    data:data,
                    dataType:'json',
                    success:function(data){
                        if(data.flag === 1){
                            $('.modal-body').html("<h3>"+data.msg+"</h3><em>waiting......</em>");
                             setTimeout(function(){
                                 window.location = "cashAccount.do";
                             },1000);
                        }else if(data.flag === 2){
                             $('#pwd_error').html(data.msg);
                        }
                    }
               });
            //submitCashAccount
            });
        </script>
	<!-- ================== END PAGE LEVEL JS ================== -->
  </body>
</html>
