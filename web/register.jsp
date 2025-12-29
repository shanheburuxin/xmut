<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light py-5">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h4 class="mb-0">新用户注册</h4>
                </div>
                <div class="card-body p-4">
                    <form method="post" action="registerUser" onsubmit="return checkThis()">

                        <div class="row g-3">
                            <div class="col-12">
                                <label for="userName" class="form-label">姓名 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="userName" name="userName">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">性别 <span class="text-danger">*</span></label>
                                <div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="userSex" value="男" checked>
                                        <label class="form-check-label">男</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="userSex" value="女">
                                        <label class="form-check-label">女</label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="userIdentify" class="form-label">角色 <span class="text-danger">*</span></label>
                                <select class="form-select" id="userIdentify" name="userIdentify">
                                    <option value="0">学生</option>
                                    <option value="1">老师</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label for="userBirthday" class="form-label">出生日期 <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="userBirthday" name="userBirthday">
                            </div>

                            <div class="col-md-6">
                                <label for="userPhone" class="form-label">手机号码 <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="userPhone" name="userPhone">
                            </div>

                            <div class="col-12">
                                <label for="userIdCard" class="form-label">身份证号码 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="userIdCard" name="userIdCard">
                            </div>

                            <div class="col-12">
                                <label for="nikeName" class="form-label">职务/科目 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="nikeName" name="userOtherName" placeholder="例如：某科老师/学生">
                            </div>

                            <div class="col-md-6">
                                <label for="userPassword" class="form-label">密码 <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="userPassword" name="userPassword">
                            </div>

                            <div class="col-md-6">
                                <label for="rUserPassword" class="form-label">确认密码 <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="rUserPassword" name="rUserPassword">
                            </div>

                            <div class="col-12">
                                <label for="verifyCode" class="form-label">验证码 <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="verifyCode" name="verifyCode">
                                    <img id="verifyCodeImg" src="verifyCode" alt="验证码" onclick="this.src='verifyCode?'+Math.random()" class="ms-2 border rounded" style="cursor: pointer;">
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 text-center">
                            <span class="text-danger d-block mb-2" id="error">${tip}</span>
                            <button type="submit" class="btn btn-primary w-50">立即注册</button>
                            <div class="mt-2">
                                <a href="userLogin.jsp" class="text-decoration-none">已有账号？返回登录</a>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function checkThis() {
        let userName = document.getElementById("userName").value;
        let userIdCard = document.getElementById("userIdCard").value;
        let nikeName = document.getElementById("nikeName").value;
        let userPassword = document.getElementById("userPassword").value;
        let userPhone = document.getElementById("userPhone").value;
        let rUserPassword = document.getElementById("rUserPassword").value;
        let verifyCode = document.getElementById("verifyCode").value;
        let errorSpan = document.getElementById("error");

        if (!userName.trim()) { errorSpan.innerHTML = "姓名不能为空"; return false; }
        if (!userIdCard.trim()) { errorSpan.innerHTML = "身份证号码不能为空"; return false; }
        if (!userPhone.trim()) { errorSpan.innerHTML = "手机号码不能为空"; return false; }
        if (!nikeName.trim()) { errorSpan.innerHTML = "职称不能为空"; return false; }
        if (!userPassword.trim()) { errorSpan.innerHTML = "密码不能为空"; return false; }
        if (!rUserPassword.trim()) { errorSpan.innerHTML = "确认密码不能为空"; return false; }
        if (!verifyCode.trim()) { errorSpan.innerHTML = "验证码不能为空"; return false; }

        let reg1 = /(^\d{18}$)||(^\d{17}(\d|X|x)$)/;
        let reg2 = /(^\d{11}$)/;

        if(!reg1.test(userIdCard)){
            alert("身份证输入不合法");
            return false;
        }
        if(!reg2.test(userPhone)){
            alert("手机号输入不合法");
            return false;
        }
        if (rUserPassword != userPassword) {
            errorSpan.innerHTML = "两次密码不相同";
            return false;
        }
        return true;
    }
</script>
</body>
</html>