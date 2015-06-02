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
        <link href="../css/signin.css" rel="stylesheet">
        <!-- ================== END PAGE LEVEL STYLE ================== -->
  </head>

  <body>

    <div class="container">
      <div><label><!--{$login_error}--></label></div>
      <form class="form-signin" action="login.do" method="POST">
        <h2 class="form-signin-heading">CHINA BANK</h2>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="text" id="user_id" name="user_id" class="form-control" placeholder="USER NAME/PHONE NUMBER" required autofocus>
        <label for="user_pwd" class="sr-only">Password</label>
        <input type="password" id="user_pwd" name="user_pwd" class="form-control" placeholder="PASSWORD" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>
      <div class="form-signin">
          <label>NO ACCOUNT?</label>
        <button class="btn btn-lg btn-primary btn-block" type="" id="sign_up">Sign up</button>   
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
