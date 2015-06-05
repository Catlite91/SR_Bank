<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>BANK OF CHINA/LOGIN</title>

    <!-- Bootstrap core CSS -->
   
        <!-- ================== BEGIN BASE CSS STYLE ================== -->
        <link href="../plugins/bootstrap-3.3.4/css/bootstrap.min.css" rel="stylesheet">
        <!-- ================== END BASE CSS STYLE ================== -->

        <!-- ================== BEGIN PAGE LEVEL STYLE ================== -->
        <style>
            .sign-up{
                margin-top: 200px;
            }
        </style>
        <!-- ================== END PAGE LEVEL STYLE ================== -->
  </head>

  <body>
  
    <div class="container-fluid sign-up">
        <div class="row col-md-6 col-sm-6 ui-sortable col-md-offset-3">
        <div class="panel panel-primary">
            <div class="panel-heading">Register</div>
            <div class ="panel-body">

            <form class='form-horizontal' action="signUp.do" method="POST">
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 ui-sortable" >User Number</label>
                    <div class='col-md-6 col-sm-6 ui-sortable'>
                        <input type="text" class="form-control" id="user_no" name="user_no" required autofocus>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 ui-sortable" >User Name</label>
                    <div class='col-md-6 col-sm-6 ui-sortable'>
                        <input type="text" name = "user_name" id="user_name" class="form-control" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 ui-sortable" >User Identity</label>
                    <div class='col-md-6 col-sm-6 ui-sortable'>
                        <input type="text" class="form-control" id="user_identity" name=" user_identity" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 ui-sortable" >Gender</label>
                    <div class ="col-md-6 col-sm-6 ui-sortable">
                        <select class=" form-control" id="user_gender" name="user_gender">
                            <option value="M"selected>Male</option>
                            <option value="F">Female</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 ui-sortable" >Phone Number</label>
                    <div class='col-md-6 col-sm-6 ui-sortable'>
                        <input type="text" class="form-control" id="user_tel" name="user_tel" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 ui-sortable" >Email Address</label>
                    <div class='col-md-6 col-sm-6 ui-sortable'>
                        <input type="text" class="form-control" id="user_email"
                        name="user_email">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 ui-sortable" >Password</label>
                    <div class='col-md-6 col-sm-6 ui-sortable'>
                        <input type="password" class="form-control" id="user_pwd" name="user_pwd" placeholder="PASSWORD" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 ui-sortable" >Password Again</label>
                    <div class='col-md-6 col-sm-6 ui-sortable'>
                        <input type="password" class="form-control" id="user_repwd"
                        name="user_repwd" placeholder="PASSWORD" required>
                    </div>
                </div>
                <div class='form-group'>
                    <div class="col-md-12 col-sm-12 col-md-offset-4">
                    <button type="submit" class="btn btn-primary ">Submit</button>
                    <button type="cancel" class="btn btn-primary ">Cancel</button>
                    </div>
                </div>
            </form>
            </div>
            </div>
        </div>
    </div> <!-- /container -->
    <!-- ================== BEGIN BASE JS ================== -->
        <script src="../plugins/jquery-1.11.3.min.js"></script>
    <script src="../plugins/bootstrap-3.3.4/js/bootstrap.min.js"></script>
    <!-- ================== END BASE JS ================== -->
    
    <!-- ================== BEGIN PAGE LEVEL JS ================== -->
    <!-- ================== END PAGE LEVEL JS ================== -->
        <script>
            $('#sign_up').click(function(event){
                window.location = "sign.do";
            });
        </script>
  </body>
</html>