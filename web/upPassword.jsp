<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改密码</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">
    <div class="card shadow-sm">
        <div class="card-header bg-warning text-dark">
            <h5 class="mb-0">安全中心 - 修改密码</h5>
        </div>
        <div class="card-body">
            <form method="post" action="common.action?action=sureUpPassword" onsubmit="return checkThisFile()">

                <div class="mb-3">
                    <label for="userPassword" class="form-label">输入新密码：</label>
                    <input type="password" class="form-control" name="userPassword" id="userPassword" placeholder="请输入新密码">
                </div>

                <div class="mb-3">
                    <label for="a" class="form-label">再次输入密码：</label>
                    <input type="password" class="form-control" id="a" placeholder="请确认新密码">
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">提交修改</button>
                </div>

                <div class="mt-3 text-center">
                    <span class="text-danger fw-bold" id="error"></span>
                </div>
            </form>
        </div>
    </div>

    <script>
        function checkThisFile() {
            let userPassword = document.getElementById("userPassword").value;
            let a = document.getElementById("a").value;

            if (!a || !a.trim() || !userPassword || !userPassword.trim()) {
                document.getElementById("error").innerHTML = "请输入两次完整密码";
                return false;
            } else if(a != userPassword){
                document.getElementById("error").innerHTML = "两次密码不一致";
                return false;
            }
            return true;
        }
    </script>
</body>
</html>