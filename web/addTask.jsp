<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加任务</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="card shadow-sm">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0">发布新任务</h5>
        </div>
        <div class="card-body">
            <form action="tea.action?action=addTask" method="post" onsubmit="return checkAddTask()">
                <div class="mb-3">
                    <label for="taskName" class="form-label">题目/任务内容：</label>
                    <textarea class="form-control" id="taskName" name="taskName" rows="6" placeholder="请输入具体的任务描述..." style="font-size: 1.1rem;"></textarea>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-danger fw-bold" id="errorMsg">${tip}</span>
                    <button type="submit" class="btn btn-success px-5"><i class="bi bi-send"></i> 发布任务</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function checkAddTask(){
        var content = document.getElementById("taskName").value;
        if(!content || content.trim() === ""){
            alert("请输入任务内容");
            return false;
        }
        return true;
    }
</script>
</body>
</html>