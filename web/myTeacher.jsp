<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的老师</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container-fluid mt-3">
    <h3 class="mb-4 border-bottom pb-2">我的任课老师</h3>
    <div class="table-responsive">
        <table class="table table-hover table-bordered align-middle text-center shadow-sm">
            <thead class="table-primary">
            <tr>
                <th>老师账户</th>
                <th>老师姓名</th>
                <th>性别</th>
                <th>科目</th>
                <th>操作</th>
                <th>管理</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${arr}" var="person">
                <tr>
                    <td>${person.getUserAccount()}</td>
                    <td>${person.getUserName()}</td>
                    <td>${person.getUserSex()}</td>
                    <td>${person.getUserOtherName()}</td>
                    <td>
                        <button class="btn btn-primary btn-sm" onclick="goMyTeaTask('${person.getUserAccount()}')">
                            <i class="bi bi-journal-text"></i> 查看任务
                        </button>
                    </td>
                    <td>
                        <button class="btn btn-danger btn-sm" onclick="deleteThisPerson('${person.getUserAccount()}')">
                            <i class="bi bi-trash"></i> 删除
                        </button>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty arr}">
                <tr>
                    <td colspan="6" class="text-muted py-4">暂无数据，请先选择老师</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<script>
    function goMyTeaTask(teacherAccount) {
        window.location.href ="student.action?action=goMyTeaTask&teacherAccount="+teacherAccount;
    }

    function deleteThisPerson(teacherAccount) {
        if(confirm('确定要删除这位老师吗？')){
            window.location.href ="student.action?action=deleteMyTeacher&teacherAccount="+teacherAccount;
        }
    }
</script>
</body>
</html>