<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生/教师管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .hero-header {
            background-image: url("static/picture.png");
            background-size: cover;
            background-position: center;
            height: 120px;
            color: white; /* 如果背景图太亮，建议加文字阴影 */
            text-shadow: 1px 1px 4px rgba(0,0,0,0.8);
        }
        .sidebar {
            min-height: calc(100vh - 160px);
        }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid hero-header d-flex align-items-end p-3 mb-3 shadow-sm">
    <h1 class="fw-bold m-0">教务管理系统</h1>
    <div class="ms-auto bg-white text-dark px-3 py-2 rounded shadow-sm opacity-75">
        <i class="bi bi-person-circle"></i> 当前用户: <strong>${session_person.userName}</strong>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 mb-4">
            <div class="list-group shadow-sm sidebar">
                <div class="list-group-item list-group-item-dark fw-bold">
                    <i class="bi bi-grid-fill"></i> 功能菜单
                </div>

                <c:if test="${session_person.getUserIdentify()==0}">
                    <a href="common.action?action=index" class="list-group-item list-group-item-action"><i class="bi bi-house"></i> 查看首页</a>
                    <a href="student.action?action=list" class="list-group-item list-group-item-action"><i class="bi bi-search"></i> 选择老师</a>
                    <a href="student.action?action=goMyTeacher" class="list-group-item list-group-item-action"><i class="bi bi-person-video3"></i> 我的老师</a>
                    <a href="common.action?action=goMyDetail" class="list-group-item list-group-item-action"><i class="bi bi-person-badge"></i> 我的信息</a>
                </c:if>

                <c:if test="${session_person.getUserIdentify()==1}">
                    <a href="common.action?action=index" class="list-group-item list-group-item-action"><i class="bi bi-house"></i> 查看首页</a>
                    <a href="tea.action?action=list" class="list-group-item list-group-item-action"><i class="bi bi-people"></i> 学生管理</a>
                    <a href="tea.action?action=goMyTask" class="list-group-item list-group-item-action"><i class="bi bi-list-check"></i> 任务管理</a>
                    <a href="tea.action?action=goAddTask" class="list-group-item list-group-item-action"><i class="bi bi-plus-circle"></i> 添加任务</a>
                    <a href="common.action?action=goMyDetail" class="list-group-item list-group-item-action"><i class="bi bi-person-badge"></i> 我的信息</a>
                </c:if>

                <c:if test="${session_person.getUserIdentify()==2}">
                    <a href="common.action?action=index" class="list-group-item list-group-item-action"><i class="bi bi-house"></i> 查看首页</a>
                    <a href="man.action?action=list" class="list-group-item list-group-item-action"><i class="bi bi-people-fill"></i> 人员管理</a>
                    <a href="man.action?action=goAddPerson" class="list-group-item list-group-item-action"><i class="bi bi-person-plus"></i> 人员添加</a>
                    <a href="common.action?action=goMyDetail" class="list-group-item list-group-item-action"><i class="bi bi-person-badge"></i> 我的信息</a>
                </c:if>

                <a href="outLogin" class="list-group-item list-group-item-action text-danger mt-2 border-top"><i class="bi bi-box-arrow-right"></i> 退出系统</a>
            </div>
        </div>

        <div class="col-md-10">
            <div class="card shadow-sm h-100 border-0">
                <div class="card-body">
                    <jsp:include page="${mainRight==null?'blank.jsp':mainRight}"></jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>