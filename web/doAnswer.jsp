<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>学生作答</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">任务作答</h5>
        </div>
        <div class="card-body">
            <form action="student.action?action=dealAnswer&taskAccount=${taskAccount}" method="post" enctype="multipart/form-data" onsubmit="return isDeal()">

                <div class="mb-3">
                    <label class="form-label fw-bold">作答内容：</label>
                    <textarea name="answer" class="form-control" rows="8" placeholder="请输入你的答案..."></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">上传附件：</label>
                    <input type="file" name="uploadFile" class="form-control" />
                    <div class="form-text">支持的文件类型：doc, docx, pdf, txt, jpg, png</div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary px-5">提交答案</button>
                    <button type="button" class="btn btn-secondary ms-2" onclick="history.back()">返回</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    function isDeal() {
        // 这里可以添加更详细的校验，比如文件大小限制
        return confirm("确定要提交吗？");
    }
</script>
</body>
</html>