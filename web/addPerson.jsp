<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加人员</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">添加新用户</h4>
                </div>
                <div class="card-body">
                    <form method="post" action="man.action?action=addThisPerson" onsubmit="return checkThis()">

                        <div class="mb-3">
                            <label for="userName" class="form-label"><span class="text-danger">*</span> 姓名</label>
                            <input type="text" class="form-control" id="userName" name="userName">
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><span class="text-danger">*</span> 性别</label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="userSex" id="sexMale" value="男" checked>
                                    <label class="form-check-label" for="sexMale">男</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="userSex" id="sexFemale" value="女">
                                    <label class="form-check-label" for="sexFemale">女</label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="userBirthday" class="form-label"><span class="text-danger">*</span> 出生日期</label>
                            <input type="date" class="form-control" id="userBirthday" name="userBirthday">
                        </div>

                        <div class="mb-3">
                            <label for="userIdCard" class="form-label"><span class="text-danger">*</span> 身份证号码</label>
                            <input type="text" class="form-control" id="userIdCard" name="userIdCard">
                        </div>

                        <div class="mb-3">
                            <label for="userPhone" class="form-label"><span class="text-danger">*</span> 手机号码</label>
                            <input type="number" class="form-control" id="userPhone" name="userPhone">
                        </div>

                        <div class="mb-3">
                            <label for="userIdentify" class="form-label"><span class="text-danger">*</span> 角色</label>
                            <select class="form-select" id="userIdentify" name="userIdentify">
                                <option value="0">学生</option>
                                <option value="1">老师</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="nikeName" class="form-label"><span class="text-danger">*</span> 职务/科目</label>
                            <input type="text" class="form-control" id="nikeName" name="userOtherName" placeholder="例如：数学老师 或 三年二班">
                        </div>

                        <div class="mb-4">
                            <label for="userPassword" class="form-label"><span class="text-danger">*</span> 初始密码</label>
                            <input type="password" class="form-control" id="userPassword" name="userPassword">
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">保存信息</button>
                        </div>

                        <div class="mt-3 text-center">
                            <span class="text-danger" id="error">${tip}</span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function checkThis() {
        var fields = [
            {id: 'userName', msg: '请输入姓名'},
            {id: 'userBirthday', msg: '请输入出生日期'},
            {id: 'userIdCard', msg: '请输入身份证号码'},
            {id: 'userPhone', msg: '请输入手机号码'},
            {id: 'userPassword', msg: '请输入密码'}
        ];

        for (var i = 0; i < fields.length; i++) {
            var val = document.getElementById(fields[i].id).value;
            if (val === '') {
                alert(fields[i].msg);
                return false;
            }
        }
        return true;
    }
</script>
</body>
</html>