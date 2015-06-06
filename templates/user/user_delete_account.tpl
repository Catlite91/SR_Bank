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
                      <form class="form-horizontal" action="delAcc.do" method="POST">
                        <table class="table table-striped" id="acc_table">
                        <!-- On rows -->
                      <thead>  
                        <tr class="active">
                          <th align="center" width="10%">
                    #
                  </th>
                  <th align="center" width="55%">
                    Account Number
                  </th>
                  <th align="center" width="15%">
                    Account Type
                  </th>
                  <th align="center" width="20%">
                    Operation
                  </th>
                </tr>
                </thead>
                <tbody>
                </tbody>


                       </table>
                     </form>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- /container -->
        <!--{include file="user_foot.tpl"}-->
    <script>
$(document).ready(function(){
                 $.ajax({
                    url:'delAccount.do',
                    type:'get',
                    async:false,
                    data:data,
                    dataType:'json',
                    success:function(res){
                       console.log(res);
                       if(res.flag ==1){
                          showTable(res.data, "acc_table");
                       }else{
                           $('tbody', "#acc_table").html("No data");
                       }
                   }
                });  
});

// $('#delBtn'),click(function(){
//   var data = { };
//   data.acc_id = $('#delBtn').val();
//   $.ajax({
//     url:'delAcc.do',
//     type:'get',
//     async:false,
//     data:data,
//     dataType:'json',
//     success:
//   });
// })
    function showAccTable(user_account,id){
        var tableBody = "";
        $.each(user_account,function(num,val){
            tableBody += '<tr><td class=\"num\">' + num + '</td>';
            $.each(val,function(k,v){
              tableBody += '<td>' + v + '</td>';
            });
            tableBody += '<td><button type=\"submit\" class=\"btn btn-primary \" id=\"delBtn\" value=\"\">Delete</button></td></tr>';
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
