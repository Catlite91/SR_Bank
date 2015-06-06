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
    <link href="../../css/docs.min.css" rel="stylesheet">
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
                        <label>Transfer In Internal Account</label>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Roll-in Account</label>
                                <div class ="col-md-6 col-sm-6 ui-sortable">
                                    <select class=" form-control" id="acc_id" name="acc_id">
                                        <!--{html_options options=$acc_ids}-->
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Currency</label>
                                <div class ="col-md-6 col-sm-6 ui-sortable">
                                    <select class=" form-control" id="trans_currency" name="trans_currency">
                                        <option value="RMB" selected>RMB</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Sum</label>
                                <div class='col-md-6 col-sm-6 ui-sortable input-group'>
                                    <input type="text" class="form-control" id="trans_amount" name="trans_amount">
                                     <span class="input-group-addon">.00</span>
                                     <label class="col-md-2 col-sm-2 ui-sortable" id="label_acc_balance"></label>
                                     <input type="hidden" id="acc_balance" data-balance = "<!--{$acc_balance}-->" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Message</label>
                                <div class='col-md-6 col-sm-6 ui-sortable'>
                                    <input type="text" class="form-control" id="trans_message" name="trans_message">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-4 col-sm-4 ui-sortable" >Roll-out Account</label>
                                <div class ="col-md-6 col-sm-6 ui-sortable">
                                    <select class=" form-control" name="trans_acc_id" id="trans_acc_id">
                                        <!--{html_options options=$trans_acc_ids}-->
                                    </select>
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
    <!--{include file="user_foot.tpl"}-->
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
            <div class="form-group">
              <label class="" for="acc_pwd">Password:</label>
              <div class="input-group">
                <input type="password" class="form-control" id="acc_pwd" name="acc_pwd" placeholder="" />
              </div>
            </div>
               <label class="text-danger" id="pwd_error"></label>
          </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" id= "commit" class="btn btn-primary">Commit</button>
          </div>
        </div>
      </div>
    </div>

	<!-- ================== BEGIN BASE JS ================== -->
        <script src="../../plugins/jquery-1.11.3.min.js"></script>
	<script src="../../plugins/bootstrap-3.3.4/js/bootstrap.min.js"></script>
	<!-- ================== END BASE JS ================== -->
        <!-- ================== BEGIN PAGE LEVEL JS ================== -->
        <script type="text/javascript">
            $(document).ready(function() {
               var data = $('#acc_balance').attr('data-balance');
               var cols = data.split('|');
               var first_curr = cols[0].split("_")[0];
               $('#acc_balance').removeData();
               for(var i = 0; i< cols.length-1; i++){
                   var temp = cols[i].split("_");
                   $('#acc_balance').data(temp[0], temp[1]);
               }
               $("#label_acc_balance").html("Currency:"+ $('#acc_balance').data(first_curr));
             });
             $('#acc_id').change(function(){
                 var acc_id = $(this).children('option:selected').val();
                 $("#label_acc_balance").html("Currency:"+ $('#acc_balance').data(acc_id));
            });
            
            $('#trans_amount').change(function(){
                var trans_amount = $(this).val();
                var currency = $("#label_acc_balance").html().substring(9);
               if(parseInt(trans_amount) > parseInt(currency)){
                 $(this).parent().removeClass("has-success");
                 $(this).parent().addClass("has-error");
               }else{
                   $(this).parent().removeClass("has-error");
                   $(this).parent().addClass("has-success");
               }
                
            });
            
            $('#commit').click(function(){
                var data = { };
                data.acc_pwd = $('#acc_pwd').val();
                data.acc_id = $('#acc_id').val();
                data.trans_acc_id = $('#trans_acc_id').val();
                data.trans_amount = $('#trans_amount').val();
                data.trans_currency = $('#trans_currency').val();
                data.trans_message = $('#trans_message').val();
                $.ajax({
                    url:'ajaxAccountTransf.do',
                    type:'get',
                    async:false,
                    data:data,
                    dataType:'json',
                    success:function(data){
                        if(data.flag === 1){
                            $('.modal-body').html("<h3>"+data.msg+"</h3><em>waiting......</em>");
                             setTimeout(function(){
                                 window.location = "showAccountTransfResult.do";
                             },1000);
                        }else if(data.flag === 2){
                             $('#pwd_error').html(data.msg);
                        }else{
                            $('#pwd_error').html(data.msg);
                        }
                    }
                });
            });
        </script>
	<!-- ================== END PAGE LEVEL JS ================== -->
  </body>
</html>
