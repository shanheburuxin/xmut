<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的任务</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<div class="container-fluid mt-3">
    <h4 class="mb-3 text-secondary">已发布任务管理</h4>
    <div class="table-responsive bg-white shadow-sm rounded">
        <table class="table table-hover align-middle text-center mb-0">
            <thead class="table-dark">
            <tr>
                <th>任务账户</th>
                <th>任务内容 (摘要)</th>
                <th>发布时间</th>
                <th>删除</th>
                <th>详细</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${arr}" var="task">
                <tr>
                    <td><span class="badge bg-secondary">${task.getTaskAccount()}</span></td>
                    <td class="text-start text-truncate" style="max-width: 300px;">${task.getTaskName()}</td>
                    <td>${task.getTaskDate()}</td>
                    <td>
                        <button class="btn btn-outline-danger btn-sm" onclick="deleteThisTask('${task.getTaskAccount()}')">
                            <i class="bi bi-trash"></i> 删除
                        </button>
                    </td>
                    <td>
                        <button class="btn btn-outline-info btn-sm" onclick="skimDetail('${task.getTaskAccount()}')">
                            <i class="bi bi-eye"></i> 查看
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function deleteThisTask(taskAccount) {
        if(confirm("确定要删除该任务吗？这将删除所有学生的作答记录。")){
            window.location.href="tea.action?action=deleteThisTask&taskAccount="+taskAccount;
        }
    }

    function skimDetail(taskAccount){
        window.location.href = "tea.action?action=goSkimDetail&taskAccount="+taskAccount;
    }
</script>
</body>
</html>