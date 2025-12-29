<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>个人信息</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-info text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">我的信息卡</h5>
                    <i class="bi bi-person-vcard fs-4"></i>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span class="fw-bold">登录账户</span>
                        <span>${session_person.getUserAccount()}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span class="fw-bold">姓名</span>
                        <span>${session_person.getUserName()}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span class="fw-bold">性别</span>
                        <span>${session_person.getUserSex()}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span class="fw-bold">出生日期</span>
                        <span>${session_person.getUserBirthday()}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span class="fw-bold">身份证号码</span>
                        <span>${session_person.getUserIdCard()}</span>
                    </li>
                </ul>
                <div class="card-body text-end">
                    <button class="btn btn-warning text-dark" onclick="upPassword()">
                        <i class="bi bi-key"></i> 修改密码
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function upPassword(){
        // 保持原有的弹窗逻辑
        window.open("common.action?action=upPassword", "修改密码", "width=700,height=400,left=400,top=150,location=no");
    }
</script>
</body>
</html>