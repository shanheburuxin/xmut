<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>系统登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
        }
        .login-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        .login-header {
            background-color: #fff;
            padding: 2rem;
            text-align: center;
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card login-card">
                <div class="login-header pb-0">
                    <h2 class="fw-bold text-primary">教务管理系统</h2>
                    <p class="text-muted">请登录您的账户</p>
                </div>
                <div class="card-body p-4 pt-2">
                    <form action="userLogin" method="post" onsubmit="return checklogin()">

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="userAccount" name="userAccount" placeholder="Account">
                            <label for="userAccount"><i class="bi bi-person"></i> 账户</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="Password">
                            <label for="userPassword"><i class="bi bi-lock"></i> 密码</label>
                        </div>

                        <div class="mb-4">
                            <label class="form-label text-secondary small">验证码</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="verifyCode" name="verifyCode" placeholder="输入验证码">
                                <img id="verifyCodeImg" src="verifyCode" alt="验证码" onclick="this.src='verifyCode?'+Math.random()" style="cursor: pointer; height: 38px;" class="border ms-2 rounded">
                            </div>
                        </div>

                        <div class="d-grid gap-2 mb-3">
                            <button type="submit" class="btn btn-primary btn-lg">登录</button>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="register.jsp" class="text-decoration-none">注册新账户</a>
                            <span class="text-danger small" id="tip">${tip}</span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function checklogin(){
        let userAccount  = document.getElementById("userAccount").value;
        let userPassword = document.getElementById("userPassword").value;
        let verifyCode = document.getElementById("verifyCode").value;
        let tip = document.getElementById("tip");

        if(!userAccount || userAccount.trim()==""){
            tip.innerHTML= "账户不能为空";
            return false;
        }
        if(!userPassword || userPassword.trim()==""){
            tip.innerHTML= "密码不能为空";
            return false;
        }
        if(!verifyCode || verifyCode.trim()=="") {
            tip.innerHTML = "验证码不能为空";
            return false;
        }
        return true;
    }
</script>
</body>
</html>